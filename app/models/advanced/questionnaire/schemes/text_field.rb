class Advanced::Questionnaire::Schemes::TextField < Advanced::Questionnaire::Schemes::Base

  include Mongoid::Document

  field :placeholder,         type: String
  field :enable_dont_know,    type: Boolean

end
