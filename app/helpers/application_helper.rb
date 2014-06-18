# encoding: utf-8
module ApplicationHelper

  def options_for_languages
    [ [ 'English', 'en' ], [ 'Français', 'fr' ] ]
  end

  # Created duplicate functions here as the majority of functions have been built directly against the model(s)
  # These functions are not ideal and depending in the how live this data should be - consider moving so as calculated 
  # and stored in the DB

  def convert_to_usd( q, value, precision = 2 )

    total = 0

    if q != nil && q["currency"] != nil

      report_year = q["year_of_expenditure"].to_i
      report_currency = q["currency"].to_s.upcase

      deflator = Deflator.find_by(name: report_currency, year: report_year)
      
      exchange_for_currency = ExchangeRate.find_by(name: report_currency)
      rate = exchange_for_currency != nil ? exchange_for_currency.rate.to_f : 1
      total = (value.to_f / rate.to_f)

    end

    # to be completed

    #report_year = q["year_of_expenditure"].to_i
    #report_currency = q["currency"].to_s.upcase

    #deflator = Deflator.find_by(name: "USD")

    #country = Country.find_country_by_currency(report_currency)

    #puts country.to_json

    #deflator = Deflator.find_by(name: country.alpha3, year: report_year)

    #puts report_year
    #puts report_currency
    #puts deflator.to_json
    #puts value.to_f

    #exchange = ExchangeRate.find_by(name: "USD")

    #value != nil ? "#{( report_currency || '' ).upcase} #{number_with_precision( total.to_f, :precision => precision )}" : t( 'report.no_data' )
  
    # end testing

    value != nil ? "#{number_with_precision( number_to_currency(total.to_f, :locale => I18n.locale), :precision => precision )}" : "---"
  end

  def capital_expenditure_per_person(q)
    a = hardware_and_software_expenditure(q)
    b = total_population(q)
    if q != nil && a != nil && b != nil && a != 0 && b != 0
      (a / b).to_f
    else
      0
    end
  end

  def recurrent_expenditure_per_person_per_year(q, years)
    if q != nil
      total = total_operation_expenditure(q) * years + total_capital_maintenance_expenditure(q) * years + direct_support_cost(q) * total_population(q) * years + indirect_support_cost(q) * total_population(q) * years + cost_of_capital_for_years( q, years )
    else
      0
    end
  end

  def total_expenditure_for_years(q, years)
    if q != nil
      total = hardware_and_software_expenditure(q) + total_operation_expenditure(q) * years + total_capital_maintenance_expenditure(q) * years + direct_support_cost(q) * total_population(q) * years + indirect_support_cost(q) * total_population(q) * years + cost_of_capital_for_years( q, years )
    else
      0
    end
  end

  def hardware_and_software_expenditure(q)
    if q['supply_system_technologies'] != nil && q['supply_system_technologies'].count > 0 && q['actual_hardware_expenditure'] != nil && q['actual_hardware_expenditure'].count > 0 && q['actual_software_expenditure'] != nil && q['actual_software_expenditure'].count > 0
      q['supply_system_technologies'].each_with_index.map{ |s,i| q['actual_hardware_expenditure'][i].to_f + q['actual_software_expenditure'][i].to_f }.inject(:+)
    else
      0
    end
  end

  def total_operation_expenditure(q)
    if q['minor_operation_expenditure'] != nil && q['minor_operation_expenditure'].count > 0
      q['minor_operation_expenditure'].map{ |e| e.to_f }.inject(:+)
    else
      0
    end
  end

  def total_capital_maintenance_expenditure(q)
    if q['capital_maintenance_expenditure'] != nil && q['capital_maintenance_expenditure'].count > 0
      q['capital_maintenance_expenditure'].map{ |e| e.to_f }.inject(:+)
    else
      0
    end
  end

  def direct_support_cost(q)
    q['direct_support_cost'] != nil ? q['direct_support_cost'].to_f : 0
  end

  def total_population(q)
    if q['supply_system_technologies'] != nil && q['supply_system_technologies'].count > 0
      q['system_population_actual'].map{ |p| p.to_f }.inject(:+)
    else
      0
    end
  end

  def indirect_support_cost(q)
    q['indirect_support_cost'] != nil ? q['indirect_support_cost'].to_f : 0
  end

  def cost_of_capital_for_years(q, years)
    if q['supply_system_technologies'] != nil && q['supply_system_technologies'].count > 0 && q['loan_cost'] != nil && q['loan_payback_period'] != nil
      q['supply_system_technologies'].each_with_index.map{ |s,i| q['loan_cost'][i].to_f * [ q['loan_payback_period'][i].to_i, years ].min }.inject( :+ )
    else
      0
    end
  end

  #--#

  def percentage_of_population_that_meets_accessibility_norms(q)
    if q['service_level_name'] != nil &&  q['service_level_share'] != nil && q['national_accessibility_norms'] != nil && q['service_level_name'].count > 0 && q['service_level_share'].count == q['service_level_name'].count && q['national_accessibility_norms'].count == q['service_level_name'].count
      q['national_accessibility_norms'].each_with_index.map{ |nan,i| nan.to_i == 0 ? q['service_level_share'][i].to_i : 0 }.inject(:+)
    else
      0
    end
  end

  def percentage_of_population_that_does_not_meet_accessibility_norms(q)
    percentage_of_population_that_meets_accessibility_norms(q)
  end

  def percentage_of_population_with_unknown_accessibility_norms(q)
    percentage_of_population_that_meets_accessibility_norms(q)
  end

  def percentage_of_population_that_meets_quantity_norms(q)
    if q['service_level_name'] != nil &&  q['service_level_share'] != nil && q['national_quantity_norms'] != nil && q['service_level_name'].count > 0 && q['service_level_share'].count == q['service_level_name'].count && q['national_quantity_norms'].count == q['service_level_name'].count
      q['national_quantity_norms'].each_with_index.map{ |nan,i| nan.to_i == 0 ? q['service_level_share'][i].to_i : 0 }.inject(:+)
    else
      0
    end
  end

  def percentage_of_population_that_does_not_meet_quantity_norms(q)
    percentage_of_population_that_meets_quantity_norms(q)
  end

  def percentage_of_population_with_unknown_quantity_norms(q)
    percentage_of_population_that_meets_quantity_norms(q)
  end

  def percentage_of_population_that_meets_quality_norms(q)
    if q['service_level_name'] != nil &&  q['service_level_share'] != nil && q['national_quality_norms'] != nil && q['service_level_name'].count > 0 && q['service_level_share'].count == q['service_level_name'].count && q['national_quality_norms'].count == q['service_level_name'].count
      q['national_quality_norms'].each_with_index.map{ |nan,i| nan.to_i == 0 ? q['service_level_share'][i].to_i : 0 }.inject(:+)
    else
      0
    end
  end

  def percentage_of_population_that_does_not_meet_quality_norms(q)
    percentage_of_population_that_meets_quality_norms(q)
  end

  def percentage_of_population_with_unknown_quality_norms(q)
    percentage_of_population_that_meets_quality_norms(q)
  end

  def percentage_of_population_that_meets_reliability_norms(q)
    if q['service_level_name'] != nil &&  q['service_level_share'] != nil && q['national_reliability_norms'] != nil && q['service_level_name'].count > 0 && q['service_level_share'].count == q['service_level_name'].count && q['national_reliability_norms'].count == q['service_level_name'].count
      q['national_reliability_norms'].each_with_index.map{ |nan,i| nan.to_i == 0 ? q['service_level_share'][i].to_i : 0 }.inject(:+)
    else
      0
    end
  end

  def percentage_of_population_that_does_not_meet_reliability_norms(q)
    percentage_of_population_that_meets_reliability_norms(q)
  end

  def percentage_of_population_with_unknown_reliability_norms(q)
    percentage_of_population_that_meets_reliability_norms(q)
  end

  def percentage_of_population_that_meets_all_norms(q)
    if q != nil 
      [percentage_of_population_that_meets_quantity_norms(q), percentage_of_population_that_meets_accessibility_norms(q), percentage_of_population_that_meets_quality_norms(q), percentage_of_population_that_meets_reliability_norms(q)].min
    else
      0
    end
  end

  #end duplicate functions

  def options_for_countries
    translated_countries = []
    Country.all.each do |c|
      d = Country.new(c[1])
      translated_countries << [d.translations[I18n.locale.to_s], d.alpha2]
    end
    translated_countries.sort do |a, b|
      a[0].to_s <=> b[0].to_s
    end
  end

  def country_from_code(code)
    if code.nil?
      t('report.code_not_found')
    else
      country = Country.find_country_by_alpha2(code)
      country.name
    end
  end

  def currency_from_code(code)
    if code.nil?
      t('report.code_not_found')
    else
      currency = Money.new(1, code.upcase).currency
      currency.name
    end
  end

  def options_for_currencies
    Money::Currency.table.keys.map{ |c| [ c.upcase, c ] }
  end

  def options_for_major_currencies
    Money::Currency.table.inject([]) do |array, (id, attributes)|
      priority = attributes[:priority]
      if priority
        array[priority] ||= []
        array[priority] << [ :name => "#{attributes[:name]} (#{attributes[:iso_code]})", :id => id ]
      end
      array
    end.compact.flatten.map{ |c| [ c[:name], c[:id] ] }
  end

  def options_for_years
    Array(1900..Date.today.year).reverse.map{ |y| [ y, y ] }
  end

  def options_for_report_statuses
    [
      [ t('dashboard.status.not_applicable'), 0 ],
      [ t('dashboard.status.planned_expenditure'), 1 ],
      [ t('dashboard.status.budgeted_expenditure'), 2 ],
      [ t('dashboard.status.historical_expenditure'), 3 ],
      [ t('dashboard.status.mixed_expenditure'), 4 ],
      [ t('dashboard.status.dont_know'), 5 ]
    ]
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def placeholder_currency(text)
    curr = @questionnaire.currency ? @questionnaire.currency.upcase.to_s : 'USD'
    t(text).to_s + ' (' + curr  + ')'
  end

end
