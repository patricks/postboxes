Gem::Specification.new do |s|
  s.name        = 'postboxes'
  s.version     = '0.0.1'
  s.date        = '2016-05-20'
  s.summary     = "Imports postbox items."
  s.description = "Imports postbox items from a sqlite database, which is provided from the iOS Post app and creates a osm data file."
  s.authors     = ["Patrick Steiner"]
  s.email       = 'patrick@helmsdeep.at'
  s.homepage    = 'https://patricks.github.io'
  s.license     = 'MIT'
  s.files       = ["lib/postboxes.rb", "lib/postboxes/importer.rb", "lib/postboxes/postbox.rb"]
  s.executables << 'create_postboxes_osm_file'
end
