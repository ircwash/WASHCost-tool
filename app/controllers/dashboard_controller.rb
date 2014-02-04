class DashboardController < ApplicationController

  authorize_resource DashboardController

  layout "general"

  def index
    @reports = current_user.reports
  end

end
