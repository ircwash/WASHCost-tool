class Advanced::Report::Calculator

  include ActiveAttr::Model

  attribute :descriptor

  attribute :technology
  attribute :service_level

  # This represents the design number of users and this value can be chosen by the user to calculate costs per person design
  # @return [Long]
  def total_design_population_served
    #descriptor.technologies.inject do |acumulator,technology|
    #  acumulator + technology.expected_number_of_people.to_i
    #end
    descriptor.technologies.map {|technology| technology.expected_number_of_people}.sum
  end

  # This represents the actual or effective number of users and is the default value to be taken calculate costs per person
  # @return [Long]
  def total_actual_population_served
    descriptor.technologies.map {|technology| technology.server_number_of_people}.sum
  end

  def service_level_summary(service_levels)
    high_service = service_levels.reject {|service_level| service_level.washcost_standard!=4 }.map{|service_level| service_level.percentage_population_served}.sum
    basic_service = service_levels.reject {|service_level| service_level.washcost_standard!=3 }.map{|service_level| service_level.percentage_population_served}.sum
    sub_standard_service = service_levels.reject {|service_level| service_level.washcost_standard!=2 }.map{|service_level| service_level.percentage_population_served}.sum
    no_service = service_levels.reject {|service_level| service_level.washcost_standard!=1 }.map{|service_level| service_level.percentage_population_served}.sum
    meet_norms = service_levels.reject {|service_level| service_level.national_norm!=2 }.map{|service_level| service_level.percentage_population_served}.sum
    not_meet_norms = service_levels.reject {|service_level| service_level.national_norm!=1 }.map{|service_level| service_level.percentage_population_served}.sum
    {
        high_service: "#{high_service}% of the service area recieve a high level of service",
        basic_service: "#{basic_service}% of the service area recieve a basic level of service",
        sub_standard_service: "#{sub_standard_service}% of the service area recieve a substandard level of service",
        no_service: "#{no_service}% of the service area recieve no service",
        meet_norms: "#{meet_norms}% of the service area recieve a service that meets national norm",
        not_meet_norms: "#{not_meet_norms}% of the service area recieve a service that does not meets national norm"
    }
  end

  def presenter
    presenter = Advanced::Report::Presenter.new
    presenter.title = descriptor.title
    presenter.sanitation_service_type = descriptor.sanitation_service_type
    presenter.country = descriptor.country
    presenter.population_density = descriptor.population_density
    presenter.service_management = descriptor.service_management
    presenter.service_financing = descriptor.service_financing
    presenter.service_maintenance = descriptor.service_maintenance
    presenter.service_standarization = descriptor.service_standarization
    presenter.service_costing = descriptor.service_costing
    presenter.average_household_income = descriptor.average_household_income
    presenter.average_household_size = descriptor.average_household_size
    presenter.total_design_population_served = total_design_population_served
    presenter.total_actual_population_served = total_actual_population_served
    presenter.technologies = []
    descriptor.technologies.each do |_technology|
      technology_ = Advanced::Report::Presenters::Technology.new
      technology_.total_percentage_served_design = technology.total_percentage_served_design(_technology, presenter.total_design_population_served)
      technology_.total_percentage_served_actual = technology.total_percentage_served_actual(_technology, presenter.total_actual_population_served)
      technology_.average_system_size = technology.average_system_size(presenter.total_design_population_served, technology_.total_percentage_served_design, _technology.number_of_systems)
      technology_.costs = Advanced::Report::Presenters::Cost.new
      technology_.costs.capital = Advanced::Report::Presenters::CapitalCost.new
      technology_.costs.recurrent = Advanced::Report::Presenters::RecurrentCost.new
      technology_.costs.capital.expenditures = technology.costs.capital.total_capital_expenditure(_technology.costs.capital, _technology.number_of_systems, presenter.total_design_population_served, presenter.total_actual_population_served)
      technology_.costs.recurrent.operational_expenditure_per_year = technology.costs.recurrent.operational_expenditure_per_year(_technology.costs.recurrent, _technology.number_of_systems, presenter.total_design_population_served, presenter.total_actual_population_served)
      technology_.costs.recurrent.maintenance_expenditure_per_year = technology.costs.recurrent.maintenance_expenditure_per_year(_technology.costs.recurrent, _technology.number_of_systems, presenter.total_design_population_served, presenter.total_actual_population_served)
      technology_.costs.recurrent.direct_support_per_year = technology.costs.recurrent.direct_support_per_year(_technology.costs.recurrent.direct_support_spent, presenter.total_design_population_served, technology_.total_percentage_served_design, technology_.average_system_size)
      technology_.costs.recurrent.indirect_support_per_year = technology.costs.recurrent.indirect_support_per_year(_technology.costs.recurrent.indirect_support_spent, presenter.total_design_population_served, technology_.total_percentage_served_design, technology_.average_system_size)
      technology_.costs.recurrent.loan_per_year = technology.costs.recurrent.loan_per_year(_technology.costs.recurrent)
      technology_.costs.total_capital_cost_per_year = technology_.costs.capital.expenditures
      technology_.costs.total_recurrent_cost_per_year = technology.costs.total_recurrent_cost_per_year(technology_.costs.recurrent.operational_expenditure_per_year, technology_.costs.recurrent.maintenance_expenditure_per_year, technology_.costs.recurrent.direct_support_per_year, technology_.costs.recurrent.indirect_support_per_year, technology_.costs.recurrent.loan_per_year)
      presenter.technologies << technology_
    end
    presenter.service_levels = []
    descriptor.service_levels.each do |_service_level|
      service_level_ = Advanced::Report::Presenters::ServiceLevel.new
      service_level_.washcost_standard = service_level.washcost_standard(_service_level)
      service_level_.national_norm = service_level.national_norm(_service_level)
      service_level_.washcost_standard_caption = service_level.washcost_standard_caption(service_level_.washcost_standard)
      service_level_.national_norm_caption = service_level.national_norm_caption(service_level_.national_norm)
      service_level_.percentage_population_served = service_level.percentage_population_served(_service_level)
      presenter.service_levels << service_level_
    end
    presenter.service_level_summary = service_level_summary(presenter.service_levels)
    presenter
  end

end
