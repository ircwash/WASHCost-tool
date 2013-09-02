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
        temp = session[:sanitation_basic_form]
        reset_session
        session[:sanitation_basic_form] = temp
        redirect_to cal_water_basic_path
      when 2
        temp = session[:water_basic_form]
        reset_session
        session[:water_basic_form] = temp
        redirect_to cal_sanitation_basic_path
      else
        redirect_to root_path, flash: { popup_class_name: '.notification.subscriber' }
    end
  end

  def sign_in
    session[:user_return_to] = request.referer
    redirect_to new_user_session_path
  end
end
