class WaterAdvancedController < ApplicationController


  layout "water_advanced_layout"

  def index



  end

  def report


    render layout: "report_water_advanced"
  end

end