# encoding: utf-8
class SanitationAdvancedController < ApplicationController

  layout "sanitation_advanced_questionnaire"

  def report

    results= {
        :type =>  unchecked(:type),

        :country => get_country(params[:country]),
        :region => unchecked(:region),
        :city=> unchecked(:city),
        :density => get_indexed_value('form.advanced.shared.density.answers.a', :density),
        :area_type => get_indexed_value('form.advanced.shared.area_type.answers.a', :area_type),

        :who_finances =>  get_indexed_value('form.advanced.shared.management.shared.answers.a', :who_finances),
        :who_owns =>      get_indexed_value('form.advanced.shared.management.shared.answers.a', :who_owns),
        :who_safeguards =>get_indexed_value('form.advanced.shared.management.shared.answers.a', :who_safeguards),
        :who_enforces =>  get_indexed_value('form.advanced.shared.management.shared.answers.a', :who_enforces),
        :who_repairs =>   get_indexed_value('form.advanced.shared.management.shared.answers.a', :who_repairs),
        :annual_income => unchecked(:annual_income),



        :total_cost =>    get_total_cost(params[:hardware],params[:software]),

        :hardware =>      unchecked(:hardware),
        :cost_hardware_alt_0 => checkbox_value(:cost_hardware_alt_0),
        :cost_hardware_alt_1 => checkbox_value(:cost_hardware_alt_1),
        :software =>      unchecked(:software),
        :cost_software_alt_0 => checkbox_value(:cost_software_alt_0),
        :cost_software_alt_1 => checkbox_value(:cost_software_alt_1),
        :maintenance =>   unchecked(:maintenance),
        :cost_maintenance_alt_0 => checkbox_value(:cost_maintenance_alt_0),
        :cost_maintenance_alt_1 => checkbox_value(:cost_maintenance_alt_1),
        :direct =>        unchecked(:direct),
        :cost_direct_alt_0 => checkbox_value(:cost_direct_alt_0),
        :cost_direct_alt_1 => checkbox_value(:cost_direct_alt_1),
        :indirect =>      unchecked(:indirect),
        :cost_indirect_alt_0 => checkbox_value(:cost_indirect_alt_0),
        :cost_indirect_alt_1 => checkbox_value(:cost_indirect_alt_1),
        :loan =>          unchecked(:loan),
        :cost_loan_alt_0 => checkbox_value(:cost_loan_alt_0),
        :cost_loan_alt_1 => checkbox_value(:cost_loan_alt_1),
        :payback =>       unchecked(:payback)
    }

    flash[:results]= results


    render layout: 'sanitation_advanced_report'
  end

  def copy_session_form_values_to_flash

    form_params= [
        :type,
        :country, :country_code, :region, :city, :area_type, :density,
        :how_managed, :who_finances, :who_owns, :who_safeguards, :who_enforces, :who_repairs, :annual_income,


        :total_cost,
        :hardware,
        :cost_hardware_alt_0, :cost_hardware_alt_1,
        :software,
        :cost_software_alt_0, :cost_software_alt_1,
        :maintenance,
        :cost_maintenance_alt_0, :cost_maintenance_alt_1,
        :direct,
        :cost_direct_alt_0, :cost_direct_alt_1,
        :indirect,
        :cost_indirect_alt_0, :cost_indirect_alt_1,
        :loan,
        :cost_loan_alt_0, :cost_loan_alt_1,
        :payback
    ]

    form_params.each do |param|
      flash[param]= session[:water_advanced][param]
    end
  end

  def index
    if session[:sanitation_advanced]
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
    form= session[:sanitation_advanced].present? ? session[:sanitation_advanced] : Hash.new(0)

    if !form[key].present?
      increase_complete_percent(:sanitation_advanced_complete)
    end

    form[key]= value

    session[:sanitation_advanced]= form
  end


end