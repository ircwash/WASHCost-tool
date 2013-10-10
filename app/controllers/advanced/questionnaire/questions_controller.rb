class Advanced::Questionnaire::QuestionsController < ApplicationController
  # GET /advanced/questionnaiere/questions.json
  def index
    @advanced_questionnaire_questions = Advanced::Questionnaire::Question.all
    respond_to do |format|
      format.json { render json: @advanced_questionnaire_questions }
    end
  end
end
