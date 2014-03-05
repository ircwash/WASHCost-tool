class CalculatorsController < ApplicationController

  layout "general"

  def index

  end

  def selection
    level = params[ :tool_level ] || 'basic'
    case level
      when 'basic'
        case params[ :tool_name ]
          when 'water'
            redirect_to basic_water_begin_path( I18n.locale )
          when 'sanitation'
            redirect_to basic_sanitation_begin_path( I18n.locale )
        end
      when 'advanced'
        case params[ :tool_name ]
          when 'water'
            redirect_to advanced_water_begin_path( I18n.locale )
          when 'sanitation'
            redirect_to advanced_sanitation_begin_path( I18n.locale )
        end
    end
  end

end
