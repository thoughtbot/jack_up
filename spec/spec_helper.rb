ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../spec/dummy/config/environment', __FILE__)
require 'rspec/rails'
require 'database_cleaner'

Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f}

RSpec.configure do |config|
  config.order = 'random'

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    run_dummy_app_migrations
  end

  def run_dummy_app_migrations
    ActiveRecord::Migrator.migrate(Rails.root.join('db', 'migrate'))
  end
end
