class Advanced::Report::Cost

  include ActiveAttr::Model

  attribute :capital
  attribute :recurrent

  # Calculate the average system size for each technology
  def average_system_size(total_design_population_served, total_percentage_served_design, number_of_systems)
    total_design_population_served*total_percentage_served_design/number_of_systems
  end

  def total_recurrent_cost_per_year(_recurrent, number_of_systems, total_design_population_served, total_percentage_served_design, total_actual_population_served, average_system_size)
        operational_expenditure_per_year = recurrent.operational_expenditure_per_year(_recurrent, number_of_systems, total_design_population_served, total_actual_population_served)
        maintenance_expenditure_per_year = recurrent.maintenance_expenditure_per_year(_recurrent, number_of_systems, total_design_population_served, total_actual_population_served)
        direct_support_per_year = recurrent.direct_support_per_year(_recurrent.direct_support, total_design_population_served, total_percentage_served_design, average_system_size)
        indirect_support_per_year = recurrent.indirect_support_per_year(_recurrent.indirect_support, total_design_population_served, total_percentage_served_design, average_system_size)
        loan_per_year = recurrent.loan_per_year(_recurrent)
        recurrent_hash [operational_expenditure_per_year[:total], maintenance_expenditure_per_year[:total], direct_support_per_year[:total], indirect_support_per_year[:total], loan_per_year[:total]],
                       [operational_expenditure_per_year[:per_system], maintenance_expenditure_per_year[:per_system], direct_support_per_year[:per_system], indirect_support_per_year[:per_system], loan_per_year[:per_system]],
                       [operational_expenditure_per_year[:per_design_population], maintenance_expenditure_per_year[:per_design_population], direct_support_per_year[:per_design_population], indirect_support_per_year[:per_design_population], loan_per_year[:per_design_population]],
                       [operational_expenditure_per_year[:per_actual_population], maintenance_expenditure_per_year[:per_actual_population], direct_support_per_year[:per_actual_population], indirect_support_per_year[:per_actual_population], loan_per_year[:per_actual_population]]
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
