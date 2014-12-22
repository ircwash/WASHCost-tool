class CalculatorController < ApplicationController

  before_filter :store_location
  
  protected

  def store_report( title, level, status, type, questionnaire, capital_expenditure_per_person, recurrent_expenditure_per_person_per_year, population_meeting_all_national_service_norms)
    new_report = UserReport.new(
      :title => title,
      :type  => type,
      :level => level,
      :status => status,
      :capital_expenditure_per_person => capital_expenditure_per_person,
      :recurrent_expenditure_per_person_per_year => recurrent_expenditure_per_person_per_year,
      :population_meeting_all_national_service_norms => population_meeting_all_national_service_norms,
      :questionnaire => questionnaire
    )
    arr = current_user.user_reports.select {|report| report["title"] == title }
    if(!new_report.valid? || arr.any?)
      @report = UserReport.new(params[:user_report])
      new_report.errors.messages.each do |key, value|
        @report.errors.add(key, value.first)
      end
      if(arr.any?)
        @report.errors.add(:unique_report, t('mongoid.errors.models.user_report.attributes.title.unique_report'))
      end
      render layout: 'general', template: 'shared/save_report'
    else
      current_user.user_reports << UserReport.new(
        :title => title,
        :type  => type,
        :level => level,
        :status => status,
        :capital_expenditure_per_person => capital_expenditure_per_person,
        :recurrent_expenditure_per_person_per_year => recurrent_expenditure_per_person_per_year,
        :population_meeting_all_national_service_norms => population_meeting_all_national_service_norms,
        :questionnaire => questionnaire
      )
      redirect_to dashboard_index_path(I18n.locale)
    end
  end
  
  def store_location
    session[:previous_url] = request.fullpath
  end
end