class Advanced::Report::Cost

  include ActiveAttr::Model

  # Capital costs
  attribute :capital
  # Recurrent costs
  attribute :recurrent
  # What has been/will be spent on expenditure on direct support?
  attribute :direct_support_spent
  # What has been/will be the expenditure on indirect support?
  attribute :indirect_support_spent

  def capital_attributes=(attributes)
    self.capital = Advanced::Report::CapitalCost.new(attributes)
  end

  def recurrent_attributes=(attributes)
    self.recurrent = Advanced::Report::RecurrentCost.new(attributes)
  end

end
