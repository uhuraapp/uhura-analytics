class User < ActiveResource::Base
  cattr_accessor :static_headers
  include MailkickHelper

  self.site = 'http://localhost:3000/v3'
  self.static_headers = headers

  schema do
    string :email
  end

  def self.headers
    headers = static_headers.clone
    t = timestamp.to_s
    headers["Auth-Token"] = Digest::MD5.hexdigest ENV["API_TOKEN"] + t
    headers["Auth-Timestamp"] = t
    headers
  end

  def self.timestamp
    Time.now.to_i
  end

  ## ActiveRecord Hack
  # To User model works with association I need create the methods
  def _read_attribute(attr)
    @attributes[attr]
  end

  def self.base_class
    User
  end
end
