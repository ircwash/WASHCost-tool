class Advanced::Report::CapitalCost

  include ActiveAttr::Model

  def total_capital_expenditure(capital)
    total_hardware = capital.hardware_total || 0
    total_software = capital.software_total || 0
    if total_hardware && total_hardware!=0
      total_hardware + total_software
    else
      [capital.source,
       capital.pumping_facilities,
       capital.transmission,
       capital.distribution,
       capital.storage,
       capital.treatment,
       capital.other].sum + total_software
    end
  end

  def cost_per_system(total_cap_exp, number_of_systems)
    total_cap_exp/( number_of_systems|| 1)
  end

  def cost_by_design_population(total_cap_exp, total_design_population_served)
    total_cap_exp/(total_design_population_served || 1)
  end

  def cost_by_actual_population(total_cap_exp, total_actual_population_served)
    total_cap_exp/(total_actual_population_served || 1)
  end
end
