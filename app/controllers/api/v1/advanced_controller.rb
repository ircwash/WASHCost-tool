class Api::V1::AdvancedController < Api::V1::BaseController
  doorkeeper_for :all

  respond_to :json

  def show
    respond_with current_user.user_reports.where(level: "advanced").to_a
  end
end