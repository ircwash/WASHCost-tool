class Report
  include Mongoid::Document
  include Mongoid::Timestamps

  validates_presence_of :title

  field :title, :type => String
  field :level, :type => String
  field :type,  :type => String
  field :questionnaire,  :type => Hash, :default => {}


  def unpack_questionnaire
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
