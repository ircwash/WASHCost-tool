class WaterAdvancedController < ApplicationController


  layout "water_advanced_layout"

  def index
    if session[:water_advanced]
      copy_session_form_values_to_flash
    else
      init_session_form
    end
  end


  def report

    results= {
      :calculator_type => get_calculator_type,

      :country => get_country(params[:country]),
      :area_type => get_indexed_value('form.water_advanced.area_type.a', :area_type),

      :who_finances =>  get_indexed_value('form.water_advanced.management.shared.answers.a', :who_finances),
      :who_owns =>      get_indexed_value('form.water_advanced.management.shared.answers.a', :who_owns),
      :who_safeguards =>get_indexed_value('form.water_advanced.management.shared.answers.a', :who_safeguards),
      :who_enforces =>  get_indexed_value('form.water_advanced.management.shared.answers.a', :who_enforces),
      :who_repairs =>   get_indexed_value('form.water_advanced.management.shared.answers.a', :who_repairs),
      :annual_income => get_annual_income(params[:annual_income]),

      :supply_system => get_indexed_value('form.water_advanced.supply_system.answers.a', :supply_system),
      :inauguration =>  get_inauguration(params[:inauguration]),
      :water_sources => get_indexed_value('form.water_advanced.water_sources.answers.a', :water_sources),
      :water_storage => get_indexed_value('form.water_advanced.water_storage.answers.a', :water_storage),
      :treatment =>     get_indexed_value('form.water_advanced.treatment.answers.a', :treatment),
      :power_supply =>  get_indexed_value('form.water_advanced.power_supply.answers.a',:power_supply),
      :transmission =>  get_transmission(params[:transmission]),
      :piped =>         get_piped(params[:piped]),

      :total_cost =>    get_total_cost(params[:total_cost]),

      :hardware =>      get_hardware(params[:hardware]),
      :software =>      get_software(params[:software]),
      :maintenance =>   get_maintenance(params[:maintenance]),
      :direct =>        get_direct(params[:direct]),
      :indirect =>      get_indirect(params[:indirect]),

      :loan =>          get_loan(params[:loan]),
      :payback =>       get_payback(params[:payback])
    }

    flash[:results]= results


    render layout: 'report_water_advanced'
  end

  def init_session_form
    session[:water_advanced]= Hash.new(0)
  end

  def copy_session_form_values_to_flash

    form_params= [
        :country, :area_type,
        :who_finances,:who_owns, :who_safeguards, :who_enforces, :who_repair, :annual_income,
        :supply_system, :inauguration, :water_sources, :water_sources, :water_storage, :treatment, :power_supply, :transmission, :piped,
        :total_cost, :hardware, :software, :maintenance, :direct, :indirect,
        :loan, :payback
    ]

    form_params.each do |param|
      flash[param]= session[:water_advanced][param]
    end
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

    add_to_session_form('country', country)
    return country
  end

  def get_annual_income(annual_income)

    return annual_income

  end

  def get_indexed_value(i18nPrefix, key)

    index= params[key]

    text= 'Value Not Set'

    if index
      text= I18n.t i18nPrefix+index

      add_to_session_form(key, index)
    end

    return text
  end

  def get_inauguration(inauguration)
    #YeAR TEST
    return inauguration
  end


  def get_transmission(transmission)
     # INT TEST
    return transmission
  end

  def get_piped(piped)

    # % TEST
    return piped
  end

  def get_total_cost(total_cost)


    return 'blergh'
  end

  def get_hardware(hardware)

    return 'blergh'
  end

  def get_software(software)

    return 'blergh'
  end

  def get_maintenance(maintenance)

    return 'blergh'
  end

  def get_direct(direct)

    return 'blergh'
  end

  def get_indirect(indirect)

    return 'blergh'
  end

  def get_loan(loan)

    return 'blergh'
  end

  def get_payback(payback)

    return 'blergh'
  end



  def add_to_session_form(key, value)
    form= session[:water_advanced].present? ? session[:water_advanced] : Hash.new(0)

    if !form[key].present?
      increase_complete_percent(:water_advanced)
    end

    form[key]= value

    session[:water_advanced]= form
    puts session[:water_advanced]
  end

end