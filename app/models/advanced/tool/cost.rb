class Advanced::Tool::Cost

  include ActiveAttr::Model

  # Capital costs
  attribute :capital
  # Recurrent costs
  attribute :recurrent

  def capital_attributes=(attributes)
    self.capital = Advanced::Tool::CapitalCost.new(attributes)
  end

  def recurrent_attributes=(attributes)
    self.recurrent = Advanced::Tool::RecurrentCost.new(attributes)
  end

end
