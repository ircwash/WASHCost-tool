class Scheme
  field :name, type: String

  embedded_in :schemeable, polymorphic: true
end
