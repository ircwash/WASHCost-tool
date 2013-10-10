class Advanced::TextField < Advanced::Scheme

  include Mongoid::Document

  field :placeholder,         type: String
  field :enable_dont_know,    type: Boolean

  embedded_in :schemeable, polymorphic: true

end
