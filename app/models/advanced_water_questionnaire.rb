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
                :supply_systems_used,
                :systems_number,
                :system_population_design,
                :system_population_actual,
                :actual_hardware_expenditure,
                :system_lifespan_expectancy,
                :actual_software_expenditure,
                :unpaid_labour,
                :minor_operation_expenditure,
                :capital_maintenance_expenditure,
                :loan_payback_period,
                :direct_support_expenditure,
                :indirect_support_expenditure,
                :service_level_name,
                :service_level_share,
                :national_accessibility_norms,
                :national_quantity_norms,
                :national_quality_norms,
                :national_reliability_norms,

                :region_unknown,
                :town_unknown,
                :population_density_unknown


  def initialize( session )

    # system characteristics
    @water_system_exists              = nil
    @country                          = nil
    @region                           = nil
    @town                             = nil
    @area_type                        = nil
    @population_density               = nil
    @service_management               = []
    @construction_financier           = []
    @infrastructure_operator          = []
    @service_responsbility            = []
    @standard_enforcer                = []
    @rehabilitation_cost_owner        = []
    @annual_household_income          = nil
    @household_size                   = nil

    # technology
    @supply_systems_used              = nil
    @systems_number                   = nil
    @system_population_design         = nil
    @system_population_actual         = nil
    @actual_hardware_expenditure      = nil
    @system_lifespan_expectancy       = nil
    @actual_software_expenditure      = nil
    @unpaid_labour                    = nil
    @minor_operation_expenditure      = nil
    @capital_maintenance_expenditure  = nil
    @loan_payback_period              = nil
    @direct_support_expenditure       = nil
    @indirect_support_expenditure     = nil

    # service level
    @service_level_name               = nil
    @service_level_share              = nil
    @national_accessibility_norms     = nil
    @national_quantity_norms          = nil
    @national_quality_norms           = nil
    @national_reliability_norms       = nil

    super

  end


  def complete
    attributes_with_values = -3 # subtract the unknown property counterparts as they always have a value

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