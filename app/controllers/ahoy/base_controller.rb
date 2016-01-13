module Ahoy
  class BaseController < ApplicationController
    before_filter :load_authlogic

    # Hack to cors works
    def load_authlogic
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS '
      headers['Access-Control-Allow-Headers'] = 'Content-Type, Origin, Accept'
      headers['Access-Control-Max-Age'] = '1728000'
    end
  end
end
