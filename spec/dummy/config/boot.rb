gemfile = File.expand_path('../../../../Gemfile', __FILE__)

if File.exist?(gemfile)
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler/setup'
else
  raise 'dummy app could not find Gemfile'
end

$:.unshift File.expand_path('../../../../lib', __FILE__)
