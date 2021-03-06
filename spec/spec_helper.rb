ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
 config.include Rails.application.routes.url_helpers
 config.fixture_path = "#{::Rails.root}/spec/fixtures"
config.include Capybara::DSL

  config.use_transactional_fixtures = true


  config.infer_base_class_for_anonymous_controllers = false


  Kernel.srand config.seed
  config.order = "random"
end
