class Report
  include Mongoid::Document
  include Mongoid::Timestamps

  validates_presence_of :level, :type, :questionnaire

  field :level,         :type => String
  field :type,          :type => String
  field :status,        :type => String, :default => '0'
  field :questionnaire, :type => Hash,   :default => {}

  def unpack_questionnaire
    if level == 'basic'
      if type == 'water'
       questionnaire_instance = BasicWaterQuestionnaire.new( nil )
        questionnaire_instance.update_attributes( questionnaire )
      elsif type == 'sanitation'
        questionnaire_instance = BasicSanitationQuestionnaire.new( nil )
        questionnaire_instance.update_attributes( questionnaire )
      end
    end
    if level == 'advanced'
      if type == 'water'
        questionnaire_instance = AdvancedWaterQuestionnaire.new( nil )
        questionnaire_instance.update_attributes( questionnaire )
      elsif type == 'sanitation'
        questionnaire_instance = AdvancedSanitationQuestionnaire.new( nil )
        questionnaire_instance.update_attributes( questionnaire )
      end
    end
    questionnaire_instance
  end

end