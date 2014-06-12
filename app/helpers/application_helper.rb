# encoding: utf-8
module ApplicationHelper

  def options_for_languages
    [ [ 'English', 'en' ], [ 'Français', 'fr' ] ]
  end

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
