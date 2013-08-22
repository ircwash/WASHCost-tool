class Advanced::Water::QuestionnairesController < ApplicationController
  def index
   @questionnaire = Advanced::Water::QuestionnaireTemplate.new_questionnaire


 end
end
