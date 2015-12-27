class User < ActiveResource::Base
  self.site = 'https://api.uhura.io'

  schema do
    string :email
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
