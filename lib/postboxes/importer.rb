require 'sqlite3'

module Postboxes
  # Importer class
  class Importer
    def initialize
      @postboxes = []
      @database_name = DB_NAME
    end

    def import(database_name)
      @database_name = database_name unless database_name.nil?

      connect_database
      convert_to_osm if @db

      File.open('postboxes_austria.osm', 'w') do |file|
        file.write("#{xml_header}#{postboxes_to_osm}#{xml_footer}")
      end

      puts "Found #{@postboxes.count} postbox(es)"
    end

    ### PRIVATE ###
    private

    def xml_header
      "<?xml version='1.0' encoding='UTF-8'?>\n"\
      "<osm version='0.6' upload='true' generator='Postboxes'>\n"
    end

    def xml_footer
      '</osm>'
    end

    def postboxes_to_osm
      output_string = ''

      @postboxes.each do |postbox|
        output_string << postbox.to_osm
      end

      output_string
    end

    def connect_database
      @db = SQLite3::Database.open @database_name
      @db.results_as_hash = true
    end

    def add_postbox_from_row(row, random_id)
      postbox = Postbox.new(
        row['ZLATITUDE'],
        row['ZLONGITUDE'],
        row['ZPOSTALCODE'],
        random_id
      )

      @postboxes << postbox
    end

    def convert_to_osm
      rows = @db.execute "SELECT * FROM zsubsidiary WHERE ztype = 'Briefkasten'"

      id_counter = -10

      rows.each do |row|
        # create new postbox item
        add_postbox_from_row(row, id_counter)

        id_counter -= 1
      end
    rescue SQLite3::Exception => e
      puts "Exception occurred: #{e}"
    ensure
      @db.close if @db
    end
  end
end
