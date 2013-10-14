class Advanced::Questionnaire::SectionsController < ApplicationController
  # GET /advanced/questionnaiere/sections.json
  def index
    render json: Advanced::Questionnaire::Section.all
  end
end
