class ExchangeRate
  include Mongoid::Document
  include Mongoid::Timestamps

  validates_presence_of :name, :year, :rate

  field :name, :type => String
  field :year, :type => Integer
  field :rate, :type => Float

end
