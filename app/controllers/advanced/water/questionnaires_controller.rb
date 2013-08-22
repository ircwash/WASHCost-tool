class Advanced::Water::QuestionnairesController < ApplicationController
  def index
   @questionnaire = QuestionnaireTemplate.new_questionnaire


 end
end
