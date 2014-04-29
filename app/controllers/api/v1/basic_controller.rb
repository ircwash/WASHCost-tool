class Api::V1::BasicController < Api::V1::BaseController
  doorkeeper_for :all

  respond_to :json

  def show
    respond_with current_user.user_reports.where(level: "basic").to_a
  end
end