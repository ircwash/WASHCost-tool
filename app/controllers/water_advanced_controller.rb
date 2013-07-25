# encoding: utf-8
class WaterAdvancedController < ApplicationController

  layout "water_advanced_questionnaire"

  def index
    if session[:water_advanced]
      copy_session_form_values_to_flash
    else
      if params.has_key?(:type) && (params[:type]== 'existing' || params[:type]== 'planned')
        flash[:type]= params[:type]
      else
        redirect_to :controller => "application", :action => "select_advanced"
      end
    end
  end


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

      :supply_system => get_indexed_value('form.advanced.water.supply_system.answers.a', :supply_system),
      :inauguration =>  unchecked(:inauguration),
      :water_sources => get_indexed_value('form.advanced.water.water_sources.answers.a', :water_sources),
      :water_storage => get_indexed_value('form.advanced.water.water_storage.answers.a', :water_storage),
      :treatment =>     get_indexed_value('form.advanced.water.treatment.answers.a', :treatment),
      :power_supply =>  get_indexed_value('form.advanced.water.power_supply.answers.a',:power_supply),
      :transmission =>  unchecked(:transmission),
      :piped =>         unchecked(:piped),

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


    render layout: 'water_advanced_report'
  end

  def copy_session_form_values_to_flash

    form_params= [
        :type,
        :country, :region, :city, :area_type, :density,
        :how_managed, :who_finances, :who_owns, :who_safeguards, :who_enforces, :who_repairs, :annual_income,
        :supply_system, :inauguration, :water_sources, :water_sources, :water_storage, :treatment, :power_supply, :transmission, :piped,
        :total_cost, :hardware,
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

    index= params[key]

    text= 'Value Not Set'

    if index
      text= I18n.t i18nPrefix+index

      add_to_session_advanced(key, index)
    end

    return text
  end


  def add_to_session_advanced(key, value)
    form= session[:water_advanced].present? ? session[:water_advanced] : Hash.new(0)

    if !form[key].present?
      increase_complete_percent(:water_advanced_completed)
    end

    form[key]= value

    session[:water_advanced]= form
  end

end