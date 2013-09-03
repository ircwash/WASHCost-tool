class RegistrationsController < Devise::RegistrationsController
  include Rails.application.routes.url_helpers
  protected
  def after_update_path_for(resource)
    dashboard_index_path
  end
end
