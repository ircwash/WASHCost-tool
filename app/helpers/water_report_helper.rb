module WaterReportHelper
  include ReportHelper

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

    cost_rating = get_cost_rating(form[:water], form[:capital], form[:recurrent])
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
    response = { max_value: @@water_capExp_absolute_range[:max], min_value: @@water_capExp_absolute_range[:min]}
    case water_sources_index
      when 0
        response.merge({ below_value: 20, above_value: 61 })
      else
        response.merge({ below_value: 30, above_value: 131})
    end
  end

  def recurrent_range_water_based(water_sources_index)
    response = { max_value: @@water_recurrent_absolute_range[:max], min_value: @@water_recurrent_absolute_range[:min]}
    case water_sources_index
      when 0
        response.merge({ below_value: 3, above_value: 6 })
      else
        response.merge({ below_value: 3, above_value: 15 })
    end
  end


  #### Logic of Report calculates ####

  #@return [Integer], return 0 if the expenditure is outside of WashCost benchmark, or 1 in otherwise
  def get_cost_rating(water_index, capital_expenditure, recurrent_expenditure)
    water_index = water_index || 0
    expenditures = [{name: "capital", value: capital_expenditure}, {name: "recurrent", value: recurrent_expenditure}]
    benchmark_results = expenditures.map do |expenditure|
      is_value_in_benchmark_of expenditure[:name], expenditure[:value], water_index
    end
    puts '--> benchmark results: ', benchmark_results
    benchmark_results.all? ? 1 : 0
  end

  #@return [Boolean], return true if the value is within the benchmark in the expediture associated, in othwerwise the
  # method return false
  def is_value_in_benchmark_of(expenditure, value, water_index)
    range = send "#{expenditure}_range_water_based".to_sym, water_index
    range[:below_value]<value && value<range[:above_value]
  end

  #@return [String] return the label of benchmark reagrding the cost rating
  def get_cost_rating_label(rating)
    if rating==1
      t 'report.benchmark_within'
    else
      t 'report.benchmark_outside'
    end
  end

  def get_rating(water, capital, recurring, accesibility, quantity, quality, reliability)
    return nil unless [water, capital, recurring, accesibility, quantity, quality, reliability].all?
    score = compute_score(water, capital, recurring, accesibility, quantity, quality, reliability)
    rating = compute_rating_from_score (score)
  end

  def compute_score(water, capital, recurring, accesibility, quantity, quality, reliability)
    Rails.logger.debug "capex: #{capital} for water: #{water} produces score of #{get_capex_benchmark_rating(water, capital)}"
    capex_score = get_capex_benchmark_rating(water, capital)
    Rails.logger.debug "recex: #{recurring} for water: #{water} produces score of #{get_recex_benchmark_rating(water, recurring)}"
    recex_score = get_recex_benchmark_rating(water, recurring)
    service_score = rating_for_combined_service_levels(accesibility, quantity, quality, reliability)
    capex_score + recex_score + service_score
  end

  def get_capex_benchmark_rating(waterSourceIndex, ex)
    bench = @@water_values[waterSourceIndex][:capExBench]
    rating_for_expenditure ex, bench[:min], bench[:max]
  end

  def get_recex_benchmark_rating(waterSourceIndex, ex)
    bench = @@water_values[waterSourceIndex][:recExBench]
    rating_for_expenditure ex, bench[:min], bench[:max]
  end

  # @return [Float] return the rating of all items related with the level of service, the process selects the item with
  # least value, then this value is mapped to rating value according the business rules
  def rating_for_combined_service_levels(accesibility, quantity, quality, reliability)
    accesibility = normalise_best_level_to_be_3(accesibility)
    reliability = normalise_best_level_to_be_3(reliability)
    minimum_service_value = [accesibility, quantity, quality, reliability].min
    rating_for_service_level minimum_service_value
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
      capEx_score = get_capex_benchmark_rating(water, capital)

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

  @@water_capExp_absolute_range = {
      min: 0,
      max: 300,
  }

  @@water_recurrent_absolute_range = {
      min: 0,
      max: 30,
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
