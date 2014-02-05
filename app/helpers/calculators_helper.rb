module CalculatorsHelper

  def footer_report_url
    case controller_path
      when 'basic/water'
        basic_water_report_path( I18n.locale )
      when 'basic/sanitation'
        basic_water_report_path( I18n.locale )
      when 'advanced/water'
        advanced_water_report_path( I18n.locale )
      when 'advanced/sanitation'
        advanced_sanitation_report_path( I18n.locale )
    end
  end

  def footer_save_report_url
    case controller_path
      when 'basic/water'
        basic_report_questionnaire_path( I18n.locale, :tool_name => 'water' )
      when 'basic/sanitation'
        basic_report_questionnaire_path( I18n.locale, :tool_name => 'sanitation' )
      when 'advanced/water'
        advanced_water_save_report_path( I18n.locale )
      when 'advanced/sanitation'
        advanced_sanitation_save_report_path( I18n.locale )
    end
  end

end