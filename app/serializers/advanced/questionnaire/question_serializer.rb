class Advanced::Questionnaire::QuestionSerializer < ActiveModel::Serializer

  attributes :id,
             :caption,
             :information,
             :numeric_reference

  has_one :scheme, polymorphic: true

end
