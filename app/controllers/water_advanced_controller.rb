class WaterAdvancedController < ApplicationController


  layout "water_advanced_layout"

  def index



  end

  def report

    results= {
      :calculator_type => get_calculator_type,

      :country => get_country(params[:country]),
      :area_type => get_area_type(params[:area_type]),

      :how_managed => get_management(params[:how_managed]),
      :who_finances => get_management(params[:who_finances]),
      :who_owns => get_management(params[:who_owns]),
      :who_safeguards => get_management(params[:who_safeguards]),
      :who_enforces => get_management(params[:who_enforces]),
      :who_repairs => get_management(params[:who_repairs]),
      :annual_income => get_management(params[:annual_income]),

      :supply_system => get_supply_system(params[:supply_system]),
      :inauguration => get_inauguration(params[:inauguration]),
      :water_sources => get_water_sources(params[:water_sources]),
      :water_storage => get_water_storage(params[:water_storage]),
      :treatment => get_treatment(params[:treatment]),
      :power_supply => get_power_supply(params[:power_supply]),
      :transmission => get_transmission(params[:transmission]),
      :piped => get_piped(params[:piped]),

      :total_cost => get_total_cost(params[:total_cost]),

      :hardware => get_hardware(params[:hardware]),
      :software => get_software(params[:software]),
      :maintenance => get_maintenance(params[:maintenance]),
      :direct => get_direct(params[:direct]),
      :indirect => get_indirect(params[:indirect]),

      :loan =>  get_loan(params[:loan]),
      :payback =>  get_payback(params[:payback])
    }

    flash[:results]= results


    render layout: 'report_water_advanced'
  end

  def get_calculator_type

    return 'Planned Scheme'
  end

  def get_country(country_code)

    country= Country.new(country_code)
    if(country.data == nil)
      country = nil
    end

    add_to_session_form('country', country)
    return country
  end

  def get_area_type(index)

    text= 'Value Not Set'

    if index
      text= I18n.t 'form.water_advanced.area_type.answers.a'+index
    end

    return text
  end

  def get_management(index)

    text= 'Value Not Set'

    if index
      text= I18n.t 'form.water_advanced.management.shared.answers.a'+index
    end

    return text
  end


  def get_how_managed(how_managed)
  
    return 'blergh'
  end
    
  def get_who_finances(who_finances)

    return 'blergh'
  end

  def get_who_owns(who_owns)

    return 'blergh'
  end

  def get_who_safeguard(who_safeguards)

    return 'blergh'
  end

  def get_who_enforces(who_enforces)

    return 'blergh'
  end

  def get_who_repairs(who_repairs)

    return 'blergh'
  end

  def get_annual_income(annual_income)

    return 'blergh'

  end

  def get_supply_system(supply_system)

    return 'blergh'
  end

  def get_inauguration(inauguration)

    return 'blergh'
  end

  def get_water_sources(water_sources)

  end

  def get_water_storage(water_storage)

    return 'blergh'
  end

  def get_treatment(treatment)

    return 'blergh'
  end

  def get_power_supply(power_supply)

    return 'blergh'
  end

  def get_transmission(transmission)

    return 'blergh'
  end

  def get_piped(piped)


    return 'blergh'
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
      form[key]= value

      session[:water_advanced]= form
      puts session[:water_advanced]
    end
end