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
    if @global_capital_expenditure_percentile == nil && @global_capital_total_reports == nil
      global_reports_with_lower_expenditure = 0
      @global_capital_expenditure_percentile        = 0
      @global_capital_total_reports                 = 0

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
              @global_capital_total_reports = @global_capital_total_reports + 1

            end

          end

        end
      end

      @global_capital_expenditure_percentile = @global_capital_total_reports > 0 ? 100 * global_reports_with_lower_expenditure / @global_capital_total_reports : '-'
    end

    [ @global_capital_expenditure_percentile, @global_capital_total_reports ]
  end

  def user_capital_expenditure_percentile( report_type )
    if @user_capital_expenditure_percentile == nil && @user_capital_total_reports == nil
      user_reports_with_lower_expenditure = 0
      @user_capital_expenditure_percentile        = 0
      @user_capital_total_reports                 = 0

      current_user.reports.each do |report|

        if report.level == 'advanced' && report.type == report_type

          # unpack questionnaire model from report
          questionnaire = report.unpack_questionnaire

          # check that report is complete
          if questionnaire.complete?

            if questionnaire.total_service_area_capital_expenditure <= @questionnaire.total_service_area_capital_expenditure
              user_reports_with_lower_expenditure = user_reports_with_lower_expenditure + 1
            end

            # increment total to compute percentile
            @user_capital_total_reports = @user_capital_total_reports + 1

          end

        end

      end

      @user_capital_expenditure_percentile = @user_capital_total_reports > 0 ? 100 * user_reports_with_lower_expenditure / @user_capital_total_reports : '-'
    end

    [ @user_capital_expenditure_percentile, @user_capital_total_reports ]
  end

  def global_recurrent_expenditure_percentile( report_type )
    if @global_recurrent_expenditure_percentile == nil && @global_recurrent_total_reports == nil
      global_reports_with_lower_expenditure = 0
      @global_recurrent_expenditure_percentile        = 0
      @global_recurrent_total_reports                 = 0

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
              @global_recurrent_total_reports = @global_recurrent_total_reports + 1

            end

          end

        end
      end

      @global_recurrent_expenditure_percentile = @global_recurrent_total_reports > 0 ? 100 * global_reports_with_lower_expenditure / @global_recurrent_total_reports : '-'
    end

    [ @global_recurrent_expenditure_percentile, @global_recurrent_total_reports ]
  end

  def user_recurrent_expenditure_percentile( report_type )
    if @user_recurrent_expenditure_percentile == nil && @user_recurrent_total_reports == nil
      user_reports_with_lower_expenditure = 0
      @user_recurrent_expenditure_percentile        = 0
      @user_recurrent_total_reports                 = 0

      current_user.reports.each do |report|

        if report.level == 'advanced' && report.type == report_type

          # unpack questionnaire model from report
          questionnaire = report.unpack_questionnaire

          # check that report is complete
          if questionnaire.complete?

            if questionnaire.total_service_area_recurrent_expenditure <= @questionnaire.total_service_area_recurrent_expenditure
              user_reports_with_lower_expenditure = user_reports_with_lower_expenditure + 1
            end

            # increment total to compute percentile
            @user_recurrent_total_reports = @user_recurrent_total_reports + 1

          end

        end

      end

      @user_recurrent_expenditure_percentile = @user_recurrent_total_reports > 0 ? 100 * user_reports_with_lower_expenditure / @user_recurrent_total_reports : '-'
    end

    [ @user_recurrent_expenditure_percentile, @user_recurrent_total_reports ]
  end











  def global_technology_capital_expenditure_percentile( report_type, technology )
    @global_technology_capital_expenditure_percentile = {} unless @global_technology_capital_expenditure_percentile != nil
    @global_technology_capital_total_reports          = {} unless @global_technology_capital_total_reports != nil

    if @global_technology_capital_expenditure_percentile[ technology ] == nil && @global_technology_capital_total_reports[ technology ] == nil
      technology_reports_with_lower_expenditure                       = 0
      @global_technology_capital_expenditure_percentile[ technology ] = 0
      @global_technology_capital_total_reports[ technology ]          = 0

      User.all.each do |user|
        user.reports.each do |report|

          if report.level == 'advanced' && report.type == report_type

            # unpack questionnaire model from report
            questionnaire = report.unpack_questionnaire

            # check that report is complete
            if questionnaire.complete? && questionnaire.supply_system_technologies.include?( technology )

              if questionnaire.service_area_capital_expenditure_for_technology( technology ) <= @questionnaire.service_area_capital_expenditure_for_technology( technology )
                technology_reports_with_lower_expenditure = technology_reports_with_lower_expenditure + 1
              end

              # increment total to compute percentile
              @global_technology_capital_total_reports[ technology ] = @global_technology_capital_total_reports[ technology ] + 1

            end

          end

        end
      end

      @global_technology_capital_expenditure_percentile[ technology ] = @global_technology_capital_total_reports[ technology ] > 0 ? 100 * technology_reports_with_lower_expenditure / @global_technology_capital_total_reports[ technology ] : '-'
    end

    [ @global_technology_capital_expenditure_percentile[ technology ], @global_technology_capital_total_reports[ technology ] ]
  end

  def user_technology_capital_expenditure_percentile( report_type, technology )
    @user_technology_capital_expenditure_percentile = {} unless @user_technology_capital_expenditure_percentile != nil
    @user_technology_capital_total_reports          = {} unless @user_technology_capital_total_reports != nil

    if @user_technology_capital_expenditure_percentile[ technology ] == nil && @user_technology_capital_total_reports[ technology ] == nil
      user_reports_with_lower_expenditure                           = 0
      @user_technology_capital_expenditure_percentile[ technology ] = 0
      @user_technology_capital_total_reports[ technology ]          = 0

      current_user.reports.each do |report|

        if report.level == 'advanced' && report.type == report_type

          # unpack questionnaire model from report
          questionnaire = report.unpack_questionnaire

          # check that report is complete
          if questionnaire.complete? && questionnaire.supply_system_technologies.include?( technology )

            if questionnaire.service_area_capital_expenditure_for_technology( technology ) <= @questionnaire.service_area_capital_expenditure_for_technology( technology )
              user_reports_with_lower_expenditure = user_reports_with_lower_expenditure + 1
            end

            # increment total to compute percentile
            @user_technology_capital_total_reports[ technology ] = @user_technology_capital_total_reports[ technology ] + 1

          end

        end

      end

      @user_technology_capital_expenditure_percentile[ technology ] = @user_technology_capital_total_reports[ technology ] > 0 ? 100 * user_reports_with_lower_expenditure / @user_technology_capital_total_reports[ technology ] : '-'
    end

    [ @user_technology_capital_expenditure_percentile[ technology ], @user_technology_capital_total_reports[ technology ] ]
  end

  def global_technology_recurrent_expenditure_percentile( report_type, technology )
    @global_technology_recurrent_expenditure_percentile = {} unless @global_technology_recurrent_expenditure_percentile != nil
    @global_technology_recurrent_total_reports          = {} unless @global_technology_recurrent_total_reports != nil

    if @global_technology_recurrent_expenditure_percentile[ technology ] == nil && @global_technology_recurrent_total_reports[ technology ] == nil
      global_reports_with_lower_expenditure               = 0
      @global_technology_recurrent_expenditure_percentile[ technology ] = 0
      @global_technology_recurrent_total_reports[ technology ]          = 0

      User.all.each do |user|
        user.reports.each do |report|

          if report.level == 'advanced' && report.type == report_type

            # unpack questionnaire model from report
            questionnaire = report.unpack_questionnaire

            # check that report is complete
            if questionnaire.complete?

              if questionnaire.service_area_recurrent_expenditure_for_technology( technology ) <= @questionnaire.service_area_recurrent_expenditure_for_technology( technology )
                global_reports_with_lower_expenditure = global_reports_with_lower_expenditure + 1
              end

              # increment total to compute percentile
              @global_technology_recurrent_total_reports[ technology ] = @global_technology_recurrent_total_reports[ technology ] + 1

            end

          end

        end
      end

      @global_technology_recurrent_expenditure_percentile[ technology ] = @global_technology_recurrent_total_reports[ technology ] > 0 ? 100 * global_reports_with_lower_expenditure / @global_technology_recurrent_total_reports[ technology ] : '-'
    end

    [ @global_technology_recurrent_expenditure_percentile[ technology ], @global_technology_recurrent_total_reports[ technology ] ]
  end

  def user_technology_recurrent_expenditure_percentile( report_type, technology )
    @user_technology_recurrent_expenditure_percentile = {} unless @user_technology_recurrent_expenditure_percentile != nil
    @user_technology_recurrent_total_reports          = {} unless @user_technology_recurrent_total_reports != nil

    if @user_technology_recurrent_expenditure_percentile[ technology ] == nil && @user_technology_recurrent_total_reports[ technology ] == nil
      user_reports_with_lower_expenditure               = 0
      @user_technology_recurrent_expenditure_percentile[ technology ] = 0
      @user_technology_recurrent_total_reports[ technology ]          = 0

      current_user.reports.each do |report|

        if report.level == 'advanced' && report.type == report_type

          # unpack questionnaire model from report
          questionnaire = report.unpack_questionnaire

          # check that report is complete
          if questionnaire.complete?

            if questionnaire.service_area_recurrent_expenditure_for_technology( technology ) <= @questionnaire.service_area_recurrent_expenditure_for_technology( technology )
              user_reports_with_lower_expenditure = user_reports_with_lower_expenditure + 1
            end

            # increment total to compute percentile
            @user_technology_recurrent_total_reports[ technology ] = @user_technology_recurrent_total_reports[ technology ] + 1

          end

        end

      end

      @user_technology_recurrent_expenditure_percentile[ technology ] = @user_technology_recurrent_total_reports[ technology ] > 0 ? 100 * user_reports_with_lower_expenditure / @user_technology_recurrent_total_reports[ technology ] : '-'
    end

    [ @user_technology_recurrent_expenditure_percentile[ technology ], @user_technology_recurrent_total_reports[ technology ] ]
  end

end
