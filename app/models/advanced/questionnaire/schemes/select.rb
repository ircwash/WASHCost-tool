class Advanced::Questionnaire::Schemes::Select < Advanced::Questionnaire::Schemes::Base

  field :placeholder,         type: String
  field :options,             type: Array
  field :enable_dont_know,    type: Boolean
  field :enable_blankm,       type: Boolean

end
