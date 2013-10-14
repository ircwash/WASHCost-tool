class Advanced::Questionnaire::QuestionSerializer < ActiveModel::Serializer

  attributes :id,
             :caption,
             :information,
             :numeric_reference

end
