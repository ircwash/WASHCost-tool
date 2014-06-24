class Deflator
  include Mongoid::Document
  include Mongoid::Timestamps

  validates_presence_of :name, :year, :percent, :alpha3

  field :name, :type => String
  field :year, :type => Integer
  field :percent, :type => Float
  field :alpha3, :type => String

end
