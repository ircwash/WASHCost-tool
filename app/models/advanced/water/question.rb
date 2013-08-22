class Advanced::Water::Question
  include Mongoid::Document
  belongs_to :questionnaire, :class_name => "Advanced::Water::Questionnaire"

  field :questionnaire_field, type: String
  field :text,                type: String
  field :i18n_text_key,       type: String
  field :section,             type: String
  field :location_selector,   type: String
  field :type,                type: String
  #field :visual_type,         type: String
  field :partial,             type: String

  def is_numeric?
    true
  end

end
