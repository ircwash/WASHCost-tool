class CalculatorController < ApplicationController

  protected

  def store_report( title, level, type, questionnaire )
    current_user.reports <<  Report.new(
      :title => title,
      :type  => type,
      :level => level,
      :questionnaire => questionnaire
    )

    redirect_to dashboard_index_path
  end

end
