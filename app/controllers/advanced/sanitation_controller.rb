class Advanced::SanitationController < ApplicationController

  layout 'tool_advanced'

  authorize_resource :class => Advanced::SanitationController


  def begin
    @questionnaire = AdvancedSanitationQuestionnaire.new( session )
    @questionnaire.reset

    redirect_to advanced_sanitation_action_path( :context )
  end

  def questionnaire
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

end
