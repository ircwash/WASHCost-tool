class Authentication::SessionsController < Devise::SessionsController

  after_filter :store_location

  layout "general"

  def store_location
    prev = (request.referrer && !request.referrer.include?("/users")) ? request.referrer : nil
    session[:previous_url] = prev || root_path
  end

  #def after_sign_in_path_for(resource)
  #  session[:previous_url] || root_path
  #end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || request.referer || session[:previous_url] || root_path
  end

end
