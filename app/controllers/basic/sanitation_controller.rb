class Basic::SanitationController < CalculatorController

  layout 'tool_basic'

  load_and_authorize_resource UserReport, :only => [ :save_report, :store_report ]


  def begin
    @questionnaire = BasicSanitationQuestionnaire.new( session )
    @questionnaire.reset

    redirect_to basic_sanitation_action_path( I18n.locale, :country )
  end

  def questionnaire
    @questionnaire = BasicSanitationQuestionnaire.new( session )

    render params[ :section ]
  end

  def update
    @questionnaire = BasicSanitationQuestionnaire.new( session )

    # save updated questionnaire
    @questionnaire.update_attributes( params[ :basic_sanitation_questionnaire ] )

    redirect_to basic_sanitation_action_path( I18n.locale, params[ :section ] )
  end

  def dynamic_update
    @questionnaire = BasicSanitationQuestionnaire.new( session )

    # save updated questionnaire
    @questionnaire.update_attributes( params[ :basic_sanitation_questionnaire ] )

    render json: { :progress => @questionnaire.complete }
  end

  def report
    @questionnaire = BasicSanitationQuestionnaire.new( session )

    render layout: 'report'
  end

  def save_report
    @report = UserReport.new

    render layout: 'general', template: 'shared/save_report'
  end

  def share_report
    @report = Report.create( :level => 'basic', :type => 'sanitation', :questionnaire => BasicSanitationQuestionnaire.new( session ).attributes )
    @report.save
    @back_path = basic_sanitation_report_path( I18n.locale )

    render layout: 'general', template: 'shared/share_report'
  end

  def store_report
    super( params[ :user_report ][ :title ], 'basic', session[:advanced_sanitation][:status], 'sanitation', BasicSanitationQuestionnaire.new( session ).attributes )
  end

end
