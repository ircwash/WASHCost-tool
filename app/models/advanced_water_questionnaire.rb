class AdvancedWaterQuestionnaire

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

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
    @session = session

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

    if ( session[ :advanced_water ] )
      unarchive
    end
  end


  def update_attributes( attributes )

    attributes.each do |name, value|
      if respond_to?( "#{name}=" )
        send( "#{name}=", value )
      end
    end

    archive
  end


  def persisted?
    false
  end

  private


  def archive
    data = {}

    instance_variables.map { |ivar| data[ ivar.to_s.gsub( /@/, '' ) ] = instance_variable_get ivar unless ivar == :@session }

    @session[ :advanced_water ] = data
  end


  def unarchive
    @session[ :advanced_water ].each do |name, value|
      send( "#{name}=", value )
    end
  end

end