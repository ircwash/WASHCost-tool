class Advanced::Water::QuestionOptionGroup
  include Mongoid::Document

  has_many :advanced_water_question_options, class_name: 'Advanced::Water::QuestionOption', inverse_of: 'advanced_water_question_option_group'

  field :name, type: String
end
