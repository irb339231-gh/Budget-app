require "simplecov"
SimpleCov.start "rails" do
  enable_coverage :branch
  cover "{app,lib}/**/*.rb"

  skip "/test/"
  skip "/config/"
  skip "/db/"
  skip "/vendor/"
end

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)
    include FactoryBot::Syntax::Methods

    # Add more helper methods to be used by all tests here...
  end
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end
