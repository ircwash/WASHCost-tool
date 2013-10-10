class Advanced::Questionnaire::Schemes::Base

  include Mongoid::Document

  embedded_in :schemeable, polymorphic: true

end
