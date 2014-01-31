class AdvancedSanitationQuestionnaire < Session

  attr_accessor :water_system_exists,
                :country,
                :currency,
                :year_of_expenditure,
                :region,
                :town,
                :area_type,
                :population_density,

                :service_management,
                :construction_financier,
                :infrastructure_operator,
                :service_responsbility,
                :standard_enforcer,
                :rehabilitation_cost_owner,
                :annual_household_income,
                :household_size,

                :supply_system_technologies,
                :systems_number,
                :system_population_design,
                :system_population_actual,

                :actual_hardware_expenditure,
                :system_lifespan_expectancy,
                :actual_software_expenditure,
                :unpaid_labour,
                :minor_operation_expenditure,
                :capital_maintenance_expenditure,
                :loan_cost,
                :loan_payback_period,
                :direct_support_cost,
                :indirect_support_cost,

                :service_level_name,
                :service_level_share,
                :national_accessibility_norms,
                :national_use_norms,
                :national_reliability_norms,
                :national_environmental_protection_norms


  def initialize( session )
    super( session, :advanced_sanitation )
  end


  def reset

    set_properties

    archive

  end


  def update_attributes( attributes )

    if attributes[ :water_treatment_0 ] != nil || attributes[ :water_treatment_1 ] != nil || attributes[ :water_treatment_2 ] != nil

      @water_treatment = []

      if attributes[ :water_treatment_0 ] != nil
        @water_treatment.push attributes[ :water_treatment_0 ]
      end

      if attributes[ :water_treatment_1 ] != nil
        @water_treatment.push attributes[ :water_treatment_1 ]
      end

      if attributes[ :water_treatment_2 ] != nil
        @water_treatment.push attributes[ :water_treatment_2 ]
      end

    end

    if attributes[ :power_supply_0 ] != nil || attributes[ :power_supply_1 ] != nil || attributes[ :power_supply_2 ] != nil

      @power_supply    = []

      if attributes[ :power_supply_0 ] != nil
        @power_supply.push attributes[ :power_supply_0 ]
      end

      if attributes[ :power_supply_1 ] != nil
        @power_supply.push attributes[ :power_supply_1 ]
      end

      if attributes[ :power_supply_2 ] != nil
        @power_supply.push attributes[ :power_supply_2 ]
      end

    end

    super

    if attributes[ :region_unknown ] != nil
      @region = attributes[ :region_unknown ]
    end

    if attributes[ :town_unknown ] != nil
      @town = attributes[ :town_unknown ]
    end

    if attributes[ :population_density_unknown ] != nil
      @population_density = attributes[ :population_density_unknown ]
    end

    archive

  end


  def complete
    attributes_with_values = 0

    attributes.each do |attribute|
      value = send( "#{attribute}" )

      if value != nil && value.kind_of?( Array ) && value & [''] == value
        value = nil
      end

      if value != nil
        attributes_with_values = attributes_with_values + 1
      end
    end

    100 * attributes_with_values / self.attributes.count
  end


  # CALCULATIONS

  def total_population
    if supply_system_technologies.count > 0 && system_population_actual.count == supply_system_technologies.count
      supply_system_technologies.each_with_index.map{ |s,i| system_population_actual[i].to_f }.inject(:+)
    else
      nil
    end
  end

  def total_expenditure_for_years( years )
    if hardware_and_software_expenditure != nil && expected_operation_expenditure_per_person_per_year != nil && expected_capital_maintenance_expenditure_per_person_per_year != nil && expected_direct_support_cost_per_person_per_year != nil && total_population != nil && direct_support_cost != nil && indirect_support_cost != nil
      years * ( hardware_and_software_expenditure + ( expected_operation_expenditure_per_person_per_year + expected_capital_maintenance_expenditure_per_person_per_year + expected_direct_support_cost_per_person_per_year ) * total_population + direct_support_cost.to_f + indirect_support_cost.to_f )
    else
      nil
    end
  end

  def hardware_and_software_expenditure
    if supply_system_technologies.count > 0 && actual_hardware_expenditure.count == supply_system_technologies.count && actual_software_expenditure.count == supply_system_technologies.count
      supply_system_technologies.each_with_index.map{ |s,i| actual_hardware_expenditure[i].to_f + actual_software_expenditure[i].to_f }.inject(:+)
    else
      nil
    end
  end

  # expenditure

  def operation_expenditure_per_person_per_year
    if supply_system_technologies.count > 0 && minor_operation_expenditure.count == supply_system_technologies.count && system_population_actual.count == supply_system_technologies.count
      supply_system_technologies.each_with_index.map{ |s,i| minor_operation_expenditure[i].to_f / system_population_actual[i].to_f }.inject(:+)
    else
      nil
    end
  end

  def capital_maintenance_expenditure_per_person_per_year
    if supply_system_technologies.count > 0 && capital_maintenance_expenditure.count == supply_system_technologies.count && system_population_actual.count == supply_system_technologies.count
      supply_system_technologies.each_with_index.map{ |s,i| capital_maintenance_expenditure[i].to_f / system_population_actual[i].to_f }.inject(:+)
    else
      nil
    end
  end

  def cost_of_capital_per_person_per_year
    if supply_system_technologies.count > 0 && loan_cost.count == supply_system_technologies.count && loan_payback_period.count == supply_system_technologies.count && system_population_actual.count == supply_system_technologies.count
      supply_system_technologies.each_with_index.map{ |s,i| ( loan_cost[i].to_f * [ loan_payback_period[i].to_i, 30 ].min / 30) / system_population_actual[i].to_f }.inject(:+)
    else
      nil
    end
  end

  def direct_support_cost_per_person_per_year
    if direct_support_cost != nil && total_population != nil
      direct_support_cost.to_f / total_population
    else
      nil
    end
  end

  def indirect_support_cost_per_person_per_year
    if indirect_support_cost != nil && total_population != nil
      indirect_support_cost.to_f / total_population
    else
      nil
    end
  end

  def total_inputted_expenditure_per_person_per_year
    if operation_expenditure_per_person_per_year != nil && capital_maintenance_expenditure_per_person_per_year != nil && cost_of_capital_per_person_per_year != nil && direct_support_cost_per_person_per_year != nil && indirect_support_cost_per_person_per_year != nil
      operation_expenditure_per_person_per_year + capital_maintenance_expenditure_per_person_per_year + cost_of_capital_per_person_per_year + direct_support_cost_per_person_per_year + indirect_support_cost_per_person_per_year
    else
      nil
    end
  end

  def expected_operation_expenditure_per_person_per_year
    if benchmark_minor_operation_expenditure != nil && total_population != nil
      benchmark_minor_operation_expenditure.to_f / total_population
    else
      nil
    end
  end

  def expected_capital_maintenance_expenditure_per_person_per_year
    if benchmark_capital_maintenance_expenditure != nil && total_population != nil
      benchmark_capital_maintenance_expenditure.to_f / total_population
    else
      nil
    end
  end

  def expected_direct_support_cost_per_person_per_year
    if benchmark_direct_support_cost != nil && total_population != nil
      benchmark_direct_support_cost.to_f / total_population
    else
      nil
    end
  end

  def total_expected_expenditure_per_person_per_year
    if expected_operation_expenditure_per_person_per_year != nil && expected_capital_maintenance_expenditure_per_person_per_year != nil && cost_of_capital_per_person_per_year != nil && expected_direct_support_cost_per_person_per_year != nil && indirect_support_cost_per_person_per_year != nil
      expected_operation_expenditure_per_person_per_year + expected_capital_maintenance_expenditure_per_person_per_year + cost_of_capital_per_person_per_year + expected_direct_support_cost_per_person_per_year + indirect_support_cost_per_person_per_year
    else
      nil
    end
  end

  def expected_operation_expenditure_delta_per_person_per_year
    if operation_expenditure_per_person_per_year != nil && expected_operation_expenditure_per_person_per_year != nil
      operation_expenditure_per_person_per_year - expected_operation_expenditure_per_person_per_year
    else
      nil
    end
  end

  def expected_capital_maintenance_expenditure_delta_per_person_per_year
    if capital_maintenance_expenditure_per_person_per_year != nil && expected_capital_maintenance_expenditure_per_person_per_year != nil
      capital_maintenance_expenditure_per_person_per_year - expected_capital_maintenance_expenditure_per_person_per_year
    else
      nil
    end
  end

  def expenditure_of_direct_support_delta_per_person_per_year
    if direct_support_cost_per_person_per_year != nil && direct_support_cost_per_person_per_year != nil
      direct_support_cost_per_person_per_year - direct_support_cost_per_person_per_year
    else
      nil
    end
  end

  def total_expenditure_delta_per_person_per_year
    if total_inputted_expenditure_per_person_per_year != nil && total_expected_expenditure_per_person_per_year != nil
      total_inputted_expenditure_per_person_per_year - total_expected_expenditure_per_person_per_year
    else
      nil
    end
  end

  # affordability

  def annual_household_income_per_person
    if annual_household_income != nil && household_size != nil
      annual_household_income.to_f / household_size.to_f
    else
      nil
    end
  end

  def people_with_service_meeting_national_standard
    if service_level_name.count > 0 && ( national_accessibility_norms.count > 0 || national_use_norms.count > 0 || national_environmental_protection_norms.count > 0 || national_reliability_norms.count > 0 )
      service_level_name.each_with_index.map{ |sl,i| ( national_accessibility_norms[i].to_i == 0 || national_use_norms[i].to_i == 0 || national_environmental_protection_norms[i].to_i == 0 || national_reliability_norms[i].to_i == 0 ) ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def total_actual_users
    if system_population_actual.count > 0
      system_population_actual.map{ |spd| spd.to_f }.inject(:+)
    else
      nil
    end
  end

  def total_designed_users
    if system_population_design.count > 0
      system_population_design.map{ |spa| spa.to_f }.inject(:+)
    else
      nil
    end
  end

  # affordability inputted actual users

  def annual_operational_expenditure_for_actual_users
    if minor_operation_expenditure.count > 0 && total_actual_users != nil
      minor_operation_expenditure.each.map{ |moe| moe.to_f }.inject(:+) / total_actual_users
    else
      nil
    end
  end

  def annual_operational_expenditure_for_actual_users_as_percentage_of_household_income
    if annual_operational_expenditure_for_actual_users != nil && annual_household_income != nil
      100 * annual_operational_expenditure_for_actual_users / annual_household_income.to_f
    else
      nil
    end
  end

  def annual_capital_maintenance_expenditure_for_actual_users
    if capital_maintenance_expenditure.count > 0 && total_actual_users != nil
      capital_maintenance_expenditure.each.map{ |cme| cme.to_f }.inject(:+) / total_actual_users
    else
      nil
    end
  end

  def annual_capital_maintenance_expenditure_for_actual_users_as_percentage_of_household_income
    if annual_capital_maintenance_expenditure_for_actual_users != nil && annual_household_income != nil
      100 * annual_capital_maintenance_expenditure_for_actual_users / annual_household_income.to_f
    else
      nil
    end
  end

  def total_annual_expenditure_for_actual_users
    if annual_operational_expenditure_for_actual_users != nil && annual_capital_maintenance_expenditure_for_actual_users != nil
      annual_operational_expenditure_for_actual_users + annual_capital_maintenance_expenditure_for_actual_users
    else
      nil
    end
  end

  def total_annual_expenditure_for_actual_users_as_percentage_of_household_income
    if total_annual_expenditure_for_actual_users != nil && annual_household_income != nil
      100 * total_annual_expenditure_for_actual_users / annual_household_income.to_f
    else
      nil
    end
  end

  # affordability inputted designed users

  def annual_operational_expenditure_for_designed_users
    if minor_operation_expenditure.count > 0 && total_designed_users != nil
      minor_operation_expenditure.each.map{ |moe| moe.to_f }.inject(:+) / total_designed_users
    else
      nil
    end
  end

  def annual_operational_expenditure_for_designed_users_as_percentage_of_household_income
    if annual_operational_expenditure_for_designed_users != nil && annual_household_income != nil
      100 * annual_operational_expenditure_for_designed_users / annual_household_income.to_f
    else
      nil
    end
  end

  def annual_capital_maintenance_expenditure_for_designed_users
    if capital_maintenance_expenditure.count > 0 && total_designed_users != nil
      capital_maintenance_expenditure.each.map{ |cme| cme.to_f }.inject(:+) / total_designed_users
    else
      nil
    end
  end

  def annual_capital_maintenance_expenditure_for_designed_users_as_percentage_of_household_income
    if annual_capital_maintenance_expenditure_for_designed_users != nil && annual_household_income != nil
      100 * annual_capital_maintenance_expenditure_for_designed_users / annual_household_income.to_f
    else
      nil
    end
  end

  def total_annual_expenditure_for_designed_users
    if annual_operational_expenditure_for_designed_users != nil && annual_capital_maintenance_expenditure_for_designed_users != nil
      annual_operational_expenditure_for_designed_users + annual_capital_maintenance_expenditure_for_designed_users
    else
      nil
    end
  end

  def total_annual_expenditure_for_designed_users_as_percentage_of_household_income
    if total_annual_expenditure_for_designed_users != nil && annual_household_income != nil
      100 * total_annual_expenditure_for_designed_users / annual_household_income.to_f
    else
      nil
    end
  end

  # affordability expected actual users

  def expected_annual_operational_expenditure_for_actual_users
    if benchmark_minor_operation_expenditure != nil && total_actual_users != nil
      benchmark_minor_operation_expenditure / total_actual_users
    else
      nil
    end
  end

  def expected_annual_operational_expenditure_for_actual_users_as_percentage_of_household_income
    if expected_annual_operational_expenditure_for_actual_users != nil && annual_household_income != nil
      100 * expected_annual_operational_expenditure_for_actual_users / annual_household_income.to_f
    else
      nil
    end
  end

  def expected_annual_capital_maintenance_expenditure_for_actual_users
    if benchmark_capital_maintenance_expenditure != nil && total_actual_users != nil
      benchmark_capital_maintenance_expenditure / total_actual_users
    else
      nil
    end
  end

  def expected_annual_capital_maintenance_expenditure_for_actual_users_as_percentage_of_household_income
    if expected_annual_capital_maintenance_expenditure_for_actual_users != nil && annual_household_income != nil
      100 * expected_annual_capital_maintenance_expenditure_for_actual_users / annual_household_income.to_f
    else
      nil
    end
  end

  def total_expected_annual_expenditure_for_actual_users
    if expected_annual_operational_expenditure_for_actual_users != nil && expected_annual_capital_maintenance_expenditure_for_actual_users != nil
      expected_annual_operational_expenditure_for_actual_users + expected_annual_capital_maintenance_expenditure_for_actual_users
    else
      nil
    end
  end

  def total_expected_annual_expenditure_for_actual_users_as_percentage_of_household_income
    if total_expected_annual_expenditure_for_actual_users != nil && annual_household_income != nil
      100 * total_expected_annual_expenditure_for_actual_users / annual_household_income.to_f
    else
      nil
    end
  end


  # BENCHMARK VALUES

  def benchmark_minor_operation_expenditure
    11
  end

  def benchmark_capital_maintenance_expenditure
    13
  end

  def benchmark_direct_support_cost
    40
  end


  private


  def set_properties

    # context
    @water_system_exists                      = nil
    @country                                  = nil
    @currency                                 = nil
    @year_of_expenditure                      = nil
    @region                                   = nil
    @town                                     = nil
    @area_type                                = nil
    @population_density                       = nil

    # system management
    @service_management                       = []
    @construction_financier                   = []
    @infrastructure_operator                  = []
    @service_responsbility                    = []
    @standard_enforcer                        = []
    @rehabilitation_cost_owner                = []
    @annual_household_income                  = nil
    @household_size                           = nil

    # system characteristics
    @supply_system_technologies               = []
    @systems_number                           = []
    @system_population_design                 = []
    @system_population_actual                 = []

    # cost
    @actual_hardware_expenditure              = []
    @system_lifespan_expectancy               = []
    @actual_software_expenditure              = []
    @unpaid_labour                            = []
    @minor_operation_expenditure              = []
    @capital_maintenance_expenditure          = []
    @loan_cost                                = []
    @loan_payback_period                      = []
    @direct_support_cost                      = nil
    @indirect_support_cost                    = nil

    # service level
    @service_level_name                       = []
    @service_level_share                      = []
    @national_accessibility_norms             = []
    @national_use_norms                       = []
    @national_reliability_norms               = []
    @national_environmental_protection_norms  = []

  end

end