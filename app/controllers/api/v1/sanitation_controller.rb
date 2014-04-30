class Api::V1::SanitationController < Api::V1::BaseController
  doorkeeper_for :all

  respond_to :json

  def create
    questionnaire = AdvancedSanitationQuestionnaire.new( session )

    unless params.has_key?(:title)
      render :json => { error: "Missing report title", status: 403 }, :status => :forbidden
      return
    end

    unless params.has_key?(:advanced_sanitation_questionnaire)
      render :json => { error: "Missing sanitation questionaire input", status: 403 }, :status => :forbidden
      return
    end

    find_by_title = current_user.user_reports.where(level: "advanced", title: params[:title]).first

    unless find_by_title.nil?
      render :json => { error: "Duplicate title, use the '/api/sanitation/update/:id' endpoint to make changes", status: 403 }, :status => :forbidden
      return
    end

    questionnaire.update_attributes(params[:advanced_sanitation_questionnaire])

    current_user.user_reports << UserReport.new(
      :title => params[:title],
      :type  => 'sanitation',
      :level => 'advanced',
      :questionnaire => questionnaire.attributes
    )

    render json: questionnaire

  end

  def update
    questionnaire = AdvancedSanitationQuestionnaire.new( session )

    unless params.has_key?(:id)
      render :json => { error: "Missing report id", status: 403 }, :status => :forbidden
      return
    end

    find_by_title = current_user.user_reports.where(level: "advanced", title: params[:title]).first

    unless find_by_title.nil?
      if params.has_key?(:title) && find_by_title.id.to_s != params[:id]
        render :json => { error: "Duplicate title, ", status: 403 }, :status => :forbidden
        return
      end
    end

    user_report = current_user.user_reports.where(level: "advanced", id: params[:id]).first

    if params.has_key?(:title)
      user_report.title = params[:title]
    end

    if params.has_key?(:advanced_sanitation_questionnaire)
      questionnaire.update_attributes(params[:advanced_sanitation_questionnaire])
      user_report.questionnaire = questionnaire.attributes
    end

    user_report.save!
    
    render json: user_report.questionnaire
    
  end

end