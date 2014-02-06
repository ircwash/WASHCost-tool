class Basic::WaterController < CalculatorController

  layout 'tool_basic'

  authorize_resource :class => Basic::WaterController


  def begin
    @questionnaire = BasicWaterQuestionnaire.new( session )
    @questionnaire.reset
puts "DFLSJDFLSKJFLKSDF"
    redirect_to basic_water_action_path( :country )
  end

  def questionnaire
    @questionnaire = BasicWaterQuestionnaire.new( session )

    render params[ :section ]
  end

  def update
    @questionnaire = BasicWaterQuestionnaire.new( session )

    # save updated questionnaire
    @questionnaire.update_attributes( params[ :basic_water_questionnaire ] )

    redirect_to basic_water_action_path( I18n.locale, params[ :section ] )
  end

  def dynamic_update
    @questionnaire = BasicWaterQuestionnaire.new( session )

    # save updated questionnaire
    @questionnaire.update_attributes( params[ :basic_water_questionnaire ] )

    render json: { :progress => @questionnaire.complete }
  end

  def report
    @questionnaire = BasicWaterQuestionnaire.new( session )

    render layout: 'report'
  end

  def save_report
    @report = Report.new

    render layout: 'general', template: 'shared/save_report'
  end

  def store_report
    super( params[ :report ][ :title ], 'basic', 'water', BasicWaterQuestionnaire.new( session ).attributes )
  end

end
