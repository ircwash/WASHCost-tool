class Basic::ReportsController < ApplicationController

  authorize_resource class: Basic::ReportsController
  
  # this action saves the report associated with basic tool, also, this action verifies if a report session saved
  # is already exists
  def save
    puts '--> params', params
    querier = params[:querier]
    tool_name = params[:tool_name] || params[:basic_questionnaire][:tool_name]
    form = session["#{tool_name}_basic_form".to_sym] || Hash.new(0)
    form[:pages_completed] = session["#{tool_name}_basic_complete".to_sym] || 0
    saved_form_id = form[:saved_form_id]
    @response = {}
    @response[:tool_name] = tool_name

    if querier.present? && querier == 'link'
      if saved_form_id.present? && saved_form_id != 0
        puts 'updating...'
        Rails.logger.debug "Updating report saved with id: #{saved_form_id}"
        current_user.basic_questionnaires.find(saved_form_id).update_attribute(:form, form)
        flash[:alert] = "Your report was updated successfully"
        @path_to = dashboard_index_path
        render 'redirect'
      else
        puts 'open saving popup...'
        @questionnaire = Basic::Questionnaire.new
        @response[:partial] = 'save_form'
        @response[:div_container] = '.reveal-modal.report.save'
      end
    else
      puts 'saving...'
      params[:basic_questionnaire][:form] = form
      @questionnaire = Basic::Questionnaire.new(params[:basic_questionnaire])
      if @questionnaire.valid?
        current_user.basic_questionnaires << @questionnaire
        session["#{tool_name}_basic_form".to_sym][:saved_form_id] = @questionnaire.id
        Rails.logger.debug "Report saved with id: #{session["#{tool_name}_basic_form".to_sym][:saved_form_id]}"
        flash[:alert] = "Your report was created successfully"
        @path_to = dashboard_index_path
        render 'redirect'
      else
        Rails.logger.debug "Report saved invalid, no title specified"
        @response[:partial] = 'save_form'
        @response[:div_container] = '.reveal-modal.report.save'
      end
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
    redirect_to "/cal/#{tool_name}_basic/report"
  end
end
