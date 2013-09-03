class HomeController < ApplicationController

  def index
  end

  def marketing
  end

  def selection
  end

  def calculator
    @selection = Selection::ToolSelection.new(params[:selection])
    case @selection.index
      when 0
        session[:water_basic_form] = {}
        session[:water_basic_complete] = {}
        redirect_to cal_water_basic_path
      when 2
        session[:sanitation_basic_form] = {}
        session[:sanitation_basic_complete] = {}
        redirect_to cal_sanitation_basic_path
      else
        flash[:alert] = 'We will publish the advanced Calculator very soon. Please your email and we will let you know when the tool is ready.'
        #redirect_to cal_path, flash: { popup_class_name: '.notification.subscriber' }
        redirect_to new_user_registration_path
    end
  end

  def sign_in
    session[:user_return_to] = request.referer
    redirect_to new_user_session_path
  end
end
