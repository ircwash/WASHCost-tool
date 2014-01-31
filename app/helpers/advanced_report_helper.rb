module AdvancedReportHelper

  def report_totals_available
    report_expenditure_totals_available != false || report_service_level_summary_available != false
  end

  def report_expenditure_totals_available
    @questionnaire.total_expenditure_for_years(30) != nil && @questionnaire.total_inputted_expenditure_per_person_per_year != nil && @questionnaire.total_expenditure_delta_per_person_per_year != nil
  end

  def report_service_level_summary_available
    @questionnaire.people_with_service_meeting_national_standard != nil
  end


  def report_integer_value_for( value )
    value != nil ? "#{value.to_i}" : t( 'report.no_data' )
  end

  def report_currency_value_for( value )
    value != nil ? "#{@questionnaire.currency} #{value.to_f.round(2)}" : t( 'report.no_data' )
  end

  def report_percentage_value_for( value )
    value != nil ? "#{value.to_f.round(2)}%" : t( 'report.no_data' )
  end

end