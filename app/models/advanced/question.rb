class Advanced::Question

  include Mongoid::Document

  field :caption,             type: String
  field :information,         type: String
  field :numeric_reference,   type: Integer
  field :section,             type: String

  embeds_one :scheme, as: :schemeable, class_name: 'Advanced::Scheme'

end
