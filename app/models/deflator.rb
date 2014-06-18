class Deflator
  include Mongoid::Document
  include Mongoid::Timestamps

  validates_presence_of :name, :year, :percent

  field :name, :type => String
  field :year, :type => Integer
  field :percent, :type => Float

end
