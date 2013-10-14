class Advanced::Questionnaire::SectionSerializer < ActiveModel::Serializer

  attributes :id,
             :name

  has_many :questions, embed: :objects

end
