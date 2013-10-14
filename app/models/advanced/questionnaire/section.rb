class Advanced::Questionnaire::Section
  include Mongoid::Document

  field :name, type: String
  has_many :questions, class_name: 'Advanced::Questionnaire::Question', inverse_of: 'section'
end
