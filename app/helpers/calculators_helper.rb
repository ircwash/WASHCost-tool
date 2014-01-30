module CalculatorsHelper

  def footer_report_url
    case controller_path
      when 'basic/water'
        basic_water_report_path( I18n.locale )
      when 'basic/sanitation'
        basic_sanitation_report_path( I18n.locale )
      when 'advanced/water'
        advanced_water_report_path( I18n.locale )
      else
        ''
    end
  end

end