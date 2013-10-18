class Advanced::Tool::Technology

  include ActiveAttr::Model

  # Technology type
  attribute :type
  # Number of systems?
  attribute :number_of_systems, :type => Float, :default => 380
  # How many people do the sanitation system(s) serve?
  attribute :expected_number_of_people, :type => Float, :default => 110700
  # How many people do the sanitation system(s) actually serve?
  attribute :server_number_of_people, :type => Float, :default => 58000
  # Water Source
  attribute :water_source
  # Costs
  attribute :costs

  def water_source_attributes=(attributes)
    self.water_source = Advanced::Tool::WaterSource.new(attributes)
  end

  def costs_attributes=(attributes)
    self.costs = Advanced::Tool::Cost.new(attributes)
  end
end
