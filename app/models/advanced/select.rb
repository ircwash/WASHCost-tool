class Advanced::Select < Advanced::Scheme

  include Mongoid::Document

  field :placeholder,         type: String
  field :options,             type: Array
  field :enable_dont_know,    type: Boolean
  field :enable_blankm,       type: Boolean

  embedded_in :schemeable, polymorphic: true

end
