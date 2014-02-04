class Advanced::WaterController < CalculatorController

  layout 'tool_advanced'

  authorize_resource :class => Advanced::WaterController


  def begin
    @questionnaire = AdvancedWaterQuestionnaire.new( session )
    @questionnaire.reset

    redirect_to advanced_water_action_path( :service_area )
  end

  def questionnaire
    @questionnaire = AdvancedWaterQuestionnaire.new( session )

    render params[ :section ]
  end

  def update
    @questionnaire = AdvancedWaterQuestionnaire.new( session )

    # save updated questionnaire
    @questionnaire.update_attributes( params[ :advanced_water_questionnaire ] )

    redirect_to advanced_water_action_path( I18n.locale, params[ :section ] )
  end

  def dynamic_update
    @questionnaire = AdvancedWaterQuestionnaire.new( session )

    # save updated questionnaire
    @questionnaire.update_attributes( params[ :advanced_water_questionnaire ] )

    render json: { :progress => @questionnaire.complete }
  end

  def report
    @questionnaire = AdvancedWaterQuestionnaire.new( session )

    render layout: 'report'
  end

end
