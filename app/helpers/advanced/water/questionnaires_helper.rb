module Advanced::Water::QuestionnairesHelper
  def render_question(f, question)
    if question.is_numeric?
      f.input question.questionnaire_field, label: question.text
    end
  end
end
