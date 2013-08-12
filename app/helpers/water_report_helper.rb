module WaterReportHelper

  def get_session_form

    form = {
        :country => nil,
        :water => nil,
        :population => nil,
        :capital => nil,
        :recurrent => nil,
        :time => nil,
        :quality  => nil,
        :quantity => nil,
        :water => nil,
        :reliability => nil
    }

    if(session[:water_basic_form].present?)
      form = {
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
    end

    return form
  end

  def get_water_basic_report
    form = get_session_form
    form_ready = is_form_ready?(form)

    cost_rating = get_cost_rating(form[:water], form[:capital])
    cost_rating_label = get_cost_rating_label(cost_rating)

    service_rating = get_rating(form[:water], form[:capital],
                                form[:recurrent], form[:time],
                                form[:quality], form[:quantity], form[:reliability])

    service_level = get_level_of_service(form[:water],form[:capital], form[:quantity], form[:time])
    service_label = get_service_rating_label(service_rating)

    results = {
      :form_ready => form_ready,
      :cost_rating=> cost_rating,
      :cost_rating_label=> cost_rating_label,
      :service_rating => service_rating,
      :service_label => service_label,
      :service_level => service_level,
      :country => get_country(form[:country]),
      :water => get_water(form[:water]),
      :water_index => form[:water],
      :population => get_population(form[:population]),
      :capital => get_capital(form[:capital]),
      :recurrent => get_recurrent(form[:recurrent]),
      :total => get_total(form[:capital], form[:recurrent], form[:population]),
      :time => get_time(form[:time]),
      :quantity => get_quantity(form[:quantity]),
      :quantity_index => get_index(form[:quantity]),
      :quality => get_quality(form[:quality]),
      :quality_index => get_index(form[:quality]),
      :reliability => get_reliability(form[:reliability]),
      :reliability_index => get_index(form[:reliability])
    }

    return results

  end

  def is_form_ready?(form)
    [form[:water], form[:capital], form[:recurrent], form[:time],
     form[:quality], form[:quantity], form[:reliability]].all?
  end

  def get_country(country_code)
    country = t 'form.value_not_set'
    if country_code
      country_object = Country.new(country_code)
      if(country_object.data == nil)
        country = nil
      else
        country= country_object.name
      end
    end
    return country
  end

  def get_index(index)
    return index
  end

  # @return [String], return the label of technology selected in the step 1
  def get_water(index)
    index = index || 0
    if index && @@water_values[index].present?
      @@water_values[index][:label]
    else
      t 'form.value_not_set'
    end
  end

  # @return [Integer], return the capital value take into account the rules based on technology
  def get_capital(capital)
    form = get_session_form
    capital_min_value = capital_range_water_based(form[:water].to_i)[:min_value]
    capital && capital >= capital_min_value ? capital : capital_min_value
  end


  # @return [Integer], return the recurrent value take into account the rules based on technology
  def get_recurrent(recurrent)
    form = get_session_form
    recurrent_min_value = recurrent_range_water_based(form[:water].to_i)[:min_value]
    recurrent && recurrent >= recurrent_min_value ? recurrent : recurrent_min_value
  end

  # @return [Integer], return the total costs for population including capital and recurrent expenditures
  def get_total(capital, recurrent, population)
    if capital && recurrent && population
      total_cost = get_capital(capital) + (get_recurrent(recurrent) * 10)
      total_cost * get_population(population)
    else
      nil
    end
  end

  # @return [Integer], return the population value take into account the rules of range
  def get_population(input)
    input.present? && input >= @@population_ranges[:min] ? input : @@population_ranges[:min]
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
      quantity= @@quantity_values[index][:label]
    end
    return quantity
  end


  def get_quality(index)
    quality= t 'form.value_not_set'
    if index && @@quality_values[index].present?
      quality= @@quality_values[index][:label]
    end
    return quality
  end


  def get_reliability(index)


    reliability = t 'form.value_not_set'
    if index && @@reliability_values[index].present?
      reliability = @@reliability_values[index][:label]
    end

    return reliability
  end

  ####  Logic of capital and recurrent cost ranges ####

  def capital_range_water_based(water_sources_index)
    case water_sources_index
      when 0
        { min_value: 20, max_value: 61 }
      else
        { min_value: 30, max_value: 131 }
    end
  end

  def recurrent_range_water_based(water_sources_index)
    case water_sources_index
      when 0
        { min_value: 3, max_value: 6 }
      else
        { min_value: 3, max_value: 15 }
    end
  end


  #### Logic of Report calculates ####

  def get_cost_rating(water_index, capEx)

    rating = -1

    if water_index && capEx

      if water_index == 0

        if capEx < 20
          rating = 0
        elsif capEx > 61
          rating = 1
        else
          rating = 2
        end

      else

        if capEx < 30
          rating = 0
        elsif capEx > 131
          rating = 1
        else
          rating = 2
        end

      end
    end

    return rating
  end

  def get_cost_rating_label(rating)

    label =  t 'form.value_not_set'

    if rating ==0
      label = (t 'report.benchmark_below')
    elsif rating ==1
      label= (t 'report.benchmark_within')
    elsif rating ==2
      label= (t 'report.benchmark_above')
    else
      label= 'Please Enter a <a href="./population">Population</a> and <a href="./capital">Capital Expenditure<a/>'
    end

    return label

  end


  def get_capEx_benchmark_rating(waterSourceIndex, ex)
    bench = @@water_values[waterSourceIndex][:capExBench]
    rating_for_expenditure ex, bench[:min], bench[:max]
  end

  def get_recEx_benchmark_rating(waterSourceIndex, ex)
    bench = @@water_values[waterSourceIndex][:recExBench]
    rating_for_expenditure ex, bench[:min], bench[:max]
  end

  def rating_for_expenditure(val, min, max)
    if val < min
      0.5
    elsif (val >= min && val <= max)
      2
    else
      1
    end
  end

  def get_rating(water, capital, recurring, accesibility, quantity, quality, reliability)
    params = [water, capital, recurring, accesibility, quantity, quality, reliability]

    if params.all?
      capExScore = get_capEx_benchmark_rating(water, capital)
      recExScore = get_recEx_benchmark_rating(water, recurring)

      accesibility = normalise_best_level_to_be_3(accesibility)
      reliability = normalise_best_level_to_be_3(reliability)

      serviceLevel = [accesibility, quantity, quality, reliability].inject(0) do |sum, element|
        sum += rating_for_service_level(element)
      end

      score = (capExScore + recExScore + serviceLevel);

      backgroundPosition = 0

      if score >= 7.5
          rating = 3
      elsif score >=5 && score < 7.5
        rating = 2
      elsif score >=2 && score < 5
        rating = 2
      else
        rating = 0
      end
    end

    rating
  end

  #Used to normalise reliability so that the best service is represented with index = 3
  def normalise_best_level_to_be_3(level)
    { 0 => 3, 1 => 2, 2 => 1, 3 => 0 }[level]
  end

  def rating_for_service_level(level)
    { 0 => 0, 1 => 0.25, 2 => 1, 3 => 1.5 }[level]
  end

  def get_level_of_service(water, capital, quantity, time)

    level_of_service= 'Please complete the form.'

    if water && capital && quantity && time
      capEx_score = get_capEx_benchmark_rating(water, capital)

      capEx_code = @@capEx_rating_code[capEx_score]
      quantity_code = quantity + 1
      access_code = time + 1

      concatenation = capEx_code.to_s + quantity_code.to_s + access_code.to_s
      level_of_service = t ('report.water_basic.a' + concatenation)
    end

    return level_of_service

  end

  def get_service_rating_label(rating)
    label = if rating == 0
      t 'report.sustainability.water.one_star'
    elsif rating == 1
      t 'report.sustainability.water.two_stars'
    elsif rating == 2
      t 'report.sustainability.water.three_stars'
    elsif rating == 3
      t 'report.sustainability.water.four_stars'
    else
      t 'form.value_not_set'
    end
    return label
  end

  @@capEx_rating_code = {
    0.5 => "1",
    2 =>   "2",
    1 =>   "3"
  }

  @@population_ranges = {
      min: 100,
      max: 1000000,
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
      { :label => (I18n.t 'form.water_basic.time.answers.a0'), :value => 1 },
      { :label => (I18n.t 'form.water_basic.time.answers.a1'), :value => 2 },
      { :label => (I18n.t 'form.water_basic.time.answers.a2'), :value => 3 },
      { :label => (I18n.t 'form.water_basic.time.answers.a3'), :value => 4 }
  ]

  @@quantity_values = [
      { :label =>  (I18n.t 'form.water_basic.quantity.answers.a0') },
      { :label =>  (I18n.t 'form.water_basic.quantity.answers.a1') },
      { :label =>  (I18n.t 'form.water_basic.quantity.answers.a2') },
      { :label =>  (I18n.t 'form.water_basic.quantity.answers.a3') }
  ]

  @@quality_values = [
      { :label => (I18n.t 'form.water_basic.quality.answers.a0') },
      { :label => (I18n.t 'form.water_basic.quality.answers.a1') },
      { :label => (I18n.t 'form.water_basic.quality.answers.a2') },
      { :label => (I18n.t 'form.water_basic.quality.answers.a3') }
  ]

  @@reliability_values = [
      { :label =>  ( I18n.t 'form.water_basic.reliability.answers.a0') },
      { :label =>  ( I18n.t 'form.water_basic.reliability.answers.a1') },
      { :label =>  ( I18n.t 'form.water_basic.reliability.answers.a2') },
      { :label =>  ( I18n.t 'form.water_basic.reliability.answers.a3') }
  ]

end
