class Advanced::WaterController < ApplicationController

  layout "tool"

  authorize_resource :class => Advanced::WaterController


  def context
    @questionnaire = AdvancedWaterQuestionnaire.new( session )
  end

  def update
    @questionnaire = AdvancedWaterQuestionnaire.new( session )

    # save updated questionnaire
    @questionnaire.update_attributes( params[ :advanced_water_questionnaire ] )

    redirect_to advanced_water_action_path( I18n.locale, 'context' )
  end

end
