module ReportHelper

  def get_session_form

    puts "form from session"
    puts session[:water_basic_form]

    form= {
        :country => session[:water_basic_form]["country"],
        :water => session[:water_basic_form]["water"],
        :population => session[:water_basic_form]["population"],
        :capital => session[:water_basic_form]["capital"],
        :recurrent => session[:water_basic_form]["recurrent"],
        :time => session[:water_basic_form]["time"],
        :quality => session[:water_basic_form]["quality"],
        :quantity => session[:water_basic_form]["quantity"],
        :reliability => session[:water_basic_form]["reliability"]
    }

    return form
  end

  def get_water_basic_report

    form= get_session_form

    puts "cleaned up"
    puts form

    results = {
      :country => get_country(form[:country]),
      :water => get_water(form[:water]),
      :population => get_population(form[:population]),
      :capital => get_capital(form[:capital]),
      :recurrent => get_recurrent(form[:recurrent]),
      :total => get_total(form[:capital], form[:recurrent]),
      :time => get_time(form[:time]),
      :quantity => get_quantity(form[:quantity]),
      :quality => get_quantity(form[:quality]),
      :reliability => get_quantity(form[:reliability])
    }

    return results

  end

  def get_country(country_code)

    country= Country.new(country_code)
    if(country.data == nil)
      country = nil
    end

    return country
  end

  def get_water(index)

    water_values = [
        { :label => (t 'form.water_basic.water.answers.a0'), :value => 1,  :recExBench => { :min => 3 , :max => 6 }, :capExBench => { :min => 20, :max => 61 } },
        { :label => (t 'form.water_basic.water.answers.a1'), :value => 1, :recExBench => { :min => 3, :max => 15  }, :capExBench => { :min => 30, :max => 131 } },
        { :label => (t 'form.water_basic.water.answers.a2'), :value => 1, :recExBench => { :min => 3, :max => 15 }, :capExBench => { :min => 30, :max => 131 } },
        { :label => (t 'form.water_basic.water.answers.a3'), :value => 1, :recExBench => { :min => 3, :max => 15 }, :capExBench => { :min => 30, :max => 131 } },
        { :label => (t 'form.water_basic.water.answers.a4'), :value =>1, :recExBench => { :min => 3, :max => 15  }, :capExBench => { :min => 20, :max => 152 } }
    ]

    water= t 'form.value_not_set'
    if index && water_values[index].present?
      water= water_values[index][:label]
    end

    return water
  end

  def get_capital(capital)

    return capital
  end

  def get_recurrent(recurrent)
    return recurrent
  end

  def get_total(capital, recurrent)
    return capital * recurrent
  end

  def get_population(index)
    population_values= [
        { :label => "Less than 500", :value => 1 },
        { :label => "Between 501 and 5,000", :value => 2 },
        { :label => "Between 5,001 and 15,000", :value => 3 },
        { :label => "More than 15,000", :value => 4 }
    ]


    population= t 'form.value_not_set'
    if index && population_values[index].present?
      population= population_values[index][:label]
    end

    return population
  end
  
  def get_time(index)
    time_values = [
        { :label => (t 'form.water_basic.time.answers.a0'), :value => 4 },
        { :label => (t 'form.water_basic.time.answers.a1'), :value => 3 },
        { :label => (t 'form.water_basic.time.answers.a2'), :value => 2 },
        { :label => (t 'form.water_basic.time.answers.a3'), :value => 1 }
    ]

    time= t 'form.value_not_set'
    if index && time_values[index].present?
      time= time_values[index][:label]
    end

    return time
  end


  def get_quantity(index)

    quantity_values = [
        { :label =>  "Less than 5 liters", :value => "No service" },
        { :label =>  "Between 5 and 20 liters", :value => "Sub-standard service" },
        { :label =>  "Between 21-60 liters", :value => "Basic service" },
        { :label =>  "More than 60 liters", :value => "High service" }
    ]

    quantity= t 'form.value_not_set'
    if index && quantity_values[index].present?
      quantity= quantity_values[index][:value]
    end

    return quantity
  end

  def get_quality(index)

    quality_values = [
        { :label => "No testing", :value => "No service" },
        { :label => "One-off test after construction", :value => "Sub-standard service" },
        { :label => "Occasional and meets standards", :value => "Basic service" },
        { :label => "Regular and meets standards", :value => "High service" }
    ]

    quality= t 'form.value_not_set'
    if index && quality_values[index].present?
      quality= quality_values[index][:value]
    end

    return quality
  end


  def get_reliability(index)
    reliability_values = [
        { :label =>  (t 'form.water_basic.reliability.answers.a0'), :value => 1.5 },
        { :label =>  (t 'form.water_basic.reliability.answers.a1'), :value => 1.0 },
        { :label =>  (t 'form.water_basic.reliability.answers.a2'), :value => 0.25 },
        { :label =>  (t 'form.water_basic.reliability.answers.a3'), :value => 0.0 }
    ]

    reliability= t 'form.value_not_set'
    if index && reliability_values[index].present?
      reliability= reliability_values[index][:label]
    end

    return reliability
  end

end