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
        redirect_to cal_water_basic_path
      when 2
        redirect_to cal_sanitation_basic_path
      else
        redirect_to root_path, flash: { popup_class_name: '.notification.subscriber' }
    end
  end
end
