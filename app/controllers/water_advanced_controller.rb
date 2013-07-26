# encoding: utf-8
class WaterAdvancedController < AdvancedController

  layout "water_advanced_questionnaire"

  @session_form= :water_advanced
  @session_complete_amount= :water_completed_amount

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

end