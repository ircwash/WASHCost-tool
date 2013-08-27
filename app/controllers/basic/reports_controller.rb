class Basic::ReportsController < ApplicationController
  # this action saves the report associated with basic tool, also, this action verifies if a report session saved
  # is already exists
  def save
    puts '--> params', params
    querier = params[:querier]
    tool_name = params[:tool_name] || params[:basic_questionnaire][:tool_name]
    form = session["#{tool_name}_basic_form".to_sym] || Hash.new(0)
    saved_form_id = form[:saved_form_id]
    @response = {}
    @response[:tool_name] = tool_name

    if querier.present? && querier == 'link'
      if saved_form_id.present? && saved_form_id != 0
        puts 'updating...'
        Rails.logger.debug "Updating report saved with id: #{saved_form_id}"
        current_user.basic_questionnaires.find(saved_form_id).update_attribute(:form, form)
        @response[:partial] = 'save_confirmation'
        @response[:action] = 'updated'
      else
        @response[:partial] = 'save_form'
      end
    else
      puts 'saving...'
      title = params[:basic_questionnaire][:title]
      session["#{tool_name}_basic_form".to_sym][:saved_form_id] = current_user.basic_questionnaires.create(title: title, tool_name: tool_name, form: form).id
      Rails.logger.debug "Report saved with id: #{session["#{tool_name}_basic_form".to_sym][:saved_form_id]}"
      @response[:partial] = 'save_confirmation'
      @response[:action] = 'created'
    end
  end
end
