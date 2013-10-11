class Advanced::Questionnaire::Question

  include Mongoid::Document

  field :caption,             type: String
  field :information,         type: String
  field :numeric_reference,   type: Integer
  field :section,             type: String

  # Inverted polymorphic asociation, this points to Base class which is the parent class the another classes that
  # represent the real polymorphic relation (TextField, Select, etc) in their associated namespaces
  #embeds_one :scheme, as: :schemeable, class_name: 'Advanced::Questionnaire::Schemes::Base'

end
