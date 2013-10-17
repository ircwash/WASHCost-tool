class Advanced::Tool::RecurrentCost

  include ActiveAttr::Model

  # What has been/will be the minor operation and maintenance expenditure? Either put "total" values in this row - or
  # detail dissagreagated expenditure below
  attribute :total
  # --> fine tune
  # salaries
  attribute :salaries
  # electricity
  attribute :electricity
  # material
  attribute :material
  # admintration
  attribute :administration
  # treatment
  attribute :treatment
  # other
  attribute :other
  # --
  # What has benn/will be spent on capital maintenance expenditure?
  attribute :capital_maintenance_expenditure
  # What is the cost servicing any loans taken to found the service?
  attribute :loan_cost
  # What is the payback period on this loan?
  attribute :loan_time

end
