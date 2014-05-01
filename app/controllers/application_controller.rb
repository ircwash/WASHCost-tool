class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = t('errors.messages.register_if_acces_to_cuesstinaire_view')
    current_ability.can? exception.action.to_sym, exception.subject.new
    @path_to = current_ability.permission_denied[:location]
    session[:user_return_to] = request.referer
    case current_ability.permission_denied[:output_from]
    when 'xhr'
      render 'basic/reports/redirect'
    when 'http'
      redirect_to @path_to
    when 'popup'
      render 'basic/reports/open_popup'
    end
  end

  def set_locale
    def_lang = (current_user) ? current_user.prefered_language : nil
    I18n.locale = params[ :locale ] || def_lang || I18n.default_locale
  end

  def default_url_options(options={})
    { locale: I18n.locale }
  end

  private

  def after_sign_out_path_for(resource_or_scope)
    calculators_path( I18n.locale )
  end

  def doorkeeper_unauthorized_render_options
    { json: '{"status": "failure", "message":"401 Unauthorized"}' }
  end

end