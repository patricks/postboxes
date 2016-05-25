module Postboxes
  # Postbox model class
  class Postbox
    def initialize(latitude, longitude, postalcode, id)
      @latitude = latitude
      @longitude = longitude
      @postalcode = postalcode
      @id = id
    end

    def to_osm
      # add a indent of 2 spaces
      "  <node id='#{@id}' lat='#{@latitude}' lon='#{@longitude}'>\n"\
      "    <tag k='amenity' v='post_box' />\n"\
      "    <tag k='postal_code' v='#{@postalcode}' />\n"\
      "  </node>\n"
    end
  end
end
