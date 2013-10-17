class Advanced::Tool::Descriptor

  include ActiveAttr::Model

  # Report Name
  attribute :title
  # Does the sanitation service already exist or is it planned?
  attribute :sanitation_service_type
  # Country
  attribute :country
  # Region
  attribute :region
  # City
  attribute :city
  # Description of area type?
  attribute :area_type
  # What is the population density of the service area?
  attribute :population_density
  # Which of these options best describes how the sanitation service is managed?
  attribute :service_management
  # Who finances the construction of the sanitation system?
  attribute :service_financing
  # Who undertakes the operation and maintenance of the infrastructure?
  attribute :service_maintenance
  # Who has/will have responsibility for checking and enforcing the standard of sanitation services?
  attribute :service_standarization
  # Who covers the cost of rehabilitation when larger repairs are needed (pit/tank emptying)?
  attribute :service_costing
  # What is the average annual household income in the service area
  attribute :average_household_income
  # Average household size
  attribute :average_household_size
  # Has many technologies
  attribute :technologies
  # Service levels
  attribute :service_levels

  def technologies_attributes=(_technologies)
    self.technologies = []
    _technologies.keys.each do |index|
      self.technologies << Advanced::Tool::Technology.new(_technologies[index])
    end
  end

  def service_levels_attributes=(_service_levels)
    self.service_levels = []
    _service_levels.keys.each do |index|
      self.service_levels << Advanced::Tool::ServiceLevel.new(_service_levels[index])
    end
  end


end
