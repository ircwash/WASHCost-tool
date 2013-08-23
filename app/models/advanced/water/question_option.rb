class Advanced::Water::QuestionOption
  include Mongoid::Document

  belongs_to :advanced_water_question_option_group, class_name: 'Advanced::Water::QuestionOptionGroup', inverse_of: 'advanced_water_question_options'

  field :label, type: String
  field :class_name, type: String
end
