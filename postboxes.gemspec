lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'postboxes'

Gem::Specification.new do |s|
  s.name        = 'postboxes'
  s.version     = Postboxes::VERSION
  s.authors     = ['Patrick Steiner']
  s.email       = 'patrick@helmsdeep.at'
  s.description = 'Imports postbox items from a sqlite database, which is \
                   provided from the iOS Post app and creates a osm data file.'
  s.summary     = 'Imports postbox items.'
  s.homepage    = 'https://github.com/patricks/postboxes'
  s.license     = 'MIT'

  s.files       = [
    'lib/postboxes.rb',
    'lib/postboxes/importer.rb',
    'lib/postboxes/postbox.rb'
  ]

  s.executables = 'create_postboxes_osm_file'

  s.add_runtime_dependency 'sqlite3', '~> 1.3', '>= 1.3.11'
end
