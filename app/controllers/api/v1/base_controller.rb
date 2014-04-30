class Api::V1::BaseController < ApplicationController

  def api_not_found 
    render :json => { error: "Not found", status: 404 }, :status => :not_found
  end

private

  def current_user
    @current_user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

end