class Basic::ReportsController < ApplicationController
  def save
    tool_name = params[:tool_name]
    title = params[:title]
    form = session["#{params[:tool_name]}_basic_form".to_sym] || Hash.new(0)
    puts '-->',form
    saved_form_id = form[:saved_form_id]
    if saved_form_id.present? && saved_form_id != 0
      puts 'updating...'
      Rails.logger.debug "Updating report saved with id: #{saved_form_id}"
      current_user.basic_questionnaires.find(saved_form_id).update_attribute(:form, form)
    else
      puts 'saving...'
      session["#{params[:tool_name]}_basic_form".to_sym][:saved_form_id] = current_user.basic_questionnaires.create(title: title, tool_name: tool_name, form: form).id
      Rails.logger.debug "Report saved with id: #{session["#{params[:tool_name]}_basic_form".to_sym][:saved_form_id]}"
    end
  end
end
