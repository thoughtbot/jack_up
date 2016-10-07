$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'jack_up/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'jack_up'
  s.version     = JackUp::VERSION
  s.authors     = ['Josh Steiner', 'Josh Clayton']
  s.email       = ['josh@jsteiner.me', 'jclayton@thoughtbot.com']
  s.homepage    = 'http://github.com/thoughtbot/jack_up'
  s.summary     = 'Easy AJAX file uploading in Rails'
  s.description = 'Easy AJAX file uploading in Rails'
  s.files = Dir['lib/**/*'] + ['LICENSE', 'Rakefile', 'README.md']
  s.add_dependency 'rails', '~> 5.0'
end
