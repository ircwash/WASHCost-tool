class Basic::ReportsController < ApplicationController

  authorize_resource class: Basic::ReportsController

  layout "general"

  def questionnaire
    @tool_name = params[:tool_name] || params[:basic_questionnaire][:tool_name]
    form = session["#{@tool_name}_basic_form".to_sym] || Hash.new(0)
    form[:pages_completed] = session["#{@tool_name}_basic_complete".to_sym] || 0
    saved_form_id = form[:saved_form_id]

    if saved_form_id.present? && saved_form_id != 0
      Rails.logger.debug "Updating report saved with id: #{saved_form_id}"
      current_user.basic_questionnaires.find(saved_form_id).update_attribute(:form, form)
      flash[:alert] = t('report.updated_successsfully')
      @path_to = dashboard_index_path

      redirect_to dashboard_index_path
    else
      puts 'open saving popup...'
      @questionnaire = Basic::Questionnaire.new
    end
  end

  # this action saves the report associated with basic tool, also, this action verifies if a report session saved
  # is already exists
  def save
    @tool_name = params[:tool_name] || params[:basic_questionnaire][:tool_name]
    form = session["#{@tool_name}_basic_form".to_sym] || Hash.new(0)
    form[:pages_completed] = session["#{@tool_name}_basic_complete".to_sym] || 0
    saved_form_id = form[:saved_form_id]
    params[:basic_questionnaire][:form] = form
    @questionnaire = Basic::Questionnaire.new(params[:basic_questionnaire])

    if @questionnaire.valid?
      current_user.basic_questionnaires << @questionnaire
      session["#{@tool_name}_basic_form".to_sym][:saved_form_id] = @questionnaire.id
      Rails.logger.debug "Report saved with id: #{session["#{@tool_name}_basic_form".to_sym][:saved_form_id]}"
      flash[:alert] = t('report.created_successsfully')
      @path_to = dashboard_index_path

      redirect_to dashboard_index_path
    else
      Rails.logger.debug "Report saved invalid, no title specified"

      render 'questionnaire'
    end
  end

  # this action import the specific report regarding the selection of user in dashboard
  def load
    puts params
    questionnaire = current_user.basic_questionnaires.find(params[:id_questionnaire])
    tool_name = questionnaire.tool_name
    session["#{tool_name}_basic_form".to_sym] = Hash.new(0)

    questionnaire.form.each do |answer|
      session["#{tool_name}_basic_form".to_sym][answer[0]]=answer[1]
    end

    session["#{tool_name}_basic_complete".to_sym] = questionnaire.form["pages_completed"]
    session["#{tool_name}_basic_form".to_sym][:saved_form_id] = params[:id_questionnaire]

    redirect_to tool_name == 'water' ? basic_water_report_path : basic_sanitation_report_path
  end
end
