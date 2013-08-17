module SanitationReportHelper
  include ReportHelper

  def get_sanitation_basic_report
    form = get_session_form
    form_ready = is_form_ready?(form)

    cost_rating = get_cost_rating(form[:latrine], form[:capital], form[:recurrent])
    cost_rating_label = get_cost_rating_label(cost_rating)

    service_rating = get_rating(form[:providing], form[:impermeability], form[:environment], form[:usage], form[:reliability])
    service_level = get_level_of_service(form[:latrine],form[:recurrent], form[:usage], form[:reliability], form[:capital], form[:providing], form[:impermeability], form[:environment])
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
        :providing_index => form[:providing],
        :usage => get_indexed(@@usage_values, form[:usage]),
        :usage_index => form[:usage],
        :environment => get_indexed(@@environment_values, form[:environment]),
        :environment_index => form[:environment],
        :impermeability => get_indexed(@@impermeability_values, form[:impermeability]),
        :impermeability_index => form[:impermeability],
        :reliability => get_reliability(form[:reliability]),
        :reliability_index => form[:reliability],
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

  # @return [String], return the reliability label associated to answer (default: "yes")
  def get_reliability(reliability_index)
    reliability_index.present? ? @@reliability_values[reliability_index][:label] : @@reliability_values.first[:label]
  end

  # @return [String], return the label of collections in the specific index
  def get_indexed(collection, index)
    Rails.logger.debug "Index: #{collection} #{index}"
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
    response = { max_value: @@water_capExp_absolute_range[:max], min_value: @@water_capExp_absolute_range[:min]}
    case latrine_sources_index
      when 2..3
        response.merge( below_value: 36, above_value:  358)
      when 4..5
        response.merge( below_value: 92, above_value: 358 )
      else
        # modify max limit due business rules
        response[:max_value]=50
        response.merge({ below_value: 7, above_value: 26 })
    end
  end

  def recurrent_range_latrine_based(latrine_sources_index)
    case latrine_sources_index
      when 2..3
        { max_value: 17, min_value: 0, below_value: 2.5 , above_value: 8.5 }
      when 4..5
        { max_value: 23, min_value: 0, below_value: 3.5, above_value: 11.5 }
      else
        { max_value: 8, min_value: 0, below_value: 1.5, above_value: 4.0 }
    end
  end


  @@recEx_rating_code = {
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
      max: 500,
  }

  @@water_recurrent_absolute_range = {
      min: 0,
      max: 30,
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

  #@return [Integer], return 0 if the expenditure is outside of WashCost benchmark, or 1 in otherwise
  def get_cost_rating(latrine_index, capital_expenditure, recurrent_expenditure)
    latrine_index = latrine_index || 0
    expenditures = [{name: "capital", value: capital_expenditure}, {name: "recurrent", value: recurrent_expenditure}]
    benchmark_results = expenditures.map do |expenditure|
      is_value_in_benchmark_of expenditure[:name], expenditure[:value], latrine_index
    end
    Rails.logger.debug 'Benchmark results: #{benchmark_results}'
    benchmark_results.all? ? 1 : 0
  end

  #@return [Boolean], return true if the value is within the benchmark in the expediture associated, in othwerwise the
  # method return false
  def is_value_in_benchmark_of(expenditure, value, latrine_index)
    latrine_index = latrine_index || 0
    value = value || 0
    range = send "#{expenditure}_range_latrine_based".to_sym, latrine_index
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


  def get_rating(providing, impermeability, environment, usage, reliability)
    Rails.logger.debug "Service ratings are: providing: #{providing} impermeability: #{impermeability} environment: #{environment} usage: #{usage} reliability: #{reliability}"
    return nil unless [providing, impermeability, environment, usage, reliability].all?
    rating_for_combined_service_levels(providing, impermeability, environment, usage, reliability)
  end

  #Used to normalise reliability so that the best service is represented with index = 3
  def normalise_best_level_to_be_2(level)
    { 0 => 2, 1 => 1, 2 => 0}[level]
  end

  #@return [Integer], used to map the index collect from usage and quality indicators according to business rules
  def map_to_index_washcost(index)
    { 0 => 4, 1 => 3, 2 => 1}[index]
  end

  def get_capex_benchmark_rating(latrineIndex, ex)
    bench= @@latrine_values[latrineIndex][:capExBench]
    rating_for_expenditure ex, bench[:min], bench[:max]
  end

  def get_recex_benchmark_rating(latrineIndex, ex)
    bench= @@latrine_values[latrineIndex][:recExBench]
    rating_for_expenditure ex, bench[:min], bench[:max]
  end

  #@return [Float], return the specific expenditure score according to position regarding to associated benchmark
  def score_expenditure_benchmark(latrine_index, expenditure_name, expenditure_value)
    benchmark = send "#{expenditure_name}_range_latrine_based".to_sym, latrine_index
    rating_for_expenditure expenditure_value, benchmark[:below_value], benchmark[:above_value]
  end

  def rating_for_combined_service_levels(providing, impermeability, environment, usage, reliability)
    access_rating = get_access_service_level(providing, impermeability)
    environment_rating = rating_for_service_level environment
    usage_rating = rating_for_service_level usage
    reliability_rating = rating_for_service_level reliability
    min_rating = [access_rating, environment_rating, usage_rating, reliability_rating].min
    Rails.logger.debug "Service ratings are: access_rating: #{access_rating} [providing: #{providing} +  impermeability: #{impermeability}], environment: #{environment_rating}, usage: #{usage_rating}, reliability: #{reliability_rating} and minimum is #{min_rating}"
    min_rating
  end

  def get_access_service_level(providing, impermeability)
    [ [3, 1], [2, 1] ][providing][impermeability]
  end

  def rating_for_service_level(level)
    { 0 => 3, 1 => 2, 2 => 1 }[level]
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

  #@return [String], return the full review associated to recurrent expenditure, quality and reliability, capExp,
  # providing, impermeability and environment indicators
  def get_level_of_service(latrine_index, recurrent_value, usage_index, reliability_index, capital_value, providing_index, impermeability_index, environment_index)
    if latrine_index && recurrent_value && usage_index && reliability_index
      recurrent_expenditure_score = score_expenditure_benchmark(latrine_index, 'recurrent', recurrent_value)
      recurrent_expenditure_code = @@recEx_rating_code[recurrent_expenditure_score]
      usage_code =  map_to_index_washcost(usage_index)
      reliability_code =  map_to_index_washcost(reliability_index)
      # the concatenation first group service join up the recExp, usage and reliability indicators
      concat_first_service_group = recurrent_expenditure_code.to_s + usage_code.to_s + reliability_code.to_s

      capital_expenditure_score = score_expenditure_benchmark(latrine_index, 'capital', capital_value)
      capital_expenditure_code = @@capEx_rating_code[capital_expenditure_score]
      #usage_code =  map_to_index_washcost(usage_index)
      accessibility_code = access_service_level(providing_index, impermeability_index)
      evironment_code =  map_to_index_washcost(environment_index)
      # the concatenation second group service join up the capExp, household latrine, impermeability and environment indicators
      concat_second_service_group = capital_expenditure_code.to_s + accessibility_code.to_s + evironment_code.to_s
      puts '----------------------', concat_second_service_group
      Rails.logger.debug 'Level of Service: #{concat_first_service_group}'
      "#{t ('report.sanitation_basic.a' + concat_first_service_group)} \n #{t ('report.sanitation_basic.b' + concat_second_service_group)}"
    else
      'Please complete the form.'
    end
  end

  def access_service_level(providing_index,  impermeability_index)
    providing_index = providing_index || 1
    impermeability_index = impermeability_index || 1
    rule = providing_index + impermeability_index
    case rule
      when 0
        4
      when 2
        1
      else
        impermeability_index==0 ? 3 : 1
    end
  end

  def is_form_ready?(form)
    [form[:latrine], form[:capital], form[:recurrent], form[:reliability]].all?
  end
end
