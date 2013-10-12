class Advanced::Questionnaire::QuestionSerializer < ActiveModel::Serializer

  attributes :caption,
             :information,
             :numeric_reference,
             :section

end
