class Advanced::Report::Technology

  include ActiveAttr::Model

  # Technology type
  attribute :source_type
  # Number of systems?
  attribute :number_of_systems
  # How many people do the sanitation system(s) serve?
  attribute :expected_number_of_people
  # How many people do the sanitation system(s) actually serve?
  attribute :server_number_of_people

end
