# encoding: utf-8
module ApplicationHelper

  def options_for_countries
    Country.all.sort{ |a,b| a[0] <=> b[0] }
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

  def show_app_version
    if SHOW_APP_VERSION
      %Q{<div class="application_version">Current version is: #{APP_VERSION}</div>}.html_safe
    else
      %Q{<div style="display:none">Current version is: #{APP_VERSION}</div>}.html_safe
    end
  end

  def show_debugger
    link_to 'debugger', '#',class: 'debug-trigger-button'
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
