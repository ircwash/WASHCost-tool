class WaterBasicController < ApplicationController

  after_filter :set_percent_complete

  include WaterBasicHelper

  layout "water_basic_layout"

  def init_vars
    @@pages= 9
    super
  end

  def set_percent_complete
    flash[:percent_complete]= get_percent_complete(:water_basic_complete)
  end

  def country

    if request.post?
      country_code= params[:country]

      if(is_valid_country_code(country_code))
        add_to_session_form(:water_basic_form, :water_basic_complete, "country", country_code)

        redirect_to :action => "water"
      end

    end

    flash[:country_code] = retrieve_previous_answer_for("country")
    flash[:pages_complete] = session[:water_basic_complete]
  end


  def water

    if request.post?
      water_index= params[:water]

      if(water_index && water_index.to_i > -1 && water_index.to_i <= 4)

        add_to_session_form(:water_basic_form, :water_basic_complete, "water", water_index.to_i)

        redirect_to :action => "population"

      end
    end

    flash[:water] = retrieve_previous_answer_for("water")
  end

  def population

    if request.post?
      population= params[:population]

      if(population && is_number(population) && population.to_i > -1 && population.to_i < 150001)

        add_to_session_form(:water_basic_form, :water_basic_complete, "population", population.to_i)

        redirect_to :action => "capital"
      end
    end

    flash[:population] = retrieve_previous_answer_for("population")
  end

  def capital

    if request.post?
      capital_amount = params[:capital]


      if(capital_amount && is_number(capital_amount) && capital_amount.to_i > -1)

        add_to_session_form(:water_basic_form, :water_basic_complete, "capital", capital_amount.to_i)

        redirect_to :action => "recurrent"
      end
    end

    flash[:capital] = retrieve_previous_answer_for("capital")
  end

  def recurrent

    if request.post?
      recurrent_amount = params[:recurrent]


      if(recurrent_amount && is_number(recurrent_amount) && recurrent_amount.to_i > -1)

        add_to_session_form(:water_basic_form, :water_basic_complete, "recurrent", recurrent_amount.to_i)

        redirect_to :action => "time"
      end
    end

    flash[:recurrent] = retrieve_previous_answer_for("recurrent")
  end

  def time
    view = "time"

    if request.post?
      time_index= params[:time]

      if(time_index && is_number(time_index) && time_index.to_i > -1 && time_index.to_i < 4)

        add_to_session_form(:water_basic_form, :water_basic_complete, "time", time_index.to_i)

        redirect_to :action => "quantity"
      end

    end
  end

  def quantity
    view = "quantity"

    if request.post?
      quantity_index= params[:quantity]

      if(quantity_index && is_number(quantity_index) && quantity_index.to_i > -1 && quantity_index.to_i < 4)

        add_to_session_form(:water_basic_form, :water_basic_complete, "quantity", quantity_index.to_i)

        redirect_to :action => "quality"
      end
    end

  end

  def quality
    if request.post?
      quality_index= params[:quality]

      if(quality_index && is_number(quality_index) && quality_index.to_i > -1 && quality_index.to_i < 4)

        add_to_session_form(:water_basic_form, :water_basic_complete, "quality", quality_index.to_i)

        redirect_to :action => "reliability"
      end
    end
  end

  def reliability

    if request.post?
      reliability_index= params[:reliability]

      if(reliability_index && is_number(reliability_index) && reliability_index.to_i > -1 && reliability_index.to_i < 4)

        add_to_session_form(:water_basic_form, :water_basic_complete, "reliability", reliability_index.to_i)

        redirect_to :action =>"report"
      end
    end

  end

  def report

    results= get_water_basic_report
    flash[:results] = results

    render layout: "water_basic_report"
  end

  private

  def retrieve_previous_answer_for(user_step)
    begin
      session[:water_basic_form].has_key?(user_step) ? session[:water_basic_form][user_step] : nil
    rescue
      nil
    end
  end

end
