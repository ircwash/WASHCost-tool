class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :set_locale
  before_filter :init_vars

  @@pages= nil

  def pages
    return @@pages
  end

  def init_vars
  end

  def set_locale
    I18n.locale = session[:lang] if session[:lang].present?
    I18n.locale = params[:lang] if params[:lang].present?

    if(params[:lang].present?)
      session[:lang]= params[:lang]
    end
  end

  def is_valid_country_code(country_code)
    valid= false

    if country_code && country_code.length == 3
      valid= true
    end

    return valid
  end

  def add_to_session_form(key, value)
    form= session[:water_basic_form].present? ? session[:water_basic_form] : Hash.new(0)
    form[key]= value

    session[:water_basic_form]= form
  end

  def increase_pages_complete

    pages_complete= session[:pages_complete].present? ? session[:pages_complete] : 0
    pages_complete+= 1;
    session[:pages_complete] =  pages_complete

  end



  def is_number(string)
    true if Integer(string) rescue false
  end

end
