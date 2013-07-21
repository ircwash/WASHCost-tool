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
        :water => session[:water_basic_form]["water"],
        :reliability => session[:water_basic_form]["reliability"]
    }

    return form
  end

  def get_water_basic_report

    form= get_session_form

    sustainability= get_general_sustainability(form[:water],form[:capital],form[:recurrent], form[:reliability])
    service_level= get_level_of_service(form[:water],form[:capital], form[:quantity], form[:time])

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
      :reliability => get_quantity(form[:reliability]),
      :service_level => service_level
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

    water= t 'form.value_not_set'
    if index && @@water_values[index].present?
      water= @@water_values[index][:label]
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

    population= t 'form.value_not_set'
    if index && @@population_values[index].present?
      population= @@population_values[index][:label]
    end

    return population
  end
  
  def get_time(index)

    time= t 'form.value_not_set'
    if index && @@time_values[index].present?
      time= @@time_values[index][:label]
    end

    return time
  end

  def get_quantity(index)


    quantity= t 'form.value_not_set'
    if index && @@quantity_values[index].present?
      quantity= @@quantity_values[index][:value]
    end

    return quantity
  end


  def get_quality(index)


    quality= t 'form.value_not_set'
    if index && @@quality_values[index].present?
      quality= @@quality_values[index][:value]
    end

    return quality
  end


  def get_reliability(index)


    reliability= t 'form.value_not_set'
    if index && @@reliability_values[index].present?
      reliability= @@reliability_values[index][:label]
    end

    return reliability
  end

  def  get_capEx_benchmark_rating(waterSourceIndex, ex)
      bench= @@water_values[waterSourceIndex][:capExBench]
      rating= (ex >= bench[:min] && ex <= bench[:max]) ? 2 : ( (ex < bench[:min]) ? 0.5 : 1  )

      return rating
  end

  def get_recEx_benchmark_rating(waterSourceIndex, ex)
      bench= @@water_values[waterSourceIndex][:recExBench]
      rating= (ex >= bench[:min] && ex <= bench[:max]) ? 2 : ( (ex < bench[:min]) ? 0.5 : 1  )

      return rating
  end

  def get_general_sustainability(water, capital, recurring, reliability)

    capExScore= get_capEx_benchmark_rating(water, capital)
    recExScore= get_recEx_benchmark_rating(water, recurring)

    serviceLevel= (4 * @@reliability_values[reliability][:value])

    score= (capExScore + recExScore + serviceLevel);

    rating= 'Undefined'
    backgroundPosition= 0

    if score>=7.5
        rating = 'Low risk'
        backgroundPosition= 0
    elsif score>=5 && score <7.5
      rating = 'Medium risk'
      backgroundPosition= -340
    elsif score>=2 && score < 5
      rating = 'Low risk'
      backgroundPosition= 0
    else
      rating = 'Not sustainable'
      backgroundPosition= -170
    end

    rating = { :rating => rating, :position => backgroundPosition }
    return rating
  end

  def get_level_of_service(water, capital, quantity, time)

    capEx_score= get_capEx_benchmark_rating(water, capital)

    capEx_code= @@capEx_rating_code[capEx_score]
    quantity_code= quantity+1
    access_code= time+1

    concatenation= capEx_code.to_s + quantity_code.to_s+ access_code.to_s
    level_of_service= t ('report.water_basic.a'+concatenation)

    return level_of_service
  end

  @@capEx_rating_code = {
    0.5 => "1",
    2 =>   "2",
    1 =>   "3"
  }

  @@water_values = [
      { :label => (I18n.t 'form.water_basic.water.answers.a0'), :value => 1,  :recExBench => { :min => 3 , :max => 6 }, :capExBench => { :min => 20, :max => 61 } },
      { :label => (I18n.t 'form.water_basic.water.answers.a1'), :value => 1, :recExBench => { :min => 3, :max => 15  }, :capExBench => { :min => 30, :max => 131 } },
      { :label => (I18n.t 'form.water_basic.water.answers.a2'), :value => 1, :recExBench => { :min => 3, :max => 15 }, :capExBench => { :min => 30, :max => 131 } },
      { :label => (I18n.t 'form.water_basic.water.answers.a3'), :value => 1, :recExBench => { :min => 3, :max => 15 }, :capExBench => { :min => 30, :max => 131 } },
      { :label => (I18n.t 'form.water_basic.water.answers.a4'), :value =>1, :recExBench => { :min => 3, :max => 15  }, :capExBench => { :min => 20, :max => 152 } }
  ]

  @@population_values= [
      { :label => "Less than 500", :value => 1 },
      { :label => "Between 501 and 5,000", :value => 2 },
      { :label => "Between 5,001 and 15,000", :value => 3 },
      { :label => "More than 15,000", :value => 4 }
  ]

  @@time_values = [
      { :label => (I18n.t 'form.water_basic.time.answers.a0'), :value => 4 },
      { :label => (I18n.t 'form.water_basic.time.answers.a1'), :value => 3 },
      { :label => (I18n.t 'form.water_basic.time.answers.a2'), :value => 2 },
      { :label => (I18n.t 'form.water_basic.time.answers.a3'), :value => 1 }
  ]

  @@quantity_values = [
      { :label =>  (I18n.t 'form.water_basic.quantity.answers.a0'), :value => (I18n.t 'form.shared.values.v0') },
      { :label =>  (I18n.t 'form.water_basic.quantity.answers.a1'), :value => (I18n.t 'form.shared.values.v1') },
      { :label =>  (I18n.t 'form.water_basic.quantity.answers.a2'), :value => (I18n.t 'form.shared.values.v2') },
      { :label =>  (I18n.t 'form.water_basic.quantity.answers.a3'), :value => (I18n.t 'form.shared.values.v3') }
  ]

  @@quality_values = [
      { :label => (I18n.t 'form.water_basic.quality.answers.a0'), :value => (I18n.t 'form.shared.values.v0') },
      { :label => (I18n.t 'form.water_basic.quality.answers.a1'), :value => (I18n.t 'form.shared.values.v1') },
      { :label => (I18n.t 'form.water_basic.quality.answers.a2'), :value => (I18n.t 'form.shared.values.v2') },
      { :label => (I18n.t 'form.water_basic.quality.answers.a3'), :value => (I18n.t 'form.shared.values.v3') }
  ]

  @@reliability_values = [
      { :label =>  ( I18n.t 'form.water_basic.reliability.answers.a0'), :value => 1.5 },
      { :label =>  ( I18n.t 'form.water_basic.reliability.answers.a1'), :value => 1.0 },
      { :label =>  ( I18n.t 'form.water_basic.reliability.answers.a2'), :value => 0.25 },
      { :label =>  ( I18n.t 'form.water_basic.reliability.answers.a3'), :value => 0.0 }
  ]

end