module SanitationReportHelper

  def get_sanitation_basic_report

    form = get_session_form
    form_ready = is_form_ready?(form)

    cost_rating = get_cost_rating(form[:latrine], form[:capital])
    cost_rating_label = get_cost_rating_label(cost_rating)

    service_rating = get_rating(form[:latrine],form[:capital],form[:recurrent], form[:reliability])
    service_level = get_level_of_service(form[:latrine],form[:capital], form[:usage], form[:providing])
    service_label = get_service_rating_label(service_rating)

    results = {
        :form_ready => form_ready,
        :cost_rating=> cost_rating,
        :cost_rating_label=> cost_rating_label,
        :service_rating => service_rating,
        :service_level => service_level,
        :service_label => service_label,
        :country => get_country(form[:country]),
        :population=> get_population(form[:population]),
        :latrine_index => form[:latrine],
        :latrine => get_indexed(@@latrine_values, form[:latrine]),
        :capital => get_capital(form[:capital]),
        :recurrent => get_recurrent(form[:recurrent]),
        :total => get_total(form[:capital], form[:recurrent], form[:population]),
        :providing => get_indexed(@@providing_values, form[:providing]),
        :usage => get_indexed(@@usage_values, form[:usage]),
        :environment => get_indexed(@@environment_values, form[:environment]),
        :impermeability => get_indexed(@@impermeability_values, form[:impermeability]),
        :reliability => get_indexed(@@reliability_values, form[:reliability])
    }

    return results

  end

  def get_session_form
    form = {
        :cost_rating=> nil,
        :cost_rating_label=> nil,
        :country => nil,
        :household => nil,
        :sanitation => nil,
        :population => nil,
        :latrine_index => nil,
        :latrine => nil,
        :capital => nil,
        :recurrent => nil,
        :total => nil,
        :providing => nil,
        :usage => nil,
        :impermeability => nil,
        :environment => nil,
        :reliability => nil
    }

    if(session[:sanitation_basic_form].present?)
      form = {
          :country => session[:sanitation_basic_form]["country"],
          :latrine => session[:sanitation_basic_form]["latrine"],
          :capital => session[:sanitation_basic_form]["capital"],
          :population => session[:sanitation_basic_form]["population"],
          :recurrent => session[:sanitation_basic_form]["recurrent"],
          :providing => session[:sanitation_basic_form]["providing"],
          :usage => session[:sanitation_basic_form]["usage"],
          :impermeability => session[:sanitation_basic_form]["impermeability"],
          :environment => session[:sanitation_basic_form]["environment"],
          :reliability => session[:sanitation_basic_form]["reliability"]
      }
    end

    return form
  end

  def get_country(country_code)
    country = Country.new(country_code) || nil
    country.present? && country.data.present? && country.name.present? ? country.name : t('form.value_not_set')
  end

  # @return [Integer], return the population value take into account the rules of range
  def get_population(population)
    population.present? && population >= @@population_ranges[:min] ? population : @@population_ranges[:min]
  end

  # @return [String], return the label of collections in the specific index
  def get_indexed(collection, index)
    puts 'index', collection, index
    if index && collection[index].present?
      collection[index][:value]
    else
      collection.first[:value]
    end
  end

  # @return [Integer], return the capital value take into account the rules based on latrine technology
  def get_capital(capital)
    form = get_session_form
    capital_min_value = capital_range_latrine_based(form[:latrine].to_i)[:min_value]
    capital && capital >= capital_min_value ? capital : capital_min_value
  end

  # @return [Integer], return the recurrent value take into account the rules based on technology
  def get_recurrent(recurrent)
    form = get_session_form
    recurrent_min_value = recurrent_range_latrine_based(form[:latrine].to_i)[:min_value]
    recurrent && recurrent >= recurrent_min_value ? recurrent : recurrent_min_value
  end

  ####  Logic of capital and recurrent cost ranges ####

  def capital_range_latrine_based(latrine_sources_index)
    case latrine_sources_index
      when 2..3
        { min_value: 36, max_value:  358}
      when 4..5
        { min_value: 92, max_value: 358 }
      else
        { min_value: 7, max_value: 26 }
    end
  end

  def recurrent_range_latrine_based(latrine_sources_index)
    case latrine_sources_index
      when 2..3
        { min_value: 2.5 , max_value: 8.5 }
      when 4..5
        { min_value: 3.5, max_value: 11.5 }
      else
        { min_value: 1.5, max_value: 4.0 }
    end
  end


  @@population_ranges = {
      min: 100,
      max: 1000000,
  }

  @@latrine_values= [
    { :value => (I18n.t 'form.sanitation_basic.latrine.answers.a0'), :recExBench => { :min =>  1.5, :max => 5 }, :capExBench => { :min => 7, :max =>26 }},
    { :value => (I18n.t 'form.sanitation_basic.latrine.answers.a1'), :recExBench => { :min =>  1.5, :max => 5 }, :capExBench => { :min => 7, :max =>26 }} ,
    { :value => (I18n.t 'form.sanitation_basic.latrine.answers.a2'), :recExBench => { :min =>  2.5, :max => 8 }, :capExBench => { :min => 36, :max => 358}},
    { :value => (I18n.t 'form.sanitation_basic.latrine.answers.a3'), :recExBench => { :min =>  2.5, :max => 8 }, :capExBench => { :min => 36, :max => 358}},
    { :value => (I18n.t 'form.sanitation_basic.latrine.answers.a4'), :recExBench => { :min => 3.5 , :max => 11.5}, :capExBench => { :min => 92 , :max =>358 }},
    { :value => (I18n.t 'form.sanitation_basic.latrine.answers.a5'), :recExBench => { :min => 3.5 , :max => 11.5}, :capExBench => { :min => 92 , :max =>358 }}
  ]

  @@providing_values= [
      { :value => (I18n.t 'form.sanitation_basic.providing.answers.a0')},
      { :value => (I18n.t 'form.sanitation_basic.providing.answers.a1')}
  ]

  @@environment_values= [
      { :value => (I18n.t 'form.sanitation_basic.environment.answers.a0')},
      { :value => (I18n.t 'form.sanitation_basic.environment.answers.a1')},
      { :value => (I18n.t 'form.sanitation_basic.environment.answers.a2')}
  ]

  @@usage_values= [
      { :value => (I18n.t 'form.sanitation_basic.usage.answers.a0')},
      { :value => (I18n.t 'form.sanitation_basic.usage.answers.a1')} ,
      { :value => (I18n.t 'form.sanitation_basic.usage.answers.a2')}
  ]

  @@impermeability_values= [
      { :value => (I18n.t 'form.sanitation_basic.impermeability.answers.a0')},
      { :value => (I18n.t 'form.sanitation_basic.impermeability.answers.a1')},
  ]

  @@reliability_values= [
      { :label => (I18n.t 'form.sanitation_basic.reliability.answers.a0'), value: 1.5},
      { :label => (I18n.t 'form.sanitation_basic.reliability.answers.a1'), value: 1.0} ,
      { :label => (I18n.t 'form.sanitation_basic.reliability.answers.a2'), value: 0 }
  ]

  @@capEx_rating_code = {
      0.5 => "1",
      2 =>   "2",
      1 =>   "3"
  }

  # Total Cost & Cost Rating/Benchmarking Calculations
  # @return [Integer], return the total costs for population including capital and recurrent expenditures
  def get_total(capital, recurrent, population)
    if capital && recurrent && population
      total_cost = get_capital(capital) + (get_recurrent(recurrent) * 10)
      total_cost * get_population(population)
    else
      nil
    end

  end


  def get_cost_rating(latrine_index, capEx)

    rating= -1

    if latrine_index && capEx

      if latrine_index == 0 || latrine_index == 1
        if capEx < 7
          rating = 0
        elsif capEx > 26
          rating = 1
        else
          rating = 2
        end
      elsif latrine_index == 2 || latrine_index == 3
        if capEx < 36
          rating = 0
        elsif capEx > 358
          rating = 1
        else
          rating = 2
        end

      elsif latrine_index ==4 || latrine_index==5
        if capEx < 92
          rating = 0
        elsif capEx > 358
          rating = 1
        else
          rating = 2
        end

      end
    end

    return rating
  end

  def get_cost_rating_label(rating)

    label=  t 'form.value_not_set'

    if rating == 0
      label= (t 'report.benchmark_below')
    elsif rating == 1
      label= (t 'report.benchmark_within')
    elsif rating == 2
      label= (t 'report.benchmark_above')
    end

    return label

  end

  #Level of Service Calculations
  def  get_capEx_benchmark_rating(latrineIndex, ex)
    bench= @@latrine_values[latrineIndex][:capExBench]
    rating= (ex >= bench[:min] && ex <= bench[:max]) ? 2 : ( (ex < bench[:min]) ? 0.5 : 1  )

    return rating
  end

  def get_recEx_benchmark_rating(latrineIndex, ex)
    bench= @@latrine_values[latrineIndex][:recExBench]
    rating= (ex >= bench[:min] && ex <= bench[:max]) ? 2 : ( (ex < bench[:min]) ? 0.5 : 1  )

    return rating
  end

  def get_rating(water, capital, recurring, reliability)

    rating= nil

    if(water && capital && recurring && reliability)
      capExScore= get_capEx_benchmark_rating(water, capital)
      recExScore= get_recEx_benchmark_rating(water, recurring)

      serviceLevel= (4 * @@reliability_values[reliability][:value])

      score= (capExScore + recExScore + serviceLevel);

      backgroundPosition= 0

      if score>=7.5
        rating = 3
      elsif score>=5 && score <7.5
        rating = 2
      elsif score>=2 && score < 5
        rating = 2
      else
        rating = 0
      end
    end

    return rating
  end

  def get_service_rating_label(rating)

    label=  t 'form.value_not_set'

    if rating == 0
      label= (t 'report.sustainability.sanitation.one_star')
    elsif rating == 1
      label= (t 'report.sustainability.sanitation.two_stars')
    elsif rating == 2
      label= (t 'report.sustainability.sanitation.three_stars')
    elsif rating == 3
      label= (t 'report.sustainability.sanitation.four_stars')
    end

    return label

  end

  def get_level_of_service(latrine, capital, usage, providing)

    level_of_service= 'Pease complete the form.'

    if latrine && capital && usage && providing
      capEx_score= get_capEx_benchmark_rating(latrine, capital)

      capEx_code= @@capEx_rating_code[capEx_score]
      quantity_code= usage+1
      access_code= providing+1

      concatenation= capEx_code.to_s + quantity_code.to_s+ access_code.to_s
      level_of_service= t ('report.water_basic.a'+concatenation)
    end

    return level_of_service

  end

  def is_form_ready?(form)
    [form[:latrine], form[:capital], form[:recurrent], form[:reliability]].all?
  end

end
