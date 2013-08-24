class Basic::ReportController < ApplicationController
  def save_report
    tool_name = params[:tool_name]
    title = params[:title]
    form = session["#{params[:tool_name]}_basic_form".to_sym] || Hash.new(0)
    current_user.basic_questionnaires.build(title: title, tool_name: tool_name, form: form)
    respond_to do |format|
      format.js
    end
  end
end
