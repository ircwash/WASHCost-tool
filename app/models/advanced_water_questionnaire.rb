class AdvancedWaterQuestionnaire < Session

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
                :direct_support_cost,
                :indirect_support_cost,

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

                :service_level_name,
                :service_level_share,
                :national_accessibility_norms,
                :national_quantity_norms,
                :national_quality_norms,
                :national_reliability_norms


  def initialize( session )
    super( session, :advanced_water )
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
    total_attributes = property_attributes.count

    property_attributes.each do |attribute|
      value = send( "#{attribute}" )

      if value != nil && value.kind_of?( Array ) && value & [''] == value
        value = nil
      end

      if value != nil
        attributes_with_values = attributes_with_values + 1
      end
    end

    if water_source == nil || !water_source.include?( '1' )
      total_attributes = total_attributes - 1
    end

    100 * attributes_with_values / total_attributes
  end

  # determine navigation item completion

  def service_area
    true unless water_system_exists == nil || country == nil || currency == nil || year_of_expenditure == nil || region == nil || town == nil || area_type == nil || population_density == nil || service_management == nil || construction_financier == nil || infrastructure_operator == nil || service_responsbility == nil || standard_enforcer == nil || rehabilitation_cost_owner == nil || annual_household_income == nil || household_size == nil || direct_support_cost == nil || indirect_support_cost == nil
  end

  def technology
    true unless supply_system_technologies.count == 0 || systems_number.count == 0 || system_population_design.count == 0 || system_population_actual.count == 0 || water_source.count == 0 || surface_water_primary_source.count == 0 || water_treatment.count == 0 || power_supply.count == 0 || distribution_line_length.count == 0 || actual_hardware_expenditure.count == 0 || system_lifespan_expectancy.count == 0 || actual_software_expenditure.count == 0 || unpaid_labour.count == 0 || minor_operation_expenditure.count == 0 || capital_maintenance_expenditure.count == 0 || loan_cost.count == 0 || loan_payback_period.count == 0
   end

   def service_level
    true unless service_level_name.count == 0 || service_level_share.count == 0 || national_accessibility_norms.count == 0 || national_quantity_norms.count == 0 || national_quality_norms.count == 0 || national_reliability_norms.count == 0
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
    if service_level_name.count > 0 && ( national_accessibility_norms.count > 0 || national_quantity_norms.count > 0 || national_quality_norms.count > 0 || national_reliability_norms.count > 0 )
      service_level_name.each_with_index.map{ |sl,i| ( national_accessibility_norms[i].to_i == 0 || national_quantity_norms[i].to_i == 0 || national_quality_norms[i].to_i == 0 || national_reliability_norms[i].to_i == 0 ) ? service_level_share[i].to_i : 0 }.inject(:+)
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

  def annual_cost_of_capital_for_actual_users
    if cost_of_capital_per_person_per_year != nil && total_actual_users != nil
      cost_of_capital_per_person_per_year * total_actual_users
    else
      nil
    end
  end

  def total_annual_expenditure_for_actual_users
    if annual_operational_expenditure_for_actual_users != nil && annual_capital_maintenance_expenditure_for_actual_users != nil && annual_cost_of_capital_for_actual_users != nil
      annual_operational_expenditure_for_actual_users + annual_capital_maintenance_expenditure_for_actual_users + annual_cost_of_capital_for_actual_users
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

  def annual_cost_of_capital_for_designed_users
    if cost_of_capital_per_person_per_year != nil && total_designed_users != nil
      cost_of_capital_per_person_per_year * total_designed_users
    else
      nil
    end
  end

  def total_annual_expenditure_for_designed_users
    if annual_operational_expenditure_for_designed_users != nil && annual_capital_maintenance_expenditure_for_designed_users != nil && annual_cost_of_capital_for_designed_users != nil
      annual_operational_expenditure_for_designed_users + annual_capital_maintenance_expenditure_for_designed_users + annual_cost_of_capital_for_designed_users
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

  # service levels

  def percentage_of_population_that_meets_accessibility_norms
    if service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_accessibility_norms.count == service_level_name.count
      national_accessibility_norms.each_with_index.map{ |nan,i| nan.to_i == 0 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_does_not_meet_accessibility_norms
    if service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_accessibility_norms.count == service_level_name.count
      national_accessibility_norms.each_with_index.map{ |nan,i| nan.to_i == 1 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_with_unknown_accessibility_norms
    if service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_accessibility_norms.count == service_level_name.count
      national_accessibility_norms.each_with_index.map{ |nan,i| nan.to_i == 2 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_meets_quantity_norms
    if service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_quantity_norms.count == service_level_name.count
      national_quantity_norms.each_with_index.map{ |nan,i| nan.to_i == 0 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_does_not_meet_quantity_norms
    if service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_quantity_norms.count == service_level_name.count
      national_quantity_norms.each_with_index.map{ |nan,i| nan.to_i == 1 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_with_unknown_quantity_norms
    if service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_quantity_norms.count == service_level_name.count
      national_quantity_norms.each_with_index.map{ |nan,i| nan.to_i == 2 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_meets_quality_norms
    if service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_quality_norms.count == service_level_name.count
      national_quality_norms.each_with_index.map{ |nan,i| nan.to_i == 0 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_does_not_meet_quality_norms
    if service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_quality_norms.count == service_level_name.count
      national_quality_norms.each_with_index.map{ |nan,i| nan.to_i == 1 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_with_unknown_quality_norms
    if service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_quality_norms.count == service_level_name.count
      national_quality_norms.each_with_index.map{ |nan,i| nan.to_i == 2 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_meets_reliability_norms
    if service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_reliability_norms.count == service_level_name.count
      national_reliability_norms.each_with_index.map{ |nan,i| nan.to_i == 0 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_does_not_meet_reliability_norms
    if service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_reliability_norms.count == service_level_name.count
      national_reliability_norms.each_with_index.map{ |nan,i| nan.to_i == 1 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_with_unknown_reliability_norms
    if service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_reliability_norms.count == service_level_name.count
      national_reliability_norms.each_with_index.map{ |nan,i| nan.to_i == 2 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_meets_all_norms
    if percentage_of_population_that_meets_accessibility_norms != nil || percentage_of_population_that_meets_quantity_norms != nil || percentage_of_population_that_meets_quality_norms != nil || percentage_of_population_that_meets_reliability_norms != nil
      ( ( percentage_of_population_that_meets_accessibility_norms || 0 ) + ( percentage_of_population_that_meets_quantity_norms || 0 ) + ( percentage_of_population_that_meets_quality_norms || 0 ) + ( percentage_of_population_that_meets_reliability_norms || 0 ) ) / 400
    else
      nil
    end
  end

  # cost comparison

  def service_area_capital_expenditure_per_technology
    if supply_system_technologies.count > 0 && actual_hardware_expenditure.count == supply_system_technologies.count && actual_software_expenditure.count == supply_system_technologies.count && system_population_design.count == supply_system_technologies.count
      supply_system_technologies.each_with_index.map{ |s,i| ( actual_hardware_expenditure[i].to_f + actual_software_expenditure[i].to_f ) / system_population_design[i].to_f }
    else
      nil
    end
  end

  def service_area_capital_expenditure_for_technology( technology )
    expenditure = 0

    if supply_system_technologies.include?( technology ) && actual_hardware_expenditure.count == supply_system_technologies.count && actual_software_expenditure.count == supply_system_technologies.count && system_population_design.count == supply_system_technologies.count
      supply_system_technologies.each_with_index do |t,i|

        if t == technology
          expenditure = expenditure + ( actual_hardware_expenditure[i].to_f + actual_software_expenditure[i].to_f ) / system_population_design[i].to_f
        end
      end
    end

    expenditure
  end

  def total_service_area_capital_expenditure
    if service_area_capital_expenditure_per_technology != nil
      service_area_capital_expenditure_per_technology.inject(:+)
    else
      nil
    end
  end

  def service_area_recurrent_expenditure_per_technology
    if supply_system_technologies.count > 0 && minor_operation_expenditure.count == supply_system_technologies.count && capital_maintenance_expenditure.count == supply_system_technologies.count
      supply_system_technologies.each_with_index.map{ |s,i| minor_operation_expenditure[i].to_f + capital_maintenance_expenditure[i].to_f }
    else
      nil
    end
  end

  def service_area_recurrent_expenditure_for_technology( technology )
    expenditure = 0

    if supply_system_technologies.include?( technology ) && minor_operation_expenditure.count == supply_system_technologies.count && capital_maintenance_expenditure.count == supply_system_technologies.count
      supply_system_technologies.each_with_index do |t,i|

        if t == technology
          expenditure = expenditure + minor_operation_expenditure[i].to_f + capital_maintenance_expenditure[i].to_f
        end
      end
    end

    expenditure
  end

  def total_service_area_recurrent_expenditure
    if service_area_recurrent_expenditure_per_technology != nil && direct_support_cost != nil && indirect_support_cost != nil
      service_area_recurrent_expenditure_per_technology.inject(:+) + direct_support_cost.to_f + indirect_support_cost.to_f
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
    @water_system_exists              = nil
    @country                          = nil
    @currency                         = nil
    @year_of_expenditure              = nil
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
    @direct_support_cost              = nil
    @indirect_support_cost            = nil

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

    # service level
    @service_level_name               = []
    @service_level_share              = []
    @national_accessibility_norms     = []
    @national_quantity_norms          = []
    @national_quality_norms           = []
    @national_reliability_norms       = []

  end

end
