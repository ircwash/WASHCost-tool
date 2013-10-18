class Advanced::Report::Calculator

  include ActiveAttr::Model

  attribute :descriptor
  attribute :technologies

  # This represents the design number of users and this value can be chosen by the user to calculate costs per person design
  # @return [Long]
  def total_design_population_served
    descriptor.technologies.inject do |acumulator,technology|
      acumulator + technology.expected_number_of_people
    end
  end

  # This represents the actual or effective number of users and is the default value to be taken calculate costs per person
  # @return [Long]
  def total_actual_population_served
    descriptor.technologies.inject do |acumulator,technology|
      acumulator + technology.server_number_of_people
    end
  end

  def total_capexp
    technologies
  end

end
