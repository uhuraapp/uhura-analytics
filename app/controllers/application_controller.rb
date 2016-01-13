class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type, Origin, Accept'
    headers['Access-Control-Max-Age'] = '1728000'

    render :text => '', :content_type => 'text/plain'
  end
end
