class Advanced::Report::CapitalCost

  include ActiveAttr::Model

  def total_capital_expenditure(capital, number_of_systems, total_design_population_served, total_actual_population_served)
    total_hardware = capital.hardware_total || 0
    total_software = capital.software_total || 0
    if total_hardware && total_hardware>0
      total = total_hardware + total_software
    else
      total = [capital.source,
       capital.pumping_facilities,
       capital.transmission,
       capital.distribution,
       capital.storage,
       capital.treatment,
       capital.other].sum + total_software
    end
    per_system = total/( number_of_systems|| 1)
    per_design_population = total/(total_design_population_served || 1)
    per_actual_population = total/(total_actual_population_served || 1)
    recurrent_hash total, per_system, per_design_population, per_actual_population
  end

  private
  def recurrent_hash (total, per_system, per_design_population, per_actual_population)
    {
        total: total,
        per_system: per_system,
        per_design_population: per_design_population,
        per_actual_population: per_actual_population
    }
  end
end
