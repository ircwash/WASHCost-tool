class Basic::Questionnaire
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user

  field :title,     type: String
  field :tool_name, type: String
  field :form,   type: Hash, default: {}

end
