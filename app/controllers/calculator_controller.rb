class CalculatorController < ApplicationController

  protected

  def store_report( title, level, type, questionnaire )
    new_report = UserReport.new(
      :title => title,
      :type  => type,
      :level => level,
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
        :questionnaire => questionnaire
      )
      redirect_to dashboard_index_path
    end
  end
end