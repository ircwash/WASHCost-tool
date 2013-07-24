class WaterAdvancedController < ApplicationController


  layout "water_advanced_layout"

  def index
    if session[:water_advanced]
      copy_session_form_values_to_flash
    else
      init_session_form
    end

    puts "WATER ADVANCED"
    puts flash
  end


  def report

    results= {
      :calculator_type => get_calculator_type,

      :country => get_country(params[:country]),
      :region => unchecked(:region, params[:region]),
      :city=> unchecked(:city, params[:city]),
      :density => get_indexed_value('form.water_advanced.density.answers.a', :density),
      :area_type => get_indexed_value('form.water_advanced.area_type.answers.a', :area_type),

      :who_finances =>  get_indexed_value('form.water_advanced.management.shared.answers.a', :who_finances),
      :who_owns =>      get_indexed_value('form.water_advanced.management.shared.answers.a', :who_owns),
      :who_safeguards =>get_indexed_value('form.water_advanced.management.shared.answers.a', :who_safeguards),
      :who_enforces =>  get_indexed_value('form.water_advanced.management.shared.answers.a', :who_enforces),
      :who_repairs =>   get_indexed_value('form.water_advanced.management.shared.answers.a', :who_repairs),
      :annual_income => unchecked(:annual_income, nil),

      :supply_system => get_indexed_value('form.water_advanced.supply_system.answers.a', :supply_system),
      :inauguration =>  unchecked(:inauguration, nil),
      :water_sources => get_indexed_value('form.water_advanced.water_sources.answers.a', :water_sources),
      :water_storage => get_indexed_value('form.water_advanced.water_storage.answers.a', :water_storage),
      :treatment =>     get_indexed_value('form.water_advanced.treatment.answers.a', :treatment),
      :power_supply =>  get_indexed_value('form.water_advanced.power_supply.answers.a',:power_supply),
      :transmission =>  unchecked(:transmission, nil),
      :piped =>         unchecked(:piped, nil),

      :total_cost =>    get_total_cost(params[:hardware],params[:software]),

      :hardware =>      unchecked(:hardware, nil),
      :software =>      unchecked(:software, nil),
      :maintenance =>   unchecked(:maintenance, nil),
      :direct =>        unchecked(:direct, nil),
      :indirect =>      unchecked(:indirect, nil),

      :loan =>          unchecked(:loan, nil),
      :payback =>       unchecked(:payback, nil)
    }

    flash[:results]= results


    render layout: 'report_water_advanced'
  end

  def init_session_form
    session[:water_advanced]= Hash.new(0)
  end

  def copy_session_form_values_to_flash

    form_params= [
        :country, :region, :city, :area_type, :density,
        :how_managed, :who_finances, :who_owns, :who_safeguards, :who_enforces, :who_repairs, :annual_income,
        :supply_system, :inauguration, :water_sources, :water_sources, :water_storage, :treatment, :power_supply, :transmission, :piped,
        :total_cost, :hardware, :software, :maintenance, :direct, :indirect,
        :loan, :payback
    ]

    form_params.each do |param|
      flash[param]= session[:water_advanced][param]
    end

    puts flash
  end


  def get_calculator_type

    return 'Planned Scheme'
  end

  def get_country(country_code)

    country= Country.new(country_code)
    if(country.data == nil)
      country = nil
    else
      country= country.name
    end

    add_to_session_advanced('country', country)
    return country
  end

  def unchecked(key, value)

    add_to_session_advanced(key, value)
    return value

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
    puts session[:water_advanced]
  end

end