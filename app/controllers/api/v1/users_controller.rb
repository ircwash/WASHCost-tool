class Api::V1::UsersController < Api::V1::BaseController
  doorkeeper_for :all

  respond_to :json

  def me
    render :json => { 
      company: current_user.company,
      country: current_user.country,
      email: current_user.email,
      first_name: current_user.first_name,
      last_name: current_user.last_name
    }
    #respond_with current_user
  end

  # only lists advanced reports
  def reports
    if params[:id] 
      respond_with current_user.user_reports.where(level: "advanced", id: params[:id]).first
    else
      respond_with current_user.user_reports.where(level: "advanced").first
    end
  end

end