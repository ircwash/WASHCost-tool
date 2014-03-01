class Authentication::SessionsController < Devise::SessionsController

  after_filter :store_location

  layout "general"

  def store_location
    session[:previous_url] = request.referrer unless request.referrer.include? "/users/" || root_path
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

end
