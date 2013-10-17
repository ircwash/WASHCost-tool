class Advanced::Report::WaterSource

  include ActiveAttr::Model

  # water source?
  attribute :source
  # if surface water - define primary source | if ground water - define primary source
  attribute :primary_source
  # if drilled well with nnon-mechanised pump. Define most common pump
  attribute :common_pump
  # how is water typically stored
  attribute :storing
  # How is the water tipically treated
  attribute :treating
  # Type os power supply
  attribute :power_supply
  # Length of distribution line (Km)
  attribute :length
end
