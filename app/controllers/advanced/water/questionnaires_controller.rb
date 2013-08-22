class Advanced::Water::QuestionnairesController < ApplicationController
  # GET /advanced/water/questionnaires
  # GET /advanced/water/questionnaires.json
  def index
    #@questionnaire = Advanced::Water::QuestionnaireTemplate.new_questionnaire
    @advanced_water_questionnaires = Advanced::Water::Questionnaire.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @advanced_water_questionnaires }
    end
  end

  # GET /advanced/water/questionnaires/1
  # GET /advanced/water/questionnaires/1.json
  def show
    @advanced_water_questionnaire = Advanced::Water::Questionnaire.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @advanced_water_questionnaire }
    end
  end

  # GET /advanced/water/questionnaires/new
  # GET /advanced/water/questionnaires/new.json
  def new
    #@questionnaire = Advanced::Water::QuestionnaireTemplate.new_questionnaire
    @advanced_water_questionnaire = Advanced::Water::Questionnaire.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @advanced_water_questionnaire }
    end
  end

  # GET /advanced/water/questionnaires/1/edit
  def edit
    @advanced_water_questionnaire = Advanced::Water::Questionnaire.find(params[:id])
  end

  # POST /advanced/water/questionnaires
  # POST /advanced/water/questionnaires.json
  def create
    @advanced_water_questionnaire = Advanced::Water::Questionnaire.new(params[:advanced_water_questionnaire])

    respond_to do |format|
      if @advanced_water_questionnaire.save
        format.html { redirect_to @advanced_water_questionnaire, notice: 'Questionnaire was successfully created.' }
        format.json { render json: @advanced_water_questionnaire, status: :created, location: @advanced_water_questionnaire }
      else
        format.html { render action: "new" }
        format.json { render json: @advanced_water_questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /advanced/water/questionnaires/1
  # PUT /advanced/water/questionnaires/1.json
  def update
    @advanced_water_questionnaire = Advanced::Water::Questionnaire.find(params[:id])

    respond_to do |format|
      if @advanced_water_questionnaire.update_attributes(params[:advanced_water_questionnaire])
        format.html { redirect_to @advanced_water_questionnaire, notice: 'Questionnaire was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @advanced_water_questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advanced/water/questionnaires/1
  # DELETE /advanced/water/questionnaires/1.json
  def destroy
    @advanced_water_questionnaire = Advanced::Water::Questionnaire.find(params[:id])
    @advanced_water_questionnaire.destroy

    respond_to do |format|
      format.html { redirect_to advanced_water_questionnaires_url }
      format.json { head :no_content }
    end
  end
end
