ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

def one(resource, id)
  data = {}
  data[resource.to_s.singularize] = JSON.parse read_fixture("#{resource}/#{id}")
  data.to_json
end

def many(resource, id)
  data = []
  data.push JSON.parse read_fixture("#{resource}/#{id}")
  data.to_json
end

def read_fixture(file)
  File.read(File.join(Rails.root, "test", "fixtures",  "#{file}.json"))
end

ActiveResource::HttpMock.respond_to do |mock|
   mock.get "/users/1.json", {}, one(:users, :default)
   mock.get "/users.json?email=person%40default.com", {}, many(:users, :default)
end

def users(id)
  User.find id
end
