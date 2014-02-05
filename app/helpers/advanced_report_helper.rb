module AdvancedReportHelper

  # availability checks

  def report_totals_available
    report_expenditure_totals_available != false || report_service_level_summary_available != false
  end

  def report_expenditure_totals_available
    @questionnaire.total_expenditure_for_years(30) != nil && @questionnaire.total_inputted_expenditure_per_person_per_year != nil && @questionnaire.total_expenditure_delta_per_person_per_year != nil
  end

  def report_service_level_summary_available
    @questionnaire.people_with_service_meeting_national_standard != nil
  end

  def report_sustainability_chart_available
    @questionnaire.operation_expenditure_per_person_per_year != nil && @questionnaire.direct_support_cost_per_person_per_year != nil && @questionnaire.capital_maintenance_expenditure_per_person_per_year != nil && @questionnaire.total_inputted_expenditure_per_person_per_year != nil
  end

  def service_area_comparison_available
    @questionnaire.total_service_area_capital_expenditure != nil && @questionnaire.total_service_area_recurrent_expenditure != nil
  end


  # formatteres

  def report_integer_value_for( value )
    value != nil ? "#{value.to_i}" : t( 'report.no_data' )
  end

  def report_currency_value_for( value )
    value != nil ? "#{( @questionnaire.currency || '' ).upcase} #{number_with_precision( value.to_f, :precision => 2 )}" : t( 'report.no_data' )
  end

  def report_delta_currency_value_for( value )
    value != nil ? "#{( @questionnaire.currency || '' ).upcase} #{number_with_precision( value.to_f.abs, :precision => 2 )} #{value.to_f > 0 ? t( 'report.surplus' ) : t( 'report.shortfall' )}" : t( 'report.no_data' )
  end

  def report_percentage_value_for( value )
    value != nil ? "#{value.to_f.round(2)}%" : t( 'report.no_data' )
  end

  def report_integer_percentage_value_for( value )
    value != nil ? "#{value.to_i}%" : '-'
  end


  # cumulative outputs

  def global_capital_expenditure_percentile( report_type )
    if @global_expenditure_percentile == nil && @global_total_reports == nil
      global_reports_with_lower_expenditure = 0
      @global_expenditure_percentile        = 0
      @global_total_reports                 = 0

      User.all.each do |user|
        user.reports.each do |report|

          if report.level == 'advanced' && report.type == report_type

            # unpack questionnaire model from report
            questionnaire = report.unpack_questionnaire

            # check that report is complete
            if questionnaire.complete?

              if questionnaire.total_service_area_capital_expenditure <= @questionnaire.total_service_area_capital_expenditure
                global_reports_with_lower_expenditure = global_reports_with_lower_expenditure + 1
              end

              # increment total to compute percentile
              @global_total_reports = @global_total_reports + 1

            end

          end

        end
      end

      @global_expenditure_percentile = @global_total_reports > 0 ? 100 * global_reports_with_lower_expenditure / @global_total_reports : '-'
    end

    [ @global_expenditure_percentile, @global_total_reports ]
  end

  def user_capital_expenditure_percentile( report_type )
    if @global_expenditure_percentile == nil && @global_total_reports == nil
      global_reports_with_lower_expenditure = 0
      @global_expenditure_percentile        = 0
      @global_total_reports                 = 0

      current_user.reports.each do |report|

        if report.level == 'advanced' && report.type == report_type

          # unpack questionnaire model from report
          questionnaire = report.unpack_questionnaire

          # check that report is complete
          if questionnaire.complete?

            if questionnaire.total_service_area_capital_expenditure <= @questionnaire.total_service_area_capital_expenditure
              global_reports_with_lower_expenditure = global_reports_with_lower_expenditure + 1
            end

            # increment total to compute percentile
            @global_total_reports = @global_total_reports + 1

          end

        end

      end

      @global_expenditure_percentile = @global_total_reports > 0 ? 100 * global_reports_with_lower_expenditure / @global_total_reports : '-'
    end

    [ @global_expenditure_percentile, @global_total_reports ]
  end

  def global_recurrent_expenditure_percentile( report_type )
    if @global_expenditure_percentile == nil && @global_total_reports == nil
      global_reports_with_lower_expenditure = 0
      @global_expenditure_percentile        = 0
      @global_total_reports                 = 0

      User.all.each do |user|
        user.reports.each do |report|

          if report.level == 'advanced' && report.type == report_type

            # unpack questionnaire model from report
            questionnaire = report.unpack_questionnaire

            # check that report is complete
            if questionnaire.complete?

              if questionnaire.total_service_area_recurrent_expenditure <= @questionnaire.total_service_area_recurrent_expenditure
                global_reports_with_lower_expenditure = global_reports_with_lower_expenditure + 1
              end

              # increment total to compute percentile
              @global_total_reports = @global_total_reports + 1

            end

          end

        end
      end

      @global_expenditure_percentile = @global_total_reports > 0 ? 100 * global_reports_with_lower_expenditure / @global_total_reports : '-'
    end

    [ @global_expenditure_percentile, @global_total_reports ]
  end

  def user_recurrent_expenditure_percentile( report_type )
    if @global_expenditure_percentile == nil && @global_total_reports == nil
      global_reports_with_lower_expenditure = 0
      @global_expenditure_percentile        = 0
      @global_total_reports                 = 0

      current_user.reports.each do |report|

        if report.level == 'advanced' && report.type == report_type

          # unpack questionnaire model from report
          questionnaire = report.unpack_questionnaire

          # check that report is complete
          if questionnaire.complete?

            if questionnaire.total_service_area_recurrent_expenditure <= @questionnaire.total_service_area_recurrent_expenditure
              global_reports_with_lower_expenditure = global_reports_with_lower_expenditure + 1
            end

            # increment total to compute percentile
            @global_total_reports = @global_total_reports + 1

          end

        end

      end

      @global_expenditure_percentile = @global_total_reports > 0 ? 100 * global_reports_with_lower_expenditure / @global_total_reports : '-'
    end

    [ @global_expenditure_percentile, @global_total_reports ]
  end

end
