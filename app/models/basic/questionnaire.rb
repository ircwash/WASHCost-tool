class Basic::Questionnaire
  include Mongoid::Document
  include Mongoid::Timestamps

  # relations
  embedded_in :user

  # validations
  validates_presence_of :title

  field :title,     type: String
  field :tool_name, type: String
  field :form,   type: Hash, default: {}

end
