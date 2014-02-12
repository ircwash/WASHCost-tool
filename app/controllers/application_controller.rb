class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :set_locale


  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = t(:register_if_acces_to_cuesstinaire_view)
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
    I18n.locale = params[ :locale ] || I18n.default_locale
  end

end
