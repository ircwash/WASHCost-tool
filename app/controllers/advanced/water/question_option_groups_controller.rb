class Advanced::Water::QuestionOptionGroupsController < ApplicationController
  # GET /advanced/water/question_option_groups
  # GET /advanced/water/question_option_groups.json
  def index
    @advanced_water_question_option_groups = Advanced::Water::QuestionOptionGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @advanced_water_question_option_groups }
    end
  end

  # GET /advanced/water/question_option_groups/1
  # GET /advanced/water/question_option_groups/1.json
  def show
    @advanced_water_question_option_group = Advanced::Water::QuestionOptionGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @advanced_water_question_option_group }
    end
  end

  # GET /advanced/water/question_option_groups/new
  # GET /advanced/water/question_option_groups/new.json
  def new
    @advanced_water_question_option_group = Advanced::Water::QuestionOptionGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @advanced_water_question_option_group }
    end
  end

  # GET /advanced/water/question_option_groups/1/edit
  def edit
    @advanced_water_question_option_group = Advanced::Water::QuestionOptionGroup.find(params[:id])
  end

  # POST /advanced/water/question_option_groups
  # POST /advanced/water/question_option_groups.json
  def create
    @advanced_water_question_option_group = Advanced::Water::QuestionOptionGroup.new(params[:advanced_water_question_option_group])

    respond_to do |format|
      if @advanced_water_question_option_group.save
        format.html { redirect_to @advanced_water_question_option_group, notice: 'Question option group was successfully created.' }
        format.json { render json: @advanced_water_question_option_group, status: :created, location: @advanced_water_question_option_group }
      else
        format.html { render action: "new" }
        format.json { render json: @advanced_water_question_option_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /advanced/water/question_option_groups/1
  # PUT /advanced/water/question_option_groups/1.json
  def update
    @advanced_water_question_option_group = Advanced::Water::QuestionOptionGroup.find(params[:id])

    respond_to do |format|
      if @advanced_water_question_option_group.update_attributes(params[:advanced_water_question_option_group])
        format.html { redirect_to @advanced_water_question_option_group, notice: 'Question option group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @advanced_water_question_option_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advanced/water/question_option_groups/1
  # DELETE /advanced/water/question_option_groups/1.json
  def destroy
    @advanced_water_question_option_group = Advanced::Water::QuestionOptionGroup.find(params[:id])
    @advanced_water_question_option_group.destroy

    respond_to do |format|
      format.html { redirect_to advanced_water_question_option_groups_url }
      format.json { head :no_content }
    end
  end
end
