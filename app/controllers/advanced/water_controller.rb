class Advanced::WaterController < ApplicationController

  layout "tool"

  authorize_resource :class => Advanced::WaterController


  def context
    @questionnaire = AdvancedWaterQuestionnaire.new( session )
  end

end
