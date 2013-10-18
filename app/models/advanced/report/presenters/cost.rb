class Advanced::Report::Presenters::Cost

  include ActiveAttr::Model

  attribute :capital
  attribute :recurrent
  attribute :total_capital_cost_per_year
  attribute :total_recurrent_cost_per_year

end
