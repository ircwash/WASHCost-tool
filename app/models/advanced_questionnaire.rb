class AdvancedQuestionnaire < Session

  cattr_accessor :status,
                :country,
                :currency,
                :year_of_expenditure,
                :region,
                :town,
                :area_type,
                :population_density,
                :annual_household_income,
                :household_size,

                :direct_support_cost,
                :indirect_support_cost,

                :supply_system_technologies,
                :systems_number,
                :system_population_design,
                :system_population_actual,
                :actual_hardware_expenditure,
                :actual_software_expenditure,
                :system_lifespan_expectancy,
                :minor_operation_expenditure,
                :capital_maintenance_expenditure,
                :loan_cost,
                :loan_payback_period,

                :service_level_name,
                :service_level_share

  def initialize( session, identifier )
    super

    property_attributes :status, :country, :currency, :year_of_expenditure, :region, :town, :area_type, :population_density, :annual_household_income, :household_size, :direct_support_cost, :indirect_support_cost, :supply_system_technologies, :systems_number, :system_population_design, :system_population_actual, :actual_hardware_expenditure, :actual_software_expenditure, :system_lifespan_expectancy, :minor_operation_expenditure, :capital_maintenance_expenditure, :loan_cost, :loan_payback_period, :service_level_name, :service_level_share
  end


  def update_attributes( attributes )
    super

    if attributes[ :region_unknown ] != nil
      self.region = attributes[ :region_unknown ]
    end

    if attributes[ :town_unknown ] != nil
      self.town = attributes[ :town_unknown ]
    end

    if attributes[ :population_density_unknown ] != nil
      self.population_density = attributes[ :population_density_unknown ]
    end

    archive

  end


  # CALCULATIONS

  def total_population
    if supply_system_technologies.count > 0 && system_population_actual.count == supply_system_technologies.count
      system_population_actual.map{ |p| p.to_f }.inject(:+)
    else
      nil
    end
  end

  def total_expenditure_for_years( years )
    if hardware_and_software_expenditure != nil && total_operation_expenditure != nil && total_capital_maintenance_expenditure != nil && direct_support_cost != nil && indirect_support_cost != nil && total_population != nil && cost_of_capital_for_years( years ) != nil
      hardware_and_software_expenditure + total_operation_expenditure * years + total_capital_maintenance_expenditure * years + direct_support_cost.to_f * total_population * years + indirect_support_cost.to_f * total_population * years + cost_of_capital_for_years( years )
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

  def total_operation_expenditure
    if supply_system_technologies.count > 0 && minor_operation_expenditure.count == supply_system_technologies.count
      minor_operation_expenditure.map{ |e| e.to_f }.inject(:+)
    else
      nil
    end
  end

  def total_capital_maintenance_expenditure
    if supply_system_technologies.count > 0 && capital_maintenance_expenditure.count == supply_system_technologies.count
      capital_maintenance_expenditure.map{ |e| e.to_f }.inject(:+)
    else
      nil
    end
  end

  def cost_of_capital_for_years( years )
    if supply_system_technologies.count > 0 && loan_cost.count == supply_system_technologies.count && loan_payback_period.count == supply_system_technologies.count
      supply_system_technologies.each_with_index.map{ |s,i| loan_cost[i].to_f * [ loan_payback_period[i].to_i, years ].min }.inject( :+ )
    else
      nil
    end
  end

  def operation_expenditure_per_person_per_year
    if supply_system_technologies.count > 0 && minor_operation_expenditure.count == supply_system_technologies.count && system_population_actual.count == supply_system_technologies.count
      minor_operation_expenditure.map{ |e| e.to_f }.inject(:+) / system_population_actual.map{ |p| p.to_f }.inject(:+)
    else
      nil
    end
  end

  def capital_maintenance_expenditure_per_person_per_year
    if supply_system_technologies.count > 0 && capital_maintenance_expenditure.count == supply_system_technologies.count && system_population_actual.count == supply_system_technologies.count
      capital_maintenance_expenditure.map{ |e| e.to_f }.inject(:+) / system_population_actual.map{ |p| p.to_f }.inject(:+)
    else
      nil
    end
  end

  def cost_of_capital_per_person_per_year
    if supply_system_technologies.count > 0 && loan_cost.count == supply_system_technologies.count && system_population_actual.count == supply_system_technologies.count
      loan_cost.map{ |e| e.to_f }.inject(:+) / system_population_actual.map{ |p| p.to_f }.inject(:+)
    else
      nil
    end
  end

  def total_inputted_recurrent_expenditure_per_person_per_year
    if operation_expenditure_per_person_per_year != nil && capital_maintenance_expenditure_per_person_per_year != nil && cost_of_capital_per_person_per_year != nil && direct_support_cost != nil && indirect_support_cost != nil
      operation_expenditure_per_person_per_year + capital_maintenance_expenditure_per_person_per_year + cost_of_capital_per_person_per_year + direct_support_cost.to_f + indirect_support_cost.to_f
    else
      nil
    end
  end

  def expected_operation_expenditure_per_person_per_year
    if supply_system_technologies.count > 0 && system_population_actual.count == supply_system_technologies.count
      supply_system_technologies.each_with_index.map{ |s,i| benchmark_minor_operation_expenditure[ s.to_i ] * system_population_actual[i].to_f }.inject(:+) / system_population_actual.map{ |p| p.to_f }.inject(:+)
    else
      nil
    end
  end

  def expected_capital_maintenance_expenditure_per_person_per_year
    if supply_system_technologies.count > 0 && capital_maintenance_expenditure.count == supply_system_technologies.count && system_lifespan_expectancy.count == supply_system_technologies.count && system_population_actual.count == supply_system_technologies.count
      ( supply_system_technologies.each_with_index.map{ |s,i| ( 30 / system_lifespan_expectancy[i].to_f ).floor * capital_maintenance_expenditure[i].to_f }.inject(:+) / 30 ) / system_population_actual.map{ |p| p.to_f }.inject(:+)
    else
      nil
    end
  end

  def expected_direct_support_cost_per_person_per_year
    if supply_system_technologies.count > 0 && system_population_actual.count == supply_system_technologies.count
      supply_system_technologies.each_with_index.map{ |s,i| benchmark_direct_support_cost[ s.to_i ].to_f * system_population_actual[i].to_f }.inject(:+) / system_population_actual.map{ |p| p.to_f }.inject(:+)
    else
      nil
    end
  end

  def total_expected_expenditure_per_person_per_year
    if expected_operation_expenditure_per_person_per_year != nil && expected_capital_maintenance_expenditure_per_person_per_year != nil && cost_of_capital_per_person_per_year != nil && expected_direct_support_cost_per_person_per_year != nil && indirect_support_cost != nil
      expected_operation_expenditure_per_person_per_year + expected_capital_maintenance_expenditure_per_person_per_year + cost_of_capital_per_person_per_year + expected_direct_support_cost_per_person_per_year + indirect_support_cost.to_f
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
    if direct_support_cost != nil && direct_support_cost != nil
      direct_support_cost.to_f - direct_support_cost.to_f
    else
      nil
    end
  end

  def total_expenditure_delta_per_person_per_year
    if total_inputted_recurrent_expenditure_per_person_per_year != nil && total_expected_expenditure_per_person_per_year != nil
      total_inputted_recurrent_expenditure_per_person_per_year - total_expected_expenditure_per_person_per_year
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
      minor_operation_expenditure.map{ |moe| moe.to_f }.inject(:+) / total_actual_users
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
      capital_maintenance_expenditure.map{ |cme| cme.to_f }.inject(:+) / total_actual_users
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
    if loan_cost.count > 0 && total_actual_users != nil
      loan_cost.map{ |lc| lc.to_f }.inject(:+) / total_actual_users
    else
      nil
    end
  end

  def annual_cost_of_capital_for_actual_users_as_percentage_of_household_income
    if annual_cost_of_capital_for_actual_users != nil && annual_household_income != nil
      100 * annual_cost_of_capital_for_actual_users / annual_household_income.to_f
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
      minor_operation_expenditure.map{ |moe| moe.to_f }.inject(:+) / total_designed_users
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
      capital_maintenance_expenditure.map{ |cme| cme.to_f }.inject(:+) / total_designed_users
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
    if loan_cost.count > 0 && total_designed_users != nil
      loan_cost.map{ |lc| lc.to_f }.inject(:+) / total_designed_users
    else
      nil
    end
  end

  def annual_cost_of_capital_for_designed_users_as_percentage_of_household_income
    if annual_cost_of_capital_for_designed_users != nil && annual_household_income != nil
      100 * annual_cost_of_capital_for_designed_users / annual_household_income.to_f
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
    if supply_system_technologies.count > 0 && total_actual_users != nil
      supply_system_technologies.each_with_index.map{ |s,i| benchmark_minor_operation_expenditure[ s.to_i ] * system_population_actual[i].to_f }.inject(:+) / total_actual_users
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
    if supply_system_technologies.count > 0 && capital_maintenance_expenditure.count == supply_system_technologies.count && system_lifespan_expectancy.count == supply_system_technologies.count && total_actual_users != nil
      supply_system_technologies.each_with_index.map{ |s,i| capital_maintenance_expenditure[i].to_f / system_lifespan_expectancy[i].to_f }.inject(:+) / total_actual_users
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

  def expected_annual_cost_of_capital_for_actual_users
    if loan_cost.count > 0 && total_actual_users != nil
      loan_cost.map{ |lc| lc.to_f }.inject(:+) / total_actual_users
    else
      nil
    end
  end

  def expected_annual_cost_of_capital_for_actual_users_as_percentage_of_household_income
    if expected_annual_cost_of_capital_for_actual_users != nil && annual_household_income != nil
      100 * expected_annual_cost_of_capital_for_actual_users / annual_household_income.to_f
    else
      nil
    end
  end

  def total_expected_annual_expenditure_for_actual_users
    if expected_annual_operational_expenditure_for_actual_users != nil && expected_annual_capital_maintenance_expenditure_for_actual_users != nil && expected_annual_cost_of_capital_for_actual_users != nil
      expected_annual_operational_expenditure_for_actual_users + expected_annual_capital_maintenance_expenditure_for_actual_users + expected_annual_cost_of_capital_for_actual_users
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

  def percentage_of_population_with_defined_service
    if service_level_name.count > 0 && service_level_share.count == service_level_name.count
      service_level_share.map{ |sl| sl.to_i }.inject(:+)
    else
      nil
    end
  end

  # cost comparison

  def total_service_area_capital_expenditure
    if supply_system_technologies.count > 0 && actual_hardware_expenditure.count == supply_system_technologies.count && actual_software_expenditure.count == supply_system_technologies.count && system_population_design.count == supply_system_technologies.count
      supply_system_technologies.each_with_index.map{ |s,i| ( actual_hardware_expenditure[i].to_f + actual_software_expenditure[i].to_f ) }.inject(:+) / system_population_design.map{ |sp| sp.to_f }.inject(:+)
    else
      nil
    end
  end

  def total_service_area_recurrent_expenditure
    total_inputted_recurrent_expenditure_per_person_per_year
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

  def service_area_recurrent_expenditure_for_technology( technology )
    expenditure = 0

    if supply_system_technologies.include?( technology ) && minor_operation_expenditure.count == supply_system_technologies.count && capital_maintenance_expenditure.count == supply_system_technologies.count && system_population_design.count == supply_system_technologies.count && loan_cost.count == supply_system_technologies.count && loan_payback_period.count == supply_system_technologies.count
      supply_system_technologies.each_with_index do |t,i|

        if t == technology
          expenditure = expenditure + ( minor_operation_expenditure[i].to_f + capital_maintenance_expenditure[i].to_f + loan_cost[i].to_f * [ loan_payback_period[i].to_i, 30 ].min ) / system_population_design[i].to_f
        end
      end
    end

    expenditure
  end


  # BENCHMARK VALUES

  def benchmark_minor_operation_expenditure
    supply_system_technologies.map{ |t| 0 }
  end

  def benchmark_direct_support_cost
    supply_system_technologies.map{ |t| 0 }
  end


  private


  def set_properties
    super

    self.status                           = nil
    self.country                          = nil
    self.currency                         = nil
    self.year_of_expenditure              = nil
    self.region                           = nil
    self.town                             = nil
    self.area_type                        = nil
    self.population_density               = nil
    self.annual_household_income          = nil
    self.household_size                   = nil

    self.direct_support_cost              = nil
    self.indirect_support_cost            = nil

    self.supply_system_technologies       = []
    self.systems_number                   = []
    self.system_population_design         = []
    self.system_population_actual         = []
    self.actual_hardware_expenditure      = []
    self.actual_software_expenditure      = []
    self.system_lifespan_expectancy       = []
    self.minor_operation_expenditure      = []
    self.capital_maintenance_expenditure  = []
    self.loan_cost                        = []
    self.loan_payback_period              = []

    self.service_level_name               = []
    self.service_level_share              = []
  end

end