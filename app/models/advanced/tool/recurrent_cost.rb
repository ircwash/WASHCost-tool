class Advanced::Tool::RecurrentCost

  include ActiveAttr::Model

  # What has been/will be the minor operation and maintenance expenditure? Either put "total" values in this row - or
  # detail dissagreagated expenditure below
  attribute :total, :type => Float, :default => 21450
  attribute :lifespan, :type => Float, :default => 30

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
  attribute :capital_maintenance_expenditure, :type => Float, :default => 120678
  # What has been/will be spent on expenditure on direct support?
  attribute :direct_support_spent, :type => Float, :default => 0.8
  # What has been/will be the expenditure on indirect support?
  attribute :indirect_support_spent, :type => Float, :default => 0.1
  # What is the cost servicing any loans taken to found the service?
  attribute :loan_cost, :type => Float, :default => 0
  # What is the payback period on this loan?
  attribute :loan_time, :type => Float

end
