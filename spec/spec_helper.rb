# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara-screenshot/rspec'
require 'database_cleaner'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f}

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.global_fixtures = :all
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'

  # Use DBCleaner instead of transactions due to separate processes
  config.use_transactional_fixtures = false
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end
  config.after(:each) { DatabaseCleaner.clean }

  Capybara.javascript_driver = :webkit
end

CarrierWave.configure do |config|
  config.storage = :file
  config.enable_processing = false
end
