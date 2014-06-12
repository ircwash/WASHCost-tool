class Deflator
  include Mongoid::Document
  include Mongoid::Timestamps

  validates_presence_of :name, :year, :gdp

  field :name, :type => String
  field :year, :type => Integer
  field :gdp, :type => Float

end
