class Advanced::Report::RecurrentCost

  include ActiveAttr::Model

  def operational_expenditure_per_year(recurrent, number_of_systems, total_design_population_served, total_actual_population_served)
    total = 0
    if recurrent.total && recurrent.total > 0
      total = recurrent.total
    else
      total = [
          recurrent.salaries,
          recurrent.electricity,
          recurrent.material,
          recurrent.administration,
          recurrent.treatment,
          recurrent.other,
      ].sum
    end
    per_system = total/number_of_systems
    per_design_population = total/total_design_population_served
    per_actual_population = total/total_actual_population_served
    recurrent_hash total, per_system, per_design_population, per_actual_population
  end

  def maintenance_expenditure_per_year(recurrent, number_of_systems, total_design_population_served, total_actual_population_served)
    total = recurrent.capital_maintenance_expenditure
    per_system = total/number_of_systems
    per_design_population = total/total_design_population_served
    per_actual_population = total/total_actual_population_served
    recurrent_hash total, per_system, per_design_population, per_actual_population
  end

  def direct_support_per_year(direct_support, total_design_population_served, total_percentage_served_design, average_system_size)
    total = [direct_support,total_design_population_served,total_percentage_served_design].inject(:*)
    per_system = direct_support * average_system_size
    per_design_population = direct_support
    per_actual_population = direct_support
    recurrent_hash total, per_system, per_design_population, per_actual_population
  end

  def indirect_support_per_year(indirect_support, total_design_population_served, total_percentage_served_design, average_system_size)
    total = [indirect_support,total_design_population_served,total_percentage_served_design].inject(:*)
    per_system = indirect_support * average_system_size
    per_design_population = indirect_support
    per_actual_population = indirect_support
    recurrent_hash total, per_system, per_design_population, per_actual_population
  end

  def loan_per_year(recurrent)
    total = recurrent.loan_cost
    recurrent_hash total, total, total, total
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
