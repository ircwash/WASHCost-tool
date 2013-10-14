class Advanced::Questionnaire::SectionSerializer < ActiveModel::Serializer

  attributes :name

  has_many :questions, embed: :objects

end
