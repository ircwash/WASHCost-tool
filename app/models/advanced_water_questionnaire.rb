class AdvancedWaterQuestionnaire < AdvancedQuestionnaire

  attr_accessor :service_management,
                :construction_financier,
                :infrastructure_operator,
                :service_responsbility,
                :standard_enforcer,
                :rehabilitation_cost_owner,

                :water_source,
                :surface_water_primary_source,
                :water_treatment,
                :power_supply,
                :distribution_line_length,

                :unpaid_labour,

                :national_accessibility_norms,
                :national_quantity_norms,
                :national_quality_norms,
                :national_reliability_norms


  def initialize( session )
    super( session, :advanced_water )

    property_attributes :service_management, :construction_financier, :infrastructure_operator, :service_responsbility, :standard_enforcer, :rehabilitation_cost_owner, :water_source, :surface_water_primary_source, :water_treatment, :power_supply, :distribution_line_length, :unpaid_labour, :national_accessibility_norms, :national_quantity_norms, :national_quality_norms, :national_reliability_norms
   end


  def update_attributes( attributes )
    super

    if attributes[ :water_treatment_0 ] != nil || attributes[ :water_treatment_1 ] != nil || attributes[ :water_treatment_2 ] != nil

      @water_treatment = []

      if attributes[ :water_treatment_0 ] != nil
        water_treatment.push attributes[ :water_treatment_0 ]
      end

      if attributes[ :water_treatment_1 ] != nil
        water_treatment.push attributes[ :water_treatment_1 ]
      end

      if attributes[ :water_treatment_2 ] != nil
        water_treatment.push attributes[ :water_treatment_2 ]
      end

    end

    if attributes[ :power_supply_0 ] != nil || attributes[ :power_supply_1 ] != nil || attributes[ :power_supply_2 ] != nil

      @power_supply = []

      if attributes[ :power_supply_0 ] != nil
        power_supply.push attributes[ :power_supply_0 ]
      end

      if attributes[ :power_supply_1 ] != nil
        power_supply.push attributes[ :power_supply_1 ]
      end

      if attributes[ :power_supply_2 ] != nil
        power_supply.push attributes[ :power_supply_2 ]
      end

    end

    super

    if attributes[ :region_unknown ] != nil
      region = attributes[ :region_unknown ]
    end

    if attributes[ :town_unknown ] != nil
      town = attributes[ :town_unknown ]
    end

    if attributes[ :population_density_unknown ] != nil
      population_density = attributes[ :population_density_unknown ]
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

    total_attributes = total_attributes - 1

    if water_source != nil && !water_source.include?("1")
      total_attributes = total_attributes - 1
    end

    100 * attributes_with_values / total_attributes
  end

  # determine navigation item completion

  def service_area
    true unless status == nil || country == nil || currency == nil || year_of_expenditure == nil || region == nil || town == nil || area_type == nil || population_density == nil || service_management.count == 0 || construction_financier.count == 0 || infrastructure_operator.count == 0 || service_responsbility.count == 0 || standard_enforcer.count == 0 || rehabilitation_cost_owner.count == 0 || annual_household_income == nil || household_size == nil || direct_support_cost == nil || indirect_support_cost == nil
  end

  def technology
    true unless supply_system_technologies.count == 0 || systems_number.count == 0 || system_population_design.count == 0 || system_population_actual.count == 0 || water_source.count == 0 || surface_water_primary_source.count == 0 || water_treatment.count == 0 || power_supply.count == 0 || distribution_line_length.count == 0 || actual_hardware_expenditure.count == 0 || system_lifespan_expectancy.count == 0 || actual_software_expenditure.count == 0 || unpaid_labour.count == 0 || minor_operation_expenditure.count == 0 || capital_maintenance_expenditure.count == 0 || loan_cost.count == 0 || loan_payback_period.count == 0
  end

  def service_level
    true unless service_level_name.count == 0 || service_level_share.count == 0 || national_accessibility_norms.count == 0 || national_quantity_norms.count == 0 || national_quality_norms.count == 0 || national_reliability_norms.count == 0
  end


  # CALCULATIONS

  # service levels

  def percentage_of_population_that_meets_accessibility_norms
    if service_level_name != nil &&  service_level_share != nil && national_accessibility_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_accessibility_norms.count == service_level_name.count
      national_accessibility_norms.each_with_index.map{ |nan,i| nan.to_i == 0 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_does_not_meet_accessibility_norms
    if service_level_name != nil &&  service_level_share != nil && national_accessibility_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_accessibility_norms.count == service_level_name.count
      national_accessibility_norms.each_with_index.map{ |nan,i| nan.to_i == 1 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_with_unknown_accessibility_norms
    if service_level_name != nil &&  service_level_share != nil && national_accessibility_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_accessibility_norms.count == service_level_name.count
      national_accessibility_norms.each_with_index.map{ |nan,i| nan.to_i == 2 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_meets_quantity_norms
    if service_level_name != nil &&  service_level_share != nil && national_quantity_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_quantity_norms.count == service_level_name.count
      national_quantity_norms.each_with_index.map{ |nan,i| nan.to_i == 0 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_does_not_meet_quantity_norms
    if service_level_name != nil &&  service_level_share != nil && national_quantity_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_quantity_norms.count == service_level_name.count
      national_quantity_norms.each_with_index.map{ |nan,i| nan.to_i == 1 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_with_unknown_quantity_norms
    if service_level_name != nil &&  service_level_share != nil && national_quantity_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_quantity_norms.count == service_level_name.count
      national_quantity_norms.each_with_index.map{ |nan,i| nan.to_i == 2 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_meets_quality_norms
    if service_level_name != nil &&  service_level_share != nil && national_quality_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_quality_norms.count == service_level_name.count
      national_quality_norms.each_with_index.map{ |nan,i| nan.to_i == 0 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_does_not_meet_quality_norms
    if service_level_name != nil &&  service_level_share != nil && national_quantity_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_quality_norms.count == service_level_name.count
      national_quality_norms.each_with_index.map{ |nan,i| nan.to_i == 1 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_with_unknown_quality_norms
    if service_level_name != nil &&  service_level_share != nil && national_quality_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_quality_norms.count == service_level_name.count
      national_quality_norms.each_with_index.map{ |nan,i| nan.to_i == 2 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_meets_reliability_norms
    if service_level_name != nil &&  service_level_share != nil && national_reliability_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_reliability_norms.count == service_level_name.count
      national_reliability_norms.each_with_index.map{ |nan,i| nan.to_i == 0 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_does_not_meet_reliability_norms
    if service_level_name != nil &&  service_level_share != nil && national_reliability_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_reliability_norms.count == service_level_name.count
      national_reliability_norms.each_with_index.map{ |nan,i| nan.to_i == 1 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_with_unknown_reliability_norms
    if service_level_name != nil &&  service_level_share != nil && national_reliability_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_reliability_norms.count == service_level_name.count
      national_reliability_norms.each_with_index.map{ |nan,i| nan.to_i == 2 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_meets_all_norms
    if service_level_name != nil && service_level_name.count > 0 && national_accessibility_norms != nil && national_accessibility_norms.count > 0 && national_quality_norms != nil && national_quality_norms.count > 0 && national_reliability_norms != nil && national_reliability_norms.count > 0 && national_quantity_norms != nil && national_quantity_norms.count > 0 && service_level_share != nil && service_level_share.count > 0
      service_level_name.each_with_index.map{ |nan,i| (national_accessibility_norms[i].to_i == 0 && national_quality_norms[i].to_i == 0 && national_reliability_norms[i].to_i ==0 && national_quantity_norms[i].to_i == 0) ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end


  # BENCHMARK VALUES

  def benchmark_minor_operation_expenditure
    [
      0.75,
      2.75,
      2.75,
      2.75,
      2.75,
      2.75,
      2.75,
      2.75,
      2.75,
      2.75,
      2.75,
      2.75,
      2.75,
      2.75,
      0,
      0
    ]
  end

  def benchmark_direct_support_cost
    [
      2.0,
      2.0,
      2.0,
      2.0,
      2.0,
      2.0,
      2.0,
      2.0,
      2.0,
      2.0,
      2.0,
      2.0,
      2.0,
      2.0,
      2.0,
      2.0
    ]
  end


  private


  def set_properties
    super

    # system management
    self.service_management               = []
    self.construction_financier           = []
    self.infrastructure_operator          = []
    self.service_responsbility            = []
    self.standard_enforcer                = []
    self.rehabilitation_cost_owner        = []

    # system characteristics
    self.water_source                     = []
    self.surface_water_primary_source     = []
    self.water_treatment                  = []
    self.power_supply                     = []
    self.distribution_line_length         = []

    # cost
    self.unpaid_labour                    = []

    # service level
    self.national_accessibility_norms     = []
    self.national_quantity_norms          = []
    self.national_quality_norms           = []
    self.national_reliability_norms       = []

  end

end
