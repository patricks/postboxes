module Postboxes
  class Postbox
    def initialize(latitude, longitude, postalcode, id)
      @latitude = latitude
      @longitude = longitude
      @postalcode = postalcode
      @id = id
    end
  
    def to_osm
      "<node id='#{@id}' lat='#{@latitude}' lon='#{@longitude}'><tag k='amenity' v='post_box' /><tag k='postal_code' v='#{@postalcode}' /></node>"
    end
  end
end