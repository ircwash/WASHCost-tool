class CalculatorsController < ApplicationController

  layout "general"

  def index

  end

  def selection
    @selection = Selection::ToolSelection.new(params[:selection])
    I18n.locale =  @selection.lang
    case @selection.index
      when 0
        session[:water_basic_form] = {}
        session[:water_basic_complete] = {}
        redirect_to basic_water_path( I18n.locale )
      when 2
        session[:sanitation_basic_form] = {}
        session[:sanitation_basic_complete] = {}
        redirect_to basic_sanitation_path( I18n.locale )
      else
        flash[:alert] = 'We will publish the advanced Calculator very soon. Please your email and we will let you know when the tool is ready.'
        #redirect_to cal_path, flash: { popup_class_name: '.notification.subscriber' }
        redirect_to new_user_registration_path
    end
  end

end
