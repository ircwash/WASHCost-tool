# encoding: utf-8
class AdvancedController < ApplicationController


  def index
    if session[:s]
      copy_session_form_values_to_flash
    else
      if params.has_key?(:type) && (params[:type]== 'existing' || params[:type]== 'planned')
        flash[:type]= params[:type]
      else
        redirect_to :controller => "application", :action => "select_advanced"
      end
    end
  end


  def checkbox_value(key)

    value= params[key]

    checked= false
    if value.present? && value.to_i> 0

      checked= true
    end


    add_to_session_advanced(key, checked)

    return checked
  end

  def get_country(country_code)

    country_object= Country.new(country_code)
    country= "Not Set"

    if(country_object.data == nil)
      country = nil
    else
      country= country_object.name
      add_to_session_advanced(:country_code, country_code)
      add_to_session_advanced('country', country)
    end

    return country
  end

  def unchecked(key)

    add_to_session_advanced(key, params[key])
    return params[key]

  end

  def get_total_cost(hardware, software)

    total_cost= 'Please enter both Hardware & Software values'
    if hardware && software
      return hardware+software
    end

  end


  def get_indexed_value(i18nPrefix, key)

    text= 'Value Not Set'

    if params.has_key?(key) && params[key]!=nil

      index= params[key]

      text= I18n.t i18nPrefix+index

      add_to_session_advanced(key, index)

    end

    return text
  end


  def add_to_session_advanced(key, value)
    form= session[@session_form].present? ? session[@session_form] : Hash.new(0)

    if !form[key].present?
      increase_complete_percent(@session_complete)
    end

    form[key]= value

    session[@session_form]= form
  end

end