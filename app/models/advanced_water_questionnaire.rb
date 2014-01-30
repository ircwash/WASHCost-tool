class AdvancedWaterQuestionnaire < Session

  @@identifier = 'advanced_water'

  attr_accessor :water_system_exists,
                :country,
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
                :water_source,
                :surface_water_primary_source,
                :water_treatment,
                :power_supply,
                :distribution_line_length,

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
                :national_quantity_norms,
                :national_quality_norms,
                :national_reliability_norms


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
    supply_system_technologies.each_with_index.map{ |s,i| system_population_actual[i].to_f }.inject(:+)
  end

  def total_expenditure_for_years( years )
    years * ( supply_system_technologies.each_with_index.map{ |s,i| actual_hardware_expenditure[i].to_f + actual_software_expenditure[i].to_f }.inject(:+) + ( expected_operation_expenditure_per_person_per_year + expected_capital_maintenance_expenditure_per_person_per_year + expected_direct_support_cost_per_person_per_year ) * total_population + direct_support_cost.to_f + indirect_support_cost.to_f )
  end

  def operation_expenditure_per_person_per_year
    supply_system_technologies.each_with_index.map{ |s,i| minor_operation_expenditure[i].to_f / system_population_actual[i].to_f }.inject(:+)
  end

  def capital_maintenance_expenditure_per_person_per_year
    supply_system_technologies.each_with_index.map{ |s,i| capital_maintenance_expenditure[i].to_f / system_population_actual[i].to_f }.inject(:+)
  end

  def cost_of_capital_per_person_per_year
    supply_system_technologies.each_with_index.map{ |s,i| ( loan_cost[i].to_f * [ loan_payback_period[i].to_i, 30 ].min / 30) / system_population_actual[i].to_f }.inject(:+)
  end

  def direct_support_cost_per_person_per_year
    direct_support_cost.to_f / total_population
  end

  def indirect_support_cost_per_person_per_year
    indirect_support_cost.to_f / total_population
  end

  def total_inputted_expenditure_per_person_per_year
    operation_expenditure_per_person_per_year + capital_maintenance_expenditure_per_person_per_year + cost_of_capital_per_person_per_year + direct_support_cost_per_person_per_year + indirect_support_cost_per_person_per_year
  end

  def expected_operation_expenditure_per_person_per_year
    benchmark_minor_operation_expenditure.to_f / total_population
  end

  def expected_capital_maintenance_expenditure_per_person_per_year
    benchmark_capital_maintenance_expenditure.to_f / total_population
  end

  def expected_direct_support_cost_per_person_per_year
    benchmark_direct_support_cost.to_f / total_population
  end

  def total_expected_expenditure_per_person_per_year
    expected_operation_expenditure_per_person_per_year + expected_capital_maintenance_expenditure_per_person_per_year + cost_of_capital_per_person_per_year + expected_direct_support_cost_per_person_per_year + indirect_support_cost_per_person_per_year
  end

  def annual_household_income_per_person
    annual_household_income.to_f / household_size.to_f
  end

  def people_with_service_meeting_national_standard
    service_level_name.each_with_index.map{ |sl,i| ( national_accessibility_norms[i].to_i == 0 || national_quantity_norms[i].to_i == 0 || national_quality_norms[i].to_i == 0 || national_reliability_norms[i].to_i == 0 ) ? service_level_share[i].to_i : 0 }.inject(:+)
  end

  def total_actual_users
    system_population_actual.map{ |spd| spd.to_f }.inject(:+)
  end

  def total_designed_users
    system_population_design.map{ |spa| spa.to_f }.inject(:+)
  end

  def annual_operational_expenditure_for_actual_users
    minor_operation_expenditure.each.map{ |moe| moe.to_f }.inject(:+) / total_actual_users
  end

  def annual_operational_expenditure_for_actual_users_as_percentage_of_household_income
    100 * annual_operational_expenditure_for_actual_users / annual_household_income.to_f
  end

  def annual_capital_maintenance_expenditure_for_actual_users
    capital_maintenance_expenditure.each.map{ |cme| cme.to_f }.inject(:+) / total_actual_users
  end

  def annual_capital_maintenance_expenditure_for_actual_users_as_percentage_of_household_income
    100 * annual_capital_maintenance_expenditure_for_actual_users / annual_household_income.to_f
  end

  def total_annual_expenditure_for_actual_users
    annual_operational_expenditure_for_actual_users + annual_capital_maintenance_expenditure_for_actual_users
  end

  def total_annual_expenditure_for_actual_users_as_percentage_of_household_income
    100 * total_annual_expenditure_for_actual_users / annual_household_income.to_f
  end

  def annual_operational_expenditure_for_designed_users
    minor_operation_expenditure.each.map{ |moe| moe.to_f }.inject(:+) / total_designed_users
  end

  def annual_operational_expenditure_for_designed_users_as_percentage_of_household_income
    100 * annual_operational_expenditure_for_designed_users / annual_household_income.to_f
  end

  def annual_capital_maintenance_expenditure_for_designed_users
    capital_maintenance_expenditure.each.map{ |cme| cme.to_f }.inject(:+) / total_designed_users
  end

  def annual_capital_maintenance_expenditure_for_designed_users_as_percentage_of_household_income
    100 * annual_capital_maintenance_expenditure_for_designed_users / annual_household_income.to_f
  end

  def total_annual_expenditure_for_designed_users
    annual_operational_expenditure_for_designed_users + annual_capital_maintenance_expenditure_for_designed_users
  end

  def total_annual_expenditure_for_designed_users_as_percentage_of_household_income
    100 * total_annual_expenditure_for_designed_users / annual_household_income.to_f
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
    @water_system_exists              = nil
    @country                          = nil
    @region                           = nil
    @town                             = nil
    @area_type                        = nil
    @population_density               = nil

    # system management
    @service_management               = []
    @construction_financier           = []
    @infrastructure_operator          = []
    @service_responsbility            = []
    @standard_enforcer                = []
    @rehabilitation_cost_owner        = []
    @annual_household_income          = nil
    @household_size                   = nil

    # system characteristics
    @supply_system_technologies       = []
    @systems_number                   = []
    @system_population_design         = []
    @system_population_actual         = []
    @water_source                     = []
    @surface_water_primary_source     = []
    @water_treatment                  = []
    @power_supply                     = []
    @distribution_line_length         = []

    # cost
    @actual_hardware_expenditure      = []
    @system_lifespan_expectancy       = []
    @actual_software_expenditure      = []
    @unpaid_labour                    = []
    @minor_operation_expenditure      = []
    @capital_maintenance_expenditure  = []
    @loan_cost                        = []
    @loan_payback_period              = []
    @direct_support_cost              = nil
    @indirect_support_cost            = nil

    # service level
    @service_level_name               = []
    @service_level_share              = []
    @national_accessibility_norms     = []
    @national_quantity_norms          = []
    @national_quality_norms           = []
    @national_reliability_norms       = []

  end

end