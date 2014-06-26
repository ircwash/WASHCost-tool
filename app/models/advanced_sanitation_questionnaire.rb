class AdvancedSanitationQuestionnaire < AdvancedQuestionnaire

  cattr_accessor :service_management,
                :construction_financier,
                :infrastructure_operator,
                :service_responsbility,
                :standard_enforcer,
                :rehabilitation_cost_owner,

                :unpaid_labour,

                :national_accessibility_norms,
                :national_use_norms,
                :national_reliability_norms,
                :national_environmental_protection_norms


  def initialize( session )
    super( session, :advanced_sanitation )

    property_attributes :service_management, :construction_financier, :infrastructure_operator, :service_responsbility, :standard_enforcer, :rehabilitation_cost_owner, :unpaid_labour, :national_accessibility_norms, :national_use_norms, :national_reliability_norms, :national_environmental_protection_norms
  end


  def update_attributes( attributes )
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

    property_attributes.each do |attribute|
      value = send( "#{attribute}" )

      if value != nil && value.kind_of?( Array ) && value & [''] == value
        value = nil
      end

      if value != nil
        attributes_with_values = attributes_with_values + 1
      end
    end

    100 * attributes_with_values / (property_attributes.count - 1)
  end

  # determine navigation item completion

  def service_area
    true unless status == nil || country == nil || currency == nil || year_of_expenditure == nil || region == nil || town == nil || area_type == nil || population_density == nil || service_management.count == 0 || construction_financier.count == 0 || infrastructure_operator.count == 0 || service_responsbility.count == 0 || standard_enforcer.count == 0 || rehabilitation_cost_owner.count == 0 || annual_household_income == nil || household_size == nil
  end

  def technology
    true unless supply_system_technologies.count == 0 || systems_number.count == 0 || system_population_design.count == 0 || system_population_actual.count == 0 || actual_hardware_expenditure.count == 0 || system_lifespan_expectancy.count == 0 || actual_software_expenditure.count == 0 || unpaid_labour.count == 0 || minor_operation_expenditure.count == 0 || capital_maintenance_expenditure.count == 0 || loan_cost.count == 0 || loan_payback_period.count == 0
  end

  def service_level
    true unless service_level_name.count == 0 || service_level_share.count == 0 || national_accessibility_norms.count == 0 || national_use_norms.count == 0 || national_reliability_norms.count == 0 || national_environmental_protection_norms.count == 0
  end


  # CALCULATIONS

  # service levels

  def percentage_of_population_that_meets_accessibility_norms
    if service_level_name != nil && service_level_share != nil && national_accessibility_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_accessibility_norms.count == service_level_name.count
      national_accessibility_norms.each_with_index.map{ |nan,i| nan.to_i == 0 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_does_not_meet_accessibility_norms
    if service_level_name != nil && service_level_share != nil && national_accessibility_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_accessibility_norms.count == service_level_name.count
      national_accessibility_norms.each_with_index.map{ |nan,i| nan.to_i == 1 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_with_unknown_accessibility_norms
    if service_level_name != nil && service_level_share != nil && national_accessibility_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_accessibility_norms.count == service_level_name.count
      national_accessibility_norms.each_with_index.map{ |nan,i| nan.to_i == 2 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_meets_use_norms
    if service_level_name != nil && service_level_share != nil && national_use_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_use_norms.count == service_level_name.count
      national_use_norms.each_with_index.map{ |nan,i| nan.to_i == 0 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_does_not_meet_use_norms
    if service_level_name != nil && service_level_share != nil && national_use_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_use_norms.count == service_level_name.count
      national_use_norms.each_with_index.map{ |nan,i| nan.to_i == 1 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_with_unknown_use_norms
    if service_level_name != nil && service_level_share != nil && national_use_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_use_norms.count == service_level_name.count
      national_use_norms.each_with_index.map{ |nan,i| nan.to_i == 2 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_meets_reliability_norms
    if service_level_name != nil && service_level_share != nil && national_reliability_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_reliability_norms.count == service_level_name.count
      national_reliability_norms.each_with_index.map{ |nan,i| nan.to_i == 0 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_does_not_meet_reliability_norms
    if service_level_name != nil && service_level_share != nil && national_reliability_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_reliability_norms.count == service_level_name.count
      national_reliability_norms.each_with_index.map{ |nan,i| nan.to_i == 1 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_with_unknown_reliability_norms
    if service_level_name != nil && service_level_share != nil && national_reliability_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_reliability_norms.count == service_level_name.count
      national_reliability_norms.each_with_index.map{ |nan,i| nan.to_i == 2 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_meets_environmental_protection_norms
    if service_level_name != nil && service_level_share != nil && national_environmental_protection_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_environmental_protection_norms.count == service_level_name.count
      national_environmental_protection_norms.each_with_index.map{ |nan,i| nan.to_i == 0 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_does_not_meet_environmental_protection_norms
    if service_level_name != nil && service_level_share != nil && national_environmental_protection_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_environmental_protection_norms.count == service_level_name.count
      national_environmental_protection_norms.each_with_index.map{ |nan,i| nan.to_i == 1 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_with_unknown_environmental_protection_norms
    if service_level_name != nil && service_level_share != nil && national_environmental_protection_norms != nil && service_level_name.count > 0 && service_level_share.count == service_level_name.count && national_environmental_protection_norms.count == service_level_name.count
      national_environmental_protection_norms.each_with_index.map{ |nan,i| nan.to_i == 2 ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  def percentage_of_population_that_meets_all_norms
    if service_level_name != nil && service_level_name.count > 0 && national_accessibility_norms != nil && national_accessibility_norms.count > 0 && national_quality_norms != nil && national_quality_norms.count > 0 && national_reliability_norms != nil && national_reliability_norms.count > 0 && national_quantity_norms != nil && national_quantity_norms.count > 0 && service_level_share != nil && service_level_share.count > 0
      service_level_name.each_with_index.map{ |nan,i|  (national_accessibility_norms[i].to_i == 0 && national_quality_norms[i].to_i == 0 && national_reliability_norms[i].to_i ==0 && national_quantity_norms[i].to_i == 0) ? service_level_share[i].to_i : 0 }.inject(:+)
    else
      nil
    end
  end

  # BENCHMARK VALUES

  def benchmark_minor_operation_expenditure
    [
      0.75,
      0.75,
      0.75,
      0.75,
      2.5,
      2.5,
      2.5,
      2.5,
      2.5,
      2.5,
      2.5,
      2.5,
      2.5,
      2.5
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
      2.0
    ]
  end


  private


  def set_properties
    super

    # system management
    self.service_management                       = []
    self.construction_financier                   = []
    self.infrastructure_operator                  = []
    self.service_responsbility                    = []
    self.standard_enforcer                        = []
    self.rehabilitation_cost_owner                = []

    # cost
    self.unpaid_labour                            = []

    # service level
    self.national_accessibility_norms             = []
    self.national_use_norms                       = []
    self.national_reliability_norms               = []
    self.national_environmental_protection_norms  = []
  end

end
