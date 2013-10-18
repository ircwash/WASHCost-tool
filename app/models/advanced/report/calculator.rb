class Advanced::Report::Calculator

  include ActiveAttr::Model

  attribute :descriptor

  attribute :technology

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

  def presenter
    presenter = Advanced::Report::Presenter.new
    presenter.total_design_population_served = total_design_population_served
    presenter.total_actual_population_served = total_actual_population_served
    presenter.technologies = []
    descriptor.technologies.each do |_technology|
      technology_ = Advanced::Report::Presenters::Technology.new
      technology_.total_percentage_served_design = technology.total_percentage_served_design(_technology, presenter.total_design_population_served)
      technology_.total_percentage_served_actual = technology.total_percentage_served_actual(_technology, presenter.total_design_population_served)
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
    presenter
  end

end
