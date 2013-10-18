class Advanced::Report::Technology

  include ActiveAttr::Model

  attribute :costs

  def total_percentage_served_design(technology, total_design_population_served)
    total_design_population_served/(technology.expected_number_of_people || 1)
  end

  def total_percentage_served_actual(technology, total_design_population_served)
    total_design_population_served/(technology.server_number_of_people || 1)
  end

  # Calculate the average system size for each technology
  def average_system_size(total_design_population_served, total_percentage_served_design, number_of_systems)
    total_design_population_served*total_percentage_served_design/number_of_systems
  end

end
