class Authentication::SessionsController < Devise::SessionsController

  #after_filter :store_location

  layout "general"

  def store_location
    prev = (request.referrer && !request.referrer.include?("/users")) ? request.referrer : nil
    session[:previous_url] = prev || root_path
  end

  def after_sign_in_path_for(resource)
    prev = (request.referrer && !request.referrer.include?("/users")) ? request.referrer : nil
    stored_location_for(resource) || prev || session[:previous_url] || root_path
  end

  # def store_location
  #   #prev = (request.referrer && !request.referrer.include?("/users")) ? request.referrer : nil
  #   #session[:previous_url] = prev || root_path

  #   return unless request.get?
  #   session[:previous_url] = request.fullpath 

  # end

  # def after_sign_in_path_for(resource)

  #   prev = session[:previous_url] || root_path

  #   puts prev
  #   puts prev.include?('/users')

  #   if prev.include?('/users')
  #     root_path
  #   else
  #     prev
  #   end

  # end

  # # def after_sign_in_path_for(resource)

  # #   puts "referrer"
  # #   puts request.referrer

  # #   prev = (request.referrer && !request.referrer.include?("/users")) ? request.referrer : nil
  # #   #prev || session[:previous_url] || root_path
  # #   puts "prev: "
  # #   puts prev
  # #   puts "session: " 
  # #   puts session[:previous_url]
  # #   puts "root_path: "
  # #   puts root_path

  # #   stored_location_for(resource) || prev || session[:previous_url] || root_path
  # # end

end
