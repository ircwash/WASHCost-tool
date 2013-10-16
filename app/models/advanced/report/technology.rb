class Advanced::Report::Technology

  include ActiveAttr::Model

  # Number of systems?
  attribute :number_of_systems
  # How many people do the sanitation system(s) serve?
  attribute :expected_number_of_people
  # How many people do the sanitation system(s) actually serve?
  attribute :server_number_of_people
  # Technology type
  attribute :water_source

  def water_source_attributes=(attributes)
    self.water_source = Advanced::Report::WaterSource.new(attributes)
  end


end
