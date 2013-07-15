class WaterBasicController < ApplicationController
  layout "water_basic_layout"

  before_filter :set_locale

  def set_locale
    I18n.locale = session[:lang] if session[:lang].present?
    I18n.locale = params[:lang] if params[:lang].present?

    if(params[:lang].present?)
      session[:lang]= params[:lang]
    end
  end

  def index
  end

  def country
  end

  def water
  end

  def population
  end

  def capital
  end

  def recurrent
  end

  def time
  end

  def quantity
  end

  def quality
  end

  def reliability
  end

  def report

    render layout: "report"
  end
end
