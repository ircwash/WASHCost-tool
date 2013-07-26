class ApplicationController < ActionController::Base

  before_filter :set_locale
  before_filter :init_vars


  def select_advanced

    if request.post?

      puts params

      if(params[:targetForm].present? && params[:type].present?)
        targetForm= params[:targetForm]
        type= params[:type]

        if (targetForm== 'water' || targetForm=='sanitation') &&  (type== 'existing' || type=='planned')

            puts "GOING TO :"+ targetForm

            redirect_to :controller => (targetForm+"_advanced"), :action => "index", :params => { :type => type }

        end
      end
    end

  end

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

    if country_code && country_code.length == 2
      valid= true
    end

    return valid
  end

  def add_to_session_form(form_name, key, value)


    form= session[form_name].present? ? session[form_name] : Hash.new(0)

    if !form[key].present?
      increase_complete_percent(:water_advanced_completed)
    end

    form[key]= value

    session[form_name]= form
    puts session[form_name]
  end


  def increase_complete_percent(form)

    pages_complete= session[form].present? ? session[form] : 0
    pages_complete+= 1;
    session[form] =  pages_complete

  end

  def is_number(string)
    true if Integer(string) rescue false
  end

end
