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

  def report_currency_value_for( value, precision = 2 )
    value != nil ? "#{( @questionnaire.currency || '' ).upcase} #{number_with_precision( value.to_f, :precision => precision )}" : t( 'report.no_data' )
  end

  def report_delta_currency_value_for( value, precision = 2 )
    value != nil ? "#{( @questionnaire.currency || '' ).upcase} #{number_with_precision( value.to_f.abs, :precision => precision )} #{value.to_f > 0 ? t( 'report.surplus' ) : t( 'report.shortfall' )}" : t( 'report.no_data' )
  end

  def report_percentage_value_for( value )
    value != nil ? "#{value.to_f.round(1)}%" : t( 'report.no_data' )
  end

  def report_integer_percentage_value_for( value )
    value != nil ? "#{value.to_i}%" : '-'
  end


  # cumulative expenditure outputs

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

  # cumulative service level outputs

  def global_service_accessibility_percentile( report_type )
    if @global_service_accessibility_percentile == nil && @global_service_accessibility_total_reports == nil
      services_with_lower_accessibility           = 0
      @global_service_accessibility_percentile    = 0
      @global_service_accessibility_total_reports = 0

      User.all.each do |user|
        user.reports.each do |report|
          if report.level == 'advanced' && report.type == report_type

            # unpack questionnaire model from report
            questionnaire = report.unpack_questionnaire

            # check that report is complete
            if questionnaire.complete?

              if questionnaire.percentage_of_population_that_meets_accessibility_norms <= @questionnaire.percentage_of_population_that_meets_accessibility_norms
                services_with_lower_accessibility = services_with_lower_accessibility + 1
              end

              # increment total to compute percentile
              @global_service_accessibility_total_reports = @global_service_accessibility_total_reports + 1
            end
          end
        end
      end

      @global_service_accessibility_percentile = @global_service_accessibility_total_reports > 0 ? 100 * services_with_lower_accessibility    / @global_service_accessibility_total_reports : '-'
    end

    [ @global_service_accessibility_percentile, @global_service_accessibility_total_reports ]
  end

  def user_service_accessibility_percentile( report_type )
    if @user_service_accessibility_percentile == nil && @user_service_accessibility_total_reports == nil
      services_with_lower_accessibility         = 0
      @user_service_accessibility_percentile    = 0
      @user_service_accessibility_total_reports = 0

      current_user.reports.each do |report|
        if report.level == 'advanced' && report.type == report_type

          # unpack questionnaire model from report
          questionnaire = report.unpack_questionnaire

          # check that report is complete
          if questionnaire.complete?

            if questionnaire.percentage_of_population_that_meets_accessibility_norms <= @questionnaire.percentage_of_population_that_meets_accessibility_norms
              services_with_lower_accessibility = services_with_lower_accessibility + 1
            end

            # increment total to compute percentile
            @user_service_accessibility_total_reports = @user_service_accessibility_total_reports + 1
          end
        end
      end

      @user_service_accessibility_percentile = @user_service_accessibility_total_reports > 0 ? 100 * services_with_lower_accessibility / @user_service_accessibility_total_reports : '-'
    end

    [ @user_service_accessibility_percentile, @user_service_accessibility_total_reports ]
  end

  def global_service_use_percentile( report_type )
    if @global_service_use_percentile == nil && @global_service_use_total_reports == nil
      services_with_lower_use           = 0
      @global_service_use_percentile    = 0
      @global_service_use_total_reports = 0

      User.all.each do |user|
        user.reports.each do |report|
          if report.level == 'advanced' && report.type == report_type

            # unpack questionnaire model from report
            questionnaire = report.unpack_questionnaire

            # check that report is complete
            if questionnaire.complete?

              if questionnaire.percentage_of_population_that_meets_use_norms <= @questionnaire.percentage_of_population_that_meets_use_norms
                services_with_lower_use = services_with_lower_use + 1
              end

              # increment total to compute percentile
              @global_service_use_total_reports = @global_service_use_total_reports + 1
            end
          end
        end
      end

      @global_service_use_percentile = @global_service_use_total_reports > 0 ? 100 * services_with_lower_use    / @global_service_use_total_reports : '-'
    end

    [ @global_service_use_percentile, @global_service_use_total_reports ]
  end

  def user_service_use_percentile( report_type )
    if @user_service_use_percentile == nil && @user_service_use_total_reports == nil
      services_with_lower_use         = 0
      @user_service_use_percentile    = 0
      @user_service_use_total_reports = 0

      current_user.reports.each do |report|
        if report.level == 'advanced' && report.type == report_type

          # unpack questionnaire model from report
          questionnaire = report.unpack_questionnaire

          # check that report is complete
          if questionnaire.complete?

            if questionnaire.percentage_of_population_that_meets_use_norms <= @questionnaire.percentage_of_population_that_meets_use_norms
              services_with_lower_use = services_with_lower_use + 1
            end

            # increment total to compute percentile
            @user_service_use_total_reports = @user_service_use_total_reports + 1
          end
        end
      end

      @user_service_use_percentile = @user_service_use_total_reports > 0 ? 100 * services_with_lower_use / @user_service_use_total_reports : '-'
    end

    [ @user_service_use_percentile, @user_service_use_total_reports ]
  end

  def global_service_reliability_percentile( report_type )
    if @global_service_reliability_percentile == nil && @global_service_reliability_total_reports == nil
      services_with_lower_reliability           = 0
      @global_service_reliability_percentile    = 0
      @global_service_reliability_total_reports = 0

      User.all.each do |user|
        user.reports.each do |report|
          if report.level == 'advanced' && report.type == report_type

            # unpack questionnaire model from report
            questionnaire = report.unpack_questionnaire

            # check that report is complete
            if questionnaire.complete?

              if questionnaire.percentage_of_population_that_meets_reliability_norms <= @questionnaire.percentage_of_population_that_meets_reliability_norms
                services_with_lower_reliability = services_with_lower_reliability + 1
              end

              # increment total to compute percentile
              @global_service_reliability_total_reports = @global_service_reliability_total_reports + 1
            end
          end
        end
      end

      @global_service_reliability_percentile = @global_service_reliability_total_reports > 0 ? 100 * services_with_lower_reliability    / @global_service_reliability_total_reports : '-'
    end

    [ @global_service_reliability_percentile, @global_service_reliability_total_reports ]
  end

  def user_service_reliability_percentile( report_type )
    if @user_service_reliability_percentile == nil && @user_service_reliability_total_reports == nil
      services_with_lower_reliability         = 0
      @user_service_reliability_percentile    = 0
      @user_service_reliability_total_reports = 0

      current_user.reports.each do |report|
        if report.level == 'advanced' && report.type == report_type

          # unpack questionnaire model from report
          questionnaire = report.unpack_questionnaire

          # check that report is complete
          if questionnaire.complete?

            if questionnaire.percentage_of_population_that_meets_reliability_norms <= @questionnaire.percentage_of_population_that_meets_reliability_norms
              services_with_lower_reliability = services_with_lower_reliability + 1
            end

            # increment total to compute percentile
            @user_service_reliability_total_reports = @user_service_reliability_total_reports + 1
          end
        end
      end

      @user_service_reliability_percentile = @user_service_reliability_total_reports > 0 ? 100 * services_with_lower_reliability / @user_service_reliability_total_reports : '-'
    end

    [ @user_service_reliability_percentile, @user_service_reliability_total_reports ]
  end

  def global_service_environmental_protection_percentile( report_type )
    if @global_service_environmental_protection_percentile == nil && @global_service_environmental_protection_total_reports == nil
      services_with_lower_environmental_protection           = 0
      @global_service_environmental_protection_percentile    = 0
      @global_service_environmental_protection_total_reports = 0

      User.all.each do |user|
        user.reports.each do |report|
          if report.level == 'advanced' && report.type == report_type

            # unpack questionnaire model from report
            questionnaire = report.unpack_questionnaire

            # check that report is complete
            if questionnaire.complete?

              if questionnaire.percentage_of_population_that_meets_environmental_protection_norms <= @questionnaire.percentage_of_population_that_meets_environmental_protection_norms
                services_with_lower_environmental_protection = services_with_lower_environmental_protection + 1
              end

              # increment total to compute percentile
              @global_service_environmental_protection_total_reports = @global_service_environmental_protection_total_reports + 1
            end
          end
        end
      end

      @global_service_environmental_protection_percentile = @global_service_environmental_protection_total_reports > 0 ? 100 * services_with_lower_environmental_protection    / @global_service_environmental_protection_total_reports : '-'
    end

    [ @global_service_environmental_protection_percentile, @global_service_environmental_protection_total_reports ]
  end

  def user_service_environmental_protection_percentile( report_type )
    if @user_service_environmental_protection_percentile == nil && @user_service_environmental_protection_total_reports == nil
      services_with_lower_environmental_protection         = 0
      @user_service_environmental_protection_percentile    = 0
      @user_service_environmental_protection_total_reports = 0

      current_user.reports.each do |report|
        if report.level == 'advanced' && report.type == report_type

          # unpack questionnaire model from report
          questionnaire = report.unpack_questionnaire

          # check that report is complete
          if questionnaire.complete?

            if questionnaire.percentage_of_population_that_meets_environmental_protection_norms <= @questionnaire.percentage_of_population_that_meets_environmental_protection_norms
              services_with_lower_environmental_protection = services_with_lower_environmental_protection + 1
            end

            # increment total to compute percentile
            @user_service_environmental_protection_total_reports = @user_service_environmental_protection_total_reports + 1
          end
        end
      end

      @user_service_environmental_protection_percentile = @user_service_environmental_protection_total_reports > 0 ? 100 * services_with_lower_environmental_protection / @user_service_environmental_protection_total_reports : '-'
    end

    [ @user_service_environmental_protection_percentile, @user_service_environmental_protection_total_reports ]
  end

  def global_service_quantity_percentile( report_type )
    if @global_service_quantity_percentile == nil && @global_service_quantity_total_reports == nil
      services_with_lower_quantity           = 0
      @global_service_quantity_percentile    = 0
      @global_service_quantity_total_reports = 0

      User.all.each do |user|
        user.reports.each do |report|
          if report.level == 'advanced' && report.type == report_type

            # unpack questionnaire model from report
            questionnaire = report.unpack_questionnaire

            # check that report is complete
            if questionnaire.complete?

              if questionnaire.percentage_of_population_that_meets_quantity_norms <= @questionnaire.percentage_of_population_that_meets_quantity_norms
                services_with_lower_quantity = services_with_lower_quantity + 1
              end

              # increment total to compute percentile
              @global_service_quantity_total_reports = @global_service_quantity_total_reports + 1
            end
          end
        end
      end

      @global_service_quantity_percentile = @global_service_quantity_total_reports > 0 ? 100 * services_with_lower_quantity    / @global_service_quantity_total_reports : '-'
    end

    [ @global_service_quantity_percentile, @global_service_quantity_total_reports ]
  end

  def user_service_quantity_percentile( report_type )
    if @user_service_quantity_percentile == nil && @user_service_quantity_total_reports == nil
      services_with_lower_quantity         = 0
      @user_service_quantity_percentile    = 0
      @user_service_quantity_total_reports = 0

      current_user.reports.each do |report|
        if report.level == 'advanced' && report.type == report_type

          # unpack questionnaire model from report
          questionnaire = report.unpack_questionnaire

          # check that report is complete
          if questionnaire.complete?

            if questionnaire.percentage_of_population_that_meets_quantity_norms <= @questionnaire.percentage_of_population_that_meets_quantity_norms
              services_with_lower_quantity = services_with_lower_quantity + 1
            end

            # increment total to compute percentile
            @user_service_quantity_total_reports = @user_service_quantity_total_reports + 1
          end
        end
      end

      @user_service_quantity_percentile = @user_service_quantity_total_reports > 0 ? 100 * services_with_lower_quantity / @user_service_quantity_total_reports : '-'
    end

    [ @user_service_quantity_percentile, @user_service_quantity_total_reports ]
  end

  def global_service_quality_percentile( report_type )
    if @global_service_quality_percentile == nil && @global_service_quality_total_reports == nil
      services_with_lower_quality           = 0
      @global_service_quality_percentile    = 0
      @global_service_quality_total_reports = 0

      User.all.each do |user|
        user.reports.each do |report|
          if report.level == 'advanced' && report.type == report_type

            # unpack questionnaire model from report
            questionnaire = report.unpack_questionnaire

            # check that report is complete
            if questionnaire.complete?

              if questionnaire.percentage_of_population_that_meets_quality_norms <= @questionnaire.percentage_of_population_that_meets_quality_norms
                services_with_lower_quality = services_with_lower_quality + 1
              end

              # increment total to compute percentile
              @global_service_quality_total_reports = @global_service_quality_total_reports + 1
            end
          end
        end
      end

      @global_service_quality_percentile = @global_service_quality_total_reports > 0 ? 100 * services_with_lower_quality    / @global_service_quality_total_reports : '-'
    end

    [ @global_service_quality_percentile, @global_service_quality_total_reports ]
  end

  def user_service_quality_percentile( report_type )
    if @user_service_quality_percentile == nil && @user_service_quality_total_reports == nil
      services_with_lower_quality         = 0
      @user_service_quality_percentile    = 0
      @user_service_quality_total_reports = 0

      current_user.reports.each do |report|
        if report.level == 'advanced' && report.type == report_type

          # unpack questionnaire model from report
          questionnaire = report.unpack_questionnaire

          # check that report is complete
          if questionnaire.complete?

            if questionnaire.percentage_of_population_that_meets_quality_norms <= @questionnaire.percentage_of_population_that_meets_quality_norms
              services_with_lower_quality = services_with_lower_quality + 1
            end

            # increment total to compute percentile
            @user_service_quality_total_reports = @user_service_quality_total_reports + 1
          end
        end
      end

      @user_service_quality_percentile = @user_service_quality_total_reports > 0 ? 100 * services_with_lower_quality / @user_service_quality_total_reports : '-'
    end

    [ @user_service_quality_percentile, @user_service_quality_total_reports ]
  end

  def global_aggregate_service_percentile( report_type )
    if @global_service_quality_percentile == nil && @global_service_quality_total_reports == nil
      services_with_lower_quality           = 0
      @global_service_quality_percentile    = 0
      @global_service_quality_total_reports = 0

      User.all.each do |user|
        user.reports.each do |report|
          if report.level == 'advanced' && report.type == report_type

            # unpack questionnaire model from report
            questionnaire = report.unpack_questionnaire

            # check that report is complete
            if questionnaire.complete? && @questionnaire.percentage_of_population_that_meets_all_norms != nil

              if questionnaire.percentage_of_population_that_meets_all_norms <= @questionnaire.percentage_of_population_that_meets_all_norms
                services_with_lower_quality = services_with_lower_quality + 1
              end

              # increment total to compute percentile
              @global_service_quality_total_reports = @global_service_quality_total_reports + 1
            end
          end
        end
      end

      @global_service_quality_percentile = @global_service_quality_total_reports > 0 ? 100 - 100 * services_with_lower_quality / @global_service_quality_total_reports : nil
    end

    @global_service_quality_percentile
  end

end
