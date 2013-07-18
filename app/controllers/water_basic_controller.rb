class WaterBasicController < ApplicationController
  layout "water_basic_layout"

  def init_vars
    @@pages= 10
    super
  end

  def country
    view= "country"

    if request.post?
      country_code= params[:country]

      if(is_valid_country_code(country_code))
        add_to_session_form("country", country_code)
        increase_pages_complete

        view = "water"
      end
    end

    render view
  end

  def water
    view= "water"

    if request.post?
      water_index= params[:water]

      if(water_index && water_index.to_i > -1 && water_index.to_i < 4)

        add_to_session_form("water", water_index.to_i)
        increase_pages_complete

        view = "population"
      end

      render view
    end

  end

  def population
    view="population"

    if request.post?
      population_index= params[:population]

      if(population_index && is_number(population_index) && population_index.to_i > -1 && population_index.to_i < 5)

        add_to_session_form("population", population_index.to_i)
        increase_pages_complete

        view = "capital"
      end
    end

    render view
  end

  def capital
    view = "capital"

    if request.post?
      capital_amount = params[:capital]


      if(capital_amount && is_number(capital_amount) && capital_amount.to_i > -1)

        add_to_session_form("capital", capital_amount.to_i)
        increase_pages_complete

        view = "recurrent"
      end
    end

    render view
  end

  def recurrent

    view = "recurrent"

    if request.post?
      recurrent_amount = params[:recurrent]


      if(recurrent_amount && is_number(recurrent_amount) && recurrent_amount.to_i > -1)

        add_to_session_form("recurrent", recurrent_amount.to_i)
        increase_pages_complete

        view = "time"
      end
    end

    render view

  end

  def time
    view = "time"

    if request.post?
      time_index= params[:time]

      if(time_index && is_number(time_index) && time_index.to_i > -1 && time_index.to_i < 4)

        add_to_session_form("time", time_index.to_i)
        increase_pages_complete

        view = "quantity"
      end
    end

    render view
  end

  def quantity
    view = "quantity"

    if request.post?
      quantity_index= params[:quantity]

      if(quantity_index && is_number(quantity_index) && quantity_index.to_i > -1 && quantity_index.to_i < 4)

        add_to_session_form("quantity", quantity_index.to_i)
        increase_pages_complete

        view = "quality"
      end
    end

    render view
  end

  def quality
    view = "quality"

    if request.post?
      quality_index= params[:quality]

      if(quality_index && is_number(quality_index) && quality_index.to_i > -1 && quality_index.to_i < 4)

        add_to_session_form("quality", quality_index.to_i)
        increase_pages_complete

        view = "reliability"
      end
    end

    render view
  end

  def reliability
    view = "reliability"

    if request.post?
      reliability_index= params[:reliability]

      if(reliability_index && is_number(reliability_index) && reliability_index.to_i > -1 && reliability_index.to_i < 4)

        add_to_session_form("reliability", reliability_index.to_i)
        increase_pages_complete

        view = "reliability"
      end
    end

    render view
  end

  def report

    render layout: "report"
  end


end
