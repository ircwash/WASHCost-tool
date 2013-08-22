
class Advanced::Water::QuestionnaireTemplate

  def self.new_questionnaire
    questions = Advanced::Water::Question.all
    Advanced::Water::Questionnaire.new(questions: questions)
  end

end
