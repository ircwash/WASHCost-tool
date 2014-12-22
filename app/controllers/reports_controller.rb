class ReportsController < ApplicationController
  
  before_filter :store_location
  load_and_authorize_resource UserReport, :only => [ :destroy, :load, :update ]

  def destroy
    report = Report.find( params[ :id ] )
    if report == nil
      report = (current_user != nil) ? current_user.user_reports.find( params[ :id ] ) : nil
    end
    if report != nil
      report.destroy
      redirect_to dashboard_index_path( I18n.locale )
    end
  end

  def load
    report = Report.find( params[ :id ] )
    if report == nil
      report = (current_user != nil) ? current_user.user_reports.find( params[ :id ] ) : nil
    end
    if report != nil
      if report.level == 'basic'
        if report.type == 'water'
          questionnaire = BasicWaterQuestionnaire.new( session )

          questionnaire.update_attributes( report.questionnaire )

          redirect_to basic_water_report_path(I18n.locale)
        elsif report.type == 'sanitation'
          questionnaire = BasicSanitationQuestionnaire.new( session )

          questionnaire.update_attributes( report.questionnaire )

          redirect_to basic_sanitation_report_path(I18n.locale)
        else
          raise ActionController::RoutingError.new('Not Found')
        end
      elsif report.level == 'advanced'
        if report.type == 'water'
          questionnaire = AdvancedWaterQuestionnaire.new( session )

          questionnaire.update_attributes( report.questionnaire )

          redirect_to advanced_water_report_path(I18n.locale)
        elsif report.type == 'sanitation'
          questionnaire = AdvancedSanitationQuestionnaire.new( session )

          questionnaire.update_attributes( report.questionnaire )

          redirect_to advanced_sanitation_report_path(I18n.locale)
        else
          raise ActionController::RoutingError.new('Not Found')
        end
      else
        raise ActionController::RoutingError.new('Not Found')
      end
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def update
    if params[ :user_report ].present? && params[ :user_report ][ :id ].present?
      report = current_user.user_reports.find( params[ :user_report ][ :id ] )
      if report != nil && report[ :type ] == 'sanitation'
        questionnaire = AdvancedSanitationQuestionnaire.new( session )
        updated_quest = report.questionnaire
        updated_quest[ :status ] = params[ :user_report ][ :status ]
        questionnaire.update_attributes( updated_quest )
      elsif report != nil
        questionnaire = AdvancedWaterQuestionnaire.new( session )
        updated_quest = report.questionnaire
        updated_quest[ :status ] = params[ :user_report ][ :status ]
        questionnaire.update_attributes( updated_quest )
      end
      report.update_attributes( params[ :user_report ] )
    end
    render json: {}
  end
  
  def store_location
    session[:previous_url] = request.fullpath
  end

end
