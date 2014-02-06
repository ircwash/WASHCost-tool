module BasicReportHelper

  # availability checks

  def basic_report_cost_available
    @questionnaire.capital_expenditure != nil && @questionnaire.recurrent_expenditure != nil
  end

  # formatters

  def report_dollar_currency_value_for( value, precision = 2 )
    value != nil ? "US$ #{number_with_precision( value.to_f, :precision => precision )}" : t( 'report.no_data' )
  end

  # outputs

  def sanitation_service_level_rating_label
    if @questionnaire.service_rating == 0
      t 'basic.sanitation.report.sustainability.one_star'
    elsif @questionnaire.service_rating == 1
      t 'basic.sanitation.report.sustainability.two_stars'
    elsif @questionnaire.service_rating == 2
      t 'basic.sanitation.report.sustainability.three_stars'
    elsif @questionnaire.service_rating == 3
      t 'basic.sanitation.report.sustainability.four_stars'
    else
      t 'basic.sanitation.report.value_not_set'
    end
  end

  def cost_rating_inside_benchmarks_label
    if @questionnaire.cost_rating_inside_benchmarks?
      t 'report.benchmark_within'
    else
      t 'report.benchmark_outside'
    end
  end

  def basic_report_level_of_service
    "#{t( 'basic.sanitation.report.summaries.a' + @questionnaire.level_of_service[0] )} \n #{t( 'basic.sanitation.report.summaries.b' + @questionnaire.level_of_service[1] )}"
  end

end
