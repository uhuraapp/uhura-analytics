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

def many(resource, ids)
  ids.map { |id| JSON.parse read_fixture("#{resource}/#{id}") }.to_json
end

def read_fixture(file)
  File.read(File.join(Rails.root, "test", "fixtures",  "#{file}.json"))
end

def User.timestamp
  1
end

ActiveResource::HttpMock.respond_to do |mock|
  headers = {"Accept"=>"application/json", "Auth-Token"=>"6512bd43d9caa6e02c990b0a82652dca", "Auth-Timestamp"=>"1"}

  mock.get "/v3/users/1.json", headers, one(:users, :default)
  mock.get "/v3/users.json", headers, many(:users, [:default, :foo, :bar, :other])
  mock.get "/v3/users.json?email=person%40default.com", headers, many(:users, [:default])
end

def users(id)
  id ? User.find(id) : User.all
end
