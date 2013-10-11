class Advanced::Questionnaire::QuestionsController < ApplicationController
  # GET /advanced/questionnaiere/questions.json
  def index
    render json: Advanced::Questionnaire::Question.all
  end
end
