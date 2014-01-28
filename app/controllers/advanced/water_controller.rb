class Advanced::WaterController < ApplicationController

  layout "tool_advanced"

  authorize_resource :class => Advanced::WaterController


  def context
    @questionnaire = AdvancedWaterQuestionnaire.new( session )
  end

  def system_management
    @questionnaire = AdvancedWaterQuestionnaire.new( session )
  end

  def system_characteristics
    @questionnaire = AdvancedWaterQuestionnaire.new( session )
  end

  def update
    @questionnaire = AdvancedWaterQuestionnaire.new( session )

    # save updated questionnaire
    @questionnaire.update_attributes( params[ :advanced_water_questionnaire ] )

    redirect_to advanced_water_action_path( I18n.locale, params[ :section ] )
  end

end
