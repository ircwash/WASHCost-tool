class Basic::WaterController < CalculatorController

  layout 'tool_basic'

  load_and_authorize_resource UserReport, :only => [ :save_report, :store_report ]


  def begin
    @questionnaire = BasicWaterQuestionnaire.new( session )
    @questionnaire.reset

    redirect_to basic_water_action_path( I18n.locale, :country )
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
    @report = UserReport.new

    render layout: 'general', template: 'shared/save_report'
  end

  def share_report
    @report = Report.create( :level => 'basic', :type => 'water', :questionnaire => BasicWaterQuestionnaire.new( session ).attributes )
    @report.save
    @back_path = basic_water_report_path( I18n.locale )

    render layout: 'general', template: 'shared/share_report'
  end

  def store_report
    super( params[ :user_report ][ :title ], 'basic', 'water', BasicWaterQuestionnaire.new( session ).attributes )
  end

end
