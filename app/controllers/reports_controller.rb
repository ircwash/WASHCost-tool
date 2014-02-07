class ReportsController < ApplicationController

  def load
    report = current_user.reports.find( params[ :id ] )

    if report != nil
      if report.level == 'basic'
        if report.type == 'water'
          questionnaire = BasicWaterQuestionnaire.new( session )

          questionnaire.update_attributes( report.questionnaire )

          redirect_to basic_water_report_path
        elsif report.type == 'sanitation'
          questionnaire = BasicSanitationQuestionnaire.new( session )

          questionnaire.update_attributes( report.questionnaire )

          redirect_to basic_sanitation_report_path
        end
      elsif report.level == 'advanced'
        if report.type == 'water'
          questionnaire = AdvancedWaterQuestionnaire.new( session )

          questionnaire.update_attributes( report.questionnaire )

          redirect_to advanced_water_report_path
        elsif report.type == 'sanitation'
          questionnaire = AdvancedSanitationQuestionnaire.new( session )

          questionnaire.update_attributes( report.questionnaire )

          redirect_to advanced_sanitation_report_path
        end
      end
    end
  end

end
