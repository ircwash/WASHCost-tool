class Advanced::Tool::ServiceLevel

  include ActiveAttr::Model

  # What is the typical average distance in minutes from households to their main formal water source?
  attribute :accesibility_distance, :type => Integer
  # Are there long queues at the water source OR are many more people using it than originally planned for?
  attribute :accesibility_queues, :type => Integer
  # Does the service accessibility meet the national norms?
  attribute :accesibility_norms, :type => Integer
  # What is the actual per capita use of water from formal sources per day (domestic use only)
  attribute :quantity_use, :type => Integer
  # Does the service quantity meet the national norms?
  attribute :quantity_norms, :type => Integer
  # How often is water quality testing done?
  attribute :quality_testing, :type => Integer
  # Does the service quality meet the national norms?
  attribute :quality_norms, :type => Integer
  # How reliable is the service?
  attribute :reliability, :type => Integer
  # Does the service reliability meet the national norms?
  attribute :reliability_norms, :type => Integer
  # What percentage of people in the service area receive this service?
  attribute :percentage_using, :type => Float, :default => 33.3333

end
