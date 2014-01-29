class AdvancedWaterQuestionnaire < Session

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

                :service_level_name,
                :service_level_share,
                :national_accessibility_norms,
                :national_quantity_norms,
                :national_quality_norms,
                :national_reliability_norms


  def initialize( session )

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

    # service level
    @service_level_name               = nil
    @service_level_share              = nil
    @national_accessibility_norms     = nil
    @national_quantity_norms          = nil
    @national_quality_norms           = nil
    @national_reliability_norms       = nil

    super

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


end