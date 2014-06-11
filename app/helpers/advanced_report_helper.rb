module AdvancedReportHelper

  # availability checks

  def report_totals_available
    report_expenditure_totals_available != false || report_service_level_summary_available != false
  end

  def report_expenditure_totals_available
    @questionnaire.total_expenditure_for_years(30) != nil && @questionnaire.total_inputted_recurrent_expenditure_per_person_per_year != nil && @questionnaire.total_expenditure_delta_per_person_per_year != nil
  end

  def report_service_level_summary_available
    @questionnaire.percentage_of_population_that_meets_all_norms != nil
  end

  def report_sustainability_chart_available
    @questionnaire.operation_expenditure_per_person_per_year != nil && @questionnaire.direct_support_cost != nil && @questionnaire.capital_maintenance_expenditure_per_person_per_year != nil && @questionnaire.total_inputted_recurrent_expenditure_per_person_per_year != nil
  end

  def service_area_comparison_available
    @questionnaire.total_service_area_capital_expenditure != nil && @questionnaire.total_service_area_recurrent_expenditure != nil
  end

  def water_service_level_comparison_available
    @questionnaire.percentage_of_population_that_meets_accessibility_norms != nil && @questionnaire.percentage_of_population_that_meets_reliability_norms != nil && @questionnaire.percentage_of_population_that_meets_quality_norms != nil && @questionnaire.percentage_of_population_that_meets_quantity_norms != nil
  end

  def sanitation_service_level_comparison_available
    @questionnaire.percentage_of_population_that_meets_accessibility_norms != nil && @questionnaire.percentage_of_population_that_meets_use_norms != nil && @questionnaire.percentage_of_population_that_meets_reliability_norms != nil && @questionnaire.percentage_of_population_that_meets_environmental_protection_norms != nil
  end

  def report_comparison_summary_available
    @questionnaire.total_service_area_capital_expenditure != nil
  end

  def summary_columns_for_report( available )
    100 / available.delete_if{ |i| i == false }.count
  end


  # formatteres

  def report_integer_value_for( value )
    value != nil ? "#{value.to_i}" : t( 'report.no_data' )
  end

  def report_float_value_for( value )
    value != nil ? "#{value.to_f}" : t( 'report.no_data' )
  end

  def report_currency_value_for( value, precision = 2 )
    value != nil ? "#{( @questionnaire.currency || '' ).upcase} #{number_with_precision( value.to_f, :precision => precision )}" : t( 'report.no_data' )
  end

  def report_delta_currency_value_for( value, precision = 2 )
    if (value != nil && value == 0.00)
      "#{( @questionnaire.currency || '' ).upcase} #{number_with_precision( value.to_f.abs, :precision => precision )}"
    else
      value != nil ? "#{( @questionnaire.currency || '' ).upcase} #{number_with_precision( value.to_f.abs, :precision => precision )} #{value.to_f > 0 ? t( 'report.surplus' ) : t( 'report.shortfall' )}" : t( 'report.no_data' )
    end
  end

  def report_percentage_value_for( value )
    value != nil ? "#{value.to_f.round(1)}%" : t( 'report.no_data' )
  end

  def report_integer_percentage_value_for( value )
    value != nil ? "#{value.to_i}%" : '-'
  end


  # cumulative expenditure outputs

  def advanced_percentile_comparison( metric, report_type, currency = false )

    if instance_variable_get( "@global_percentile_#{metric.to_s}" ) == nil && instance_variable_get( "@global_total_reports_#{metric.to_s}" ) == nil
      reports_lower        = 0
      global_percentile    = 0
      global_total_reports = 0

      User.all.each do |user|
        user.user_reports.each do |report|

          if report.level == 'advanced' && report.type == report_type

            # unpack questionnaire model from report
            questionnaire = report.unpack_questionnaire

            # check that report is complete
            if questionnaire.complete?

              if @questionnaire
                if value_for_advanced_metric( questionnaire.send( "#{metric.to_s}" ), currency ? questionnaire.currency : nil ) <= value_for_advanced_metric( @questionnaire.send( "#{metric.to_s}" ), currency ? @questionnaire.currency : nil )
                  reports_lower = reports_lower + 1
                end
              end

              # increment total to compute percentile
              global_total_reports = global_total_reports + 1

            end

          end

        end
      end

      global_percentile = global_total_reports > 0 ? 100 * reports_lower / global_total_reports : nil

      # cache values into instance variables
      instance_variable_set( "@global_percentile_#{metric.to_s}", global_percentile )
      instance_variable_set( "@global_total_reports_#{metric.to_s}", global_total_reports )
    end

    [ instance_variable_get( "@global_percentile_#{metric.to_s}" ), instance_variable_get( "@global_total_reports_#{metric.to_s}" ) ]
  end

  def advanced_percentile_comparison_for_user( metric, report_type, currency = false )

    if instance_variable_get( "@user_percentile_#{metric.to_s}" ) == nil && instance_variable_get( "@user_total_reports_#{metric.to_s}" ) == nil
      reports_lower      = 0
      user_percentile    = 0
      user_total_reports = 0

      current_user.user_reports.each do |report|

        if report.level == 'advanced' && report.type == report_type

          # unpack questionnaire model from report
          questionnaire = report.unpack_questionnaire

          # check that report is complete
          if questionnaire.complete?

            if value_for_advanced_metric( questionnaire.send( "#{metric.to_s}" ), currency ? questionnaire.currency : nil ) <= value_for_advanced_metric( @questionnaire.send( "#{metric.to_s}" ), currency ? @questionnaire.currency : nil )
              reports_lower = reports_lower + 1
            end

            # increment total to compute percentile
            user_total_reports = user_total_reports + 1

          end

        end

      end

      user_percentile = user_total_reports > 0 ? 100 * reports_lower / user_total_reports : nil

      # cache values into instance variables
      instance_variable_set( "@user_percentile_#{metric.to_s}", user_percentile )
      instance_variable_set( "@user_total_reports_#{metric.to_s}", user_total_reports )
    end

    [ instance_variable_get( "@user_percentile_#{metric.to_s}" ), instance_variable_get( "@user_total_reports_#{metric.to_s}" ) ]
  end

  def advanced_percentile_comparison_for_technology( metric, report_type, technology, currency = false )

    instance_variable_set( "@global_percentile_for_technology_#{metric.to_s}", {} )    unless instance_variable_get( "@global_percentile_for_technology_#{metric.to_s}" ) != nil
    instance_variable_set( "@global_total_reports_for_technology_#{metric.to_s}", {} ) unless instance_variable_get( "@global_total_reports_for_technology_#{metric.to_s}" ) != nil

    if instance_variable_get( "@global_percentile_for_technology_#{metric.to_s}" )[ technology ] == nil && instance_variable_get( "@global_total_reports_for_technology_#{metric.to_s}" )[ technology ] == nil
      reports_lower        = 0
      global_percentile    = 0
      global_total_reports = 0

      User.all.each do |user|
        user.user_reports.each do |report|

          if report.level == 'advanced' && report.type == report_type

            # unpack questionnaire model from report
            questionnaire = report.unpack_questionnaire

            # check that report is complete
            if questionnaire.complete? && questionnaire.supply_system_technologies.include?( technology )

              if value_for_advanced_metric( questionnaire.send( "#{metric.to_s}", technology ), currency ? questionnaire.currency : nil ) <= value_for_advanced_metric( @questionnaire.send( "#{metric.to_s}", technology ), currency ? @questionnaire.currency : nil )
                reports_lower = reports_lower + 1
              end

              # increment total to compute percentile
              global_total_reports = global_total_reports + 1

            end

          end

        end
      end

      global_percentile = global_total_reports > 0 ? 100 * reports_lower / global_total_reports : nil

      # cache values into instance variables
      instance_variable_get( "@global_percentile_for_technology_#{metric.to_s}" )[ technology ]    = global_percentile
      instance_variable_get( "@global_total_reports_for_technology_#{metric.to_s}" )[ technology ] = global_total_reports
    end

    [ instance_variable_get( "@global_percentile_for_technology_#{metric.to_s}" )[ technology ], instance_variable_get( "@global_total_reports_for_technology_#{metric.to_s}" )[ technology ] ]
  end

  def advanced_percentile_comparison_for_user_for_technology( metric, report_type, technology, currency = false )

    instance_variable_set( "@user_percentile_for_technology_#{metric.to_s}", {} )    unless instance_variable_get( "@user_percentile_for_technology_#{metric.to_s}" ) != nil
    instance_variable_set( "@user_total_reports_for_technology_#{metric.to_s}", {} ) unless instance_variable_get( "@user_total_reports_for_technology_#{metric.to_s}" ) != nil

    if instance_variable_get( "@user_percentile_for_technology_#{metric.to_s}" )[ technology ] == nil && instance_variable_get( "@user_total_reports_for_technology_#{metric.to_s}" )[ technology ] == nil
      reports_lower      = 0
      user_percentile    = 0
      user_total_reports = 0

      current_user.user_reports.each do |report|

        if report.level == 'advanced' && report.type == report_type

          # unpack questionnaire model from report
          questionnaire = report.unpack_questionnaire

          # check that report is complete
          if questionnaire.complete? && questionnaire.supply_system_technologies.include?( technology )

            if value_for_advanced_metric( questionnaire.send( "#{metric.to_s}", technology ), currency ? questionnaire.currency : nil ) <= value_for_advanced_metric( @questionnaire.send( "#{metric.to_s}", technology ), currency ? @questionnaire.currency : nil )
              reports_lower = reports_lower + 1
            end

            # increment total to compute percentile
            user_total_reports = user_total_reports + 1

          end

        end

      end

      user_percentile = user_total_reports > 0 ? 100 * reports_lower / user_total_reports : nil

      # cache values into instance variables
      instance_variable_get( "@user_percentile_for_technology_#{metric.to_s}" )[ technology ]    = user_percentile
      instance_variable_get( "@user_total_reports_for_technology_#{metric.to_s}" )[ technology ] = user_total_reports
    end

    [ instance_variable_get( "@user_percentile_for_technology_#{metric.to_s}" )[ technology ], instance_variable_get( "@user_total_reports_for_technology_#{metric.to_s}" )[ technology ] ]
  end

  def value_for_advanced_metric( metric_value, currency )
    if currency != nil
      er = ExchangeRate.where( :name => currency.upcase, :year => 2011 )

      if er != nil && er.count
        currency == true ? er[0].rate * metric_value : metric_value
      else
        0
      end
    else
      metric_value
    end
  end

end
