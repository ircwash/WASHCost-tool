class Api::V1::BaseController < ApplicationController

private

  def current_user
    @current_user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def api_not_found
    { json: '{"status": "failure", "message":"404 Not Found"}' }
  end
end