class WaterBasicController < ApplicationController

  after_filter :set_percent_complete

  include WaterBasicHelper

  layout "water_basic_layout"

  def init_vars
    @@pages= 9
    super
  end


  def set_percent_complete
    flash[:percent_complete]= get_percent_complete(:water_advanced_completed)
  end


  def country

    if request.post?
      country_code= params[:country]

      if(is_valid_country_code(country_code))
        add_to_session_form(:water_basic_form, :water_advanced_completed, "country", country_code)

        redirect_to :action => "water"
      end
    end

    if session[:water_basic_form].present? && session[:water_basic_form]
      flash[:country_code]= session[:water_basic_form][:country]
    end

    flash[:pages_complete] = session[:water_advanced_completed]

  end

  def water

    if request.post?
      water_index= params[:water]

      if(water_index && water_index.to_i > -1 && water_index.to_i < 4)

        add_to_session_form(:water_basic_form, :water_advanced_completed, "water", water_index.to_i)

        redirect_to :action => "population"
      end
    end

  end

  def population

    if request.post?
      population= params[:population]

      if(population && is_number(population) && population.to_i > -1 && population.to_i < 150001)

        add_to_session_form(:water_basic_form, :water_advanced_completed, "population", population.to_i)

        redirect_to :action => "capital"
      end
    end

  end

  def capital

    if request.post?
      capital_amount = params[:capital]


      if(capital_amount && is_number(capital_amount) && capital_amount.to_i > -1)

        add_to_session_form(:water_basic_form, :water_advanced_completed, "capital", capital_amount.to_i)

        redirect_to :action => "recurrent"
      end
    end

  end

  def recurrent

    if request.post?
      recurrent_amount = params[:recurrent]


      if(recurrent_amount && is_number(recurrent_amount) && recurrent_amount.to_i > -1)

        add_to_session_form(:water_basic_form, :water_advanced_completed, "recurrent", recurrent_amount.to_i)

        redirect_to :action => "time"
      end
    end

  end

  def time
    view = "time"

    if request.post?
      time_index= params[:time]

      if(time_index && is_number(time_index) && time_index.to_i > -1 && time_index.to_i < 4)

        add_to_session_form(:water_basic_form, :water_advanced_completed, "time", time_index.to_i)

        redirect_to :action => "quantity"
      end

    end
  end

  def quantity
    view = "quantity"

    if request.post?
      quantity_index= params[:quantity]

      if(quantity_index && is_number(quantity_index) && quantity_index.to_i > -1 && quantity_index.to_i < 4)

        add_to_session_form(:water_basic_form, :water_advanced_completed, "quantity", quantity_index.to_i)

        redirect_to :action => "quality"
      end
    end

  end

  def quality
    if request.post?
      quality_index= params[:quality]

      if(quality_index && is_number(quality_index) && quality_index.to_i > -1 && quality_index.to_i < 4)

        add_to_session_form(:water_basic_form, :water_advanced_completed, "quality", quality_index.to_i)

        redirect_to :action => "reliability"
      end
    end
  end

  def reliability

    if request.post?
      reliability_index= params[:reliability]

      if(reliability_index && is_number(reliability_index) && reliability_index.to_i > -1 && reliability_index.to_i < 4)

        add_to_session_form(:water_basic_form, :water_advanced_completed, "reliability", reliability_index.to_i)

        redirect_to :action =>"report"
      end
    end

  end

  def report

    results= get_water_basic_report
    flash[:results] = results

    render layout: "water_basic_report"
  end

end
