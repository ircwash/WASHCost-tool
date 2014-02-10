class Advanced::WaterController < CalculatorController

  layout 'tool_advanced'

  authorize_resource :class => Advanced::WaterController
  load_and_authorize_resource UserReport, :only => [ :save_report, :store_report ]


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

  def save_report
    @report = UserReport.new

    render layout: 'general', template: 'shared/save_report'
  end

  def share_report
    @report = Report.create( :level => 'advanced', :type => 'water', :questionnaire => AdvancedWaterQuestionnaire.new( session ).attributes )
    @back_path = advanced_water_report_path( I18n.locale )

    render layout: 'general', template: 'shared/share_report'
  end

  def store_report
    super( params[ :user_report ][ :title ], 'advanced', 'water', AdvancedWaterQuestionnaire.new( session ).attributes )
  end

end
