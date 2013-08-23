class Advanced::Water::QuestionOptionsController < ApplicationController
  # GET /advanced/water/question_options
  # GET /advanced/water/question_options.json
  def index
    @advanced_water_question_options = Advanced::Water::QuestionOption.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @advanced_water_question_options }
    end
  end

  # GET /advanced/water/question_options/1
  # GET /advanced/water/question_options/1.json
  def show
    @advanced_water_question_option = Advanced::Water::QuestionOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @advanced_water_question_option }
    end
  end

  # GET /advanced/water/question_options/new
  # GET /advanced/water/question_options/new.json
  def new
    @advanced_water_question_option = Advanced::Water::QuestionOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @advanced_water_question_option }
    end
  end

  # GET /advanced/water/question_options/1/edit
  def edit
    @advanced_water_question_option = Advanced::Water::QuestionOption.find(params[:id])
  end

  # POST /advanced/water/question_options
  # POST /advanced/water/question_options.json
  def create
    @advanced_water_question_option = Advanced::Water::QuestionOption.new(params[:advanced_water_question_option])

    respond_to do |format|
      if @advanced_water_question_option.save
        format.html { redirect_to @advanced_water_question_option, notice: 'Question option was successfully created.' }
        format.json { render json: @advanced_water_question_option, status: :created, location: @advanced_water_question_option }
      else
        format.html { render action: "new" }
        format.json { render json: @advanced_water_question_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /advanced/water/question_options/1
  # PUT /advanced/water/question_options/1.json
  def update
    @advanced_water_question_option = Advanced::Water::QuestionOption.find(params[:id])

    respond_to do |format|
      if @advanced_water_question_option.update_attributes(params[:advanced_water_question_option])
        format.html { redirect_to @advanced_water_question_option, notice: 'Question option was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @advanced_water_question_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advanced/water/question_options/1
  # DELETE /advanced/water/question_options/1.json
  def destroy
    @advanced_water_question_option = Advanced::Water::QuestionOption.find(params[:id])
    @advanced_water_question_option.destroy

    respond_to do |format|
      format.html { redirect_to advanced_water_question_options_url }
      format.json { head :no_content }
    end
  end
end
