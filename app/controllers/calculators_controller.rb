class CalculatorsController < ApplicationController

  layout "general"

  def index

  end

  def selection

    case params[ :tool_level ]
      when 'basic'
        case params[ :tool_name ]
          when 'water'
            session[:water_basic_form] = {}
            session[:water_basic_complete] = {}

            redirect_to basic_water_path( I18n.locale )
          when 'sanitation'
            session[:sanitation_basic_form] = {}
            session[:sanitation_basic_complete] = {}

            redirect_to basic_sanitation_path( I18n.locale )
        end
      when 'advanced'
        case params[ :tool_name ]
          when 'water'
            redirect_to advanced_water_path( I18n.locale )
          when 'sanitation'

        end
    end
  end

end
