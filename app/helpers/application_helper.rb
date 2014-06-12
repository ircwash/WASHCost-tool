# encoding: utf-8
module ApplicationHelper

  def options_for_languages
    [ [ 'English', 'en' ], [ 'Français', 'fr' ] ]
  end

  # Created as for some reason main functions have been written against inherited model schema
  def convert_to_usd( q, value, precision = 2 )

    report_currency = q["currency"].to_s.upcase

    exchange_for_currency = ExchangeRate.find_by(name: report_currency)

    rate = exchange_for_currency != nil ? exchange_for_currency.rate.to_f : 1

    total = (value.to_f / rate.to_f)

    # Testing...

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

    # end testing

    #value != nil ? "#{( report_currency || '' ).upcase} #{number_with_precision( total.to_f, :precision => precision )}" : t( 'report.no_data' )
    value != nil ? "USD #{number_with_precision( total.to_f, :precision => precision )}" : "---"
  end

  def total_expenditure_for_years(q, years)
    total = hardware_and_software_expenditure(q) + total_operation_expenditure(q) * years + total_capital_maintenance_expenditure(q) * years + direct_support_cost(q) * total_population(q) * years + indirect_support_cost(q) * total_population(q) * years + cost_of_capital_for_years( q, years )
  end

  def hardware_and_software_expenditure(q)
    q['supply_system_technologies'].each_with_index.map{ |s,i| q['actual_hardware_expenditure'][i].to_f + q['actual_software_expenditure'][i].to_f }.inject(:+)
  end

  def total_operation_expenditure(q)
    q['minor_operation_expenditure'].map{ |e| e.to_f }.inject(:+)
  end

  def total_capital_maintenance_expenditure(q)
    q['capital_maintenance_expenditure'].map{ |e| e.to_f }.inject(:+)
  end

  def direct_support_cost(q)
    q['direct_support_cost'] != nil ? q['direct_support_cost'].to_f : 0
  end

  def total_population(q)
    q['system_population_actual'].map{ |p| p.to_f }.inject(:+)
  end

  def indirect_support_cost(q)
    q['indirect_support_cost'] != nil ? q['indirect_support_cost'].to_f : 0
  end

  def cost_of_capital_for_years(q, years)
    q['supply_system_technologies'].each_with_index.map{ |s,i| q['loan_cost'][i].to_f * [ q['loan_payback_period'][i].to_i, years ].min }.inject( :+ )
  end
  #end functions

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

  def GetCountryFromCode(code)
    if code.nil?
      t('report.code_not_found')
    else
      country = Country.find_country_by_alpha2(code)
      country.name
    end
  end

  def GetCurrencyFromCode(code)
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
      [ t( 'report.status.neither' ), '0' ],
      [ t( 'report.status.installed' ), '1' ],
      [ t( 'report.status.planned' ), '2' ],
      [ t( 'report.status.unknown' ), '3' ]
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
