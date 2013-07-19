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

  def get_general_sustainability(water, capital, recurring, reliability)


    #  capExScore= getCapitalExBenchmarkRating(water, capital);
    #  recExScore= getRecurringExBenchmarkRating(water, recurring);
    #
    #  serviceLevel= (4 * db.reliability[params.reliability].value);
    #
    #var score= (capExScore +recExScore +serviceLevel);
    #
    #var rating= 'Undefined';
    #var backgroundPosition= 0;
    #
    #if(score>=7.5){
    #    rating = 'Low risk';
    #backgroundPosition= 0;
    #}
    #else if(score>=5 && score <7.5){
    #    rating = 'Medium risk';
    #backgroundPosition= -340;
    #}
    #
    #     else if(score>=2 && score < 5){
    #         rating = 'Low risk';
    #     backgroundPosition= 0;
    #     }
    #          else{
    #              rating = 'Not sustainable';
    #          backgroundPosition= -170;
    #          }
    #
    #          return { "rating" : rating, "position" : backgroundPosition };
    #          }


  end


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