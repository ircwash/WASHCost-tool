class SanitationBasicController < ApplicationController
  layout "sanitation_basic_layout"

  before_filter :set_locale
  def set_locale
    I18n.locale = session[:lang] if session[:lang].present?
    I18n.locale = params[:lang] if params[:lang].present?

    if(params[:lang].present?)
      session[:lang]= params[:lang]
    end
  end

  def country
  end

  def household
  end

  def latrine
  end

  def capital
  end

  def recurrent
  end

  def providing
  end

  def impermeability
  end

  def environment
  end

  def usage
  end

  def reliability
  end


  def report

    render layout: "report"
  end
end
