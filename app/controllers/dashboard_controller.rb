class DashboardController < ApplicationController

  include ApplicationHelper

  authorize_resource DashboardController

  layout "general"

  def index
    @reports = current_user.user_reports
    #Testing...
    #@exchange = ExchangeRate.find_by(name: "USD")
    #@exchange = ExchangeRate.find_by(name: "USD")
    #puts Money.new(1000, "USD")
    #puts Money.new(1000, "USD").exchange_to("EUR")
    #puts ExchangeRate.all().to_json
  end

end
