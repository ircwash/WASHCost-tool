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
        redirect_to water_basic_path
      when 2
        redirect_to sanitation_basic_path
      else
        redirect_to root_path
    end
  end
end
