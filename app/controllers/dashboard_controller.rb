class DashboardController < ApplicationController

  authorize_resource DashboardController

  layout "general"

  def index

  end

end
