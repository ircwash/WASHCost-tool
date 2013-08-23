class Advanced::Water::QuestionOptionGroup
  include Mongoid::Document
  has_many :options, class_name: "Advance::Water::QuestionOption"
  field :name, type: String
end
