class Advanced::Tool::ServiceLevel

  include ActiveAttr::Model

  # What is the typical average distance in minutes from households to their main formal water source?
  attribute :accesibility_distance
  # Are there long queues at the water source OR are many more people using it than originally planned for?
  attribute :accesibility_queues
  # Does the service accessibility meet the national norms?
  attribute :accesibility_norms
  # What is the actual per capita use of water from formal sources per day (domestic use only)
  attribute :quantity_use
  # Does the service quantity meet the national norms?
  attribute :quantity_norms
  # How often is water quality testing done?
  attribute :quality_testing
  # Does the service quality meet the national norms?
  attribute :quality_norms
  # How reliable is the service?
  attribute :reliability
  # Does the service reliability meet the national norms?
  attribute :reliability_norms
  # What percentage of people in the service area receive this service?
  attribute :percentage_using

end
