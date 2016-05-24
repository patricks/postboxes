require 'sqlite3'

module Postboxes
  class Importer
    
    def initialize
      @postboxes = []
      @database_name = DB_NAME
    end
    
    def import(database_name)
      unless database_name.nil?
        @database_name = database_name
      end

      convert_to_osm
      
      File.open('postboxes_austria.osm', 'w') { |file| file.write("#{xml_header}\n#{postboxes_to_osm}#{xml_footer}") }
    end
    
    def xml_header
      "<?xml version='1.0' encoding='UTF-8'?>\n<osm version='0.6' upload='true' generator='Postboxes'>"
    end
    
    def xml_footer
      "</osm>"
    end
    
    def postboxes_to_osm
      output_string = ""
      
      @postboxes.each do |postbox|
        output_string << "#{postbox.to_osm}\n"
      end
      
      return output_string
    end
    
    def convert_to_osm
      begin
          db = SQLite3::Database.open @database_name
          db.results_as_hash = true
          
          # this query currently only shows postboxes in linz
          #rows = db.execute "SELECT * FROM zsubsidiary WHERE zcity = 'Linz' AND ztype = 'Briefkasten'"
          rows = db.execute "SELECT * FROM zsubsidiary WHERE ztype = 'Briefkasten'"
          
          id_counter = -10

          rows.each do |row|
            postbox = Postbox.new(row['ZLATITUDE'], row['ZLONGITUDE'], row['ZPOSTALCODE'], id_counter)
            @postboxes << postbox
            id_counter -= 1
          end
          
          puts "found #{@postboxes.count} postboxe(s)"
      rescue SQLite3::Exception => e 
          puts "Exception occurred"
          puts e
      ensure
          db.close if db
      end
    end
  end
end
