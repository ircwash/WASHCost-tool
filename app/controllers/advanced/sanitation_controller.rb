class Advanced::SanitationController < CalculatorController

  include ApplicationHelper

  layout 'tool_advanced'


  authorize_resource :class => Advanced::SanitationController
  load_and_authorize_resource UserReport, :only => [ :save_report, :store_report ]


  def begin
    @questionnaire = AdvancedSanitationQuestionnaire.new( session )
    @questionnaire.reset

    redirect_to advanced_sanitation_action_path( I18n.locale, :service_area, :start => true )
  end

  def questionnaire
    if params[ :start ] != nil
      session[:advanced_sanitation][:currency] = nil
      session[:advanced_sanitation][:country] = nil
      session[:advanced_sanitation][:status] = nil
      session[:advanced_sanitation][:year_of_expenditure] = nil
    end
    @questionnaire = AdvancedSanitationQuestionnaire.new( session )

    render params[ :section ]
  end

  def update
    @questionnaire = AdvancedSanitationQuestionnaire.new( session )

    # save updated questionnaire
    @questionnaire.update_attributes( params[ :advanced_sanitation_questionnaire ] )

    redirect_to advanced_sanitation_action_path( I18n.locale, params[ :section ] )
  end

  def dynamic_update
    @questionnaire = AdvancedSanitationQuestionnaire.new( session )

    # save updated questionnaire
    @questionnaire.update_attributes( params[ :advanced_sanitation_questionnaire ] )

    render json: { :progress => @questionnaire.complete }
  end

  def report
    @questionnaire = AdvancedSanitationQuestionnaire.new( session )

    render layout: 'report'
  end

  def save_report
    @report = UserReport.new

    render layout: 'general', template: 'shared/save_report'
  end

  def share_report
    @report = Report.create( :level => 'advanced', :type => 'sanitation', :questionnaire => AdvancedSanitationQuestionnaire.new( session ).attributes )
    @back_path = advanced_sanitation_report_path( I18n.locale )

    render layout: 'general', template: 'shared/share_report'
  end

  def store_report

    questionnaire = AdvancedSanitationQuestionnaire.new( session ).attributes

    cepp = final_usd_2011(questionnaire, capital_expenditure_per_person(questionnaire)).to_s
    repppy = final_usd_2011(questionnaire, recurrent_expenditure_per_person_per_year(questionnaire, 30)).to_s
    poptman = percentage_of_population_that_meets_all_norms_sanitation(questionnaire).to_s

    super( params[ :user_report ][ :title ], 'advanced', session[:advanced_sanitation][:status], 'sanitation', questionnaire, cepp, repppy, poptman )
  end

end
