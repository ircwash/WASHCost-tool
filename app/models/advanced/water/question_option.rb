class Advanced::Water::QuestionOption
  include Mongoid::Document
  field :label, type: String
  field :class_name, type: String
end
