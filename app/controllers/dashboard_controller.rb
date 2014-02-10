class DashboardController < ApplicationController

  authorize_resource DashboardController

  layout "general"

  def index
    @reports = current_user.user_reports
  end

end
