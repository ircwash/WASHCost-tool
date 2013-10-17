class Advanced::Report::Technology

  include ActiveAttr::Model

  attribute :technology_descriptor

  def total_percentage_served_design(total_design_population_served)
    total_design_population_served/(technology_descriptor.expected_number_of_people || 1)
  end

  def total_percentage_served_actual(total_design_population_served)
    total_design_population_served/(technology_descriptor.server_number_of_people || 1)
  end

  # Calculate the average system size for each technology
  def average_system_size
    self.technology_descriptor
  end

  def total_capital_expenditure
    total_hardware = technology_descriptor.costs.capital.hardware_total || 0
    total_software = technology_descriptor.costs.capital.software_total || 0
    if total_hardware && total_hardware!=0
      total_hardware + total_software
    else
      [technology_descriptor.costs.capital.source,
      technology_descriptor.costs.capital.pumping_facilities,
      technology_descriptor.costs.capital.transmission,
      technology_descriptor.costs.capital.distribution,
      technology_descriptor.costs.capital.storage,
      technology_descriptor.costs.capital.treatment,
      technology_descriptor.costs.capital.other].sum + total_software
    end
  end

  def capital_cost_per_system
    total_capital_expenditure/(technology_descriptor.number_of_systems || 1)
  end

  def capital_cost_by_design_population(total_design_population_served)
    total_capital_expenditure/(total_design_population_served || 1)
  end
  
  def capital_cost_by_actual_population(total_actual_population_served)
    total_capital_expenditure/(total_actual_population_served || 1)
  end
end
