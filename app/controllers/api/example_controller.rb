class Api::PeopleController < ApplicationController

  respond_to :json

  def index
    #@questionnaire = AdvancedWaterQuestionnaire.new( session )
    #render json: @questionnaire
  end
end