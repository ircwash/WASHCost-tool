class ExchangeRate
  include Mongoid::Document
  include Mongoid::Timestamps

  validates_presence_of :name, :rates

  field :name, :type => String
  field :rates, :type => Hash, :default => {}

end
