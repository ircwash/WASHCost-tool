# encoding: utf-8
module ApplicationHelper

  def options_for_languages
    [ [ 'English', 'en' ], [ 'Français', 'fr' ] ]
  end

  def options_for_countries
    Country.all.sort{ |c1,c2| c1[0] <=> c2[0] }
  end

  def options_for_currencies
    Money::Currency.table.keys.map{ |c| [ c.upcase, c ] }
  end

  def options_for_major_currencies
    Money::Currency.table.inject([]) do |array, (id, attributes)|
      priority = attributes[:priority]

      if priority
        array[priority] ||= []
        array[priority] << id
      end

      array
    end.compact.flatten.map{ |c| [ c.upcase, c ] }
  end

  def options_for_years
    Array(1900..Date.today.year).reverse.map{ |y| [ y, y ] }
  end

  def options_for_report_statuses
    [
      [ t( 'report.status.installed' ), 'installed' ],
      [ t( 'report.status.planned' ), 'planned' ]
    ]
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
