class Advanced::Report::Technology

  include ActiveAttr::Model

  attribute :technology_descriptor
  attribute :costs

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


end
