class WaterBasicController < ApplicationController
  include WaterBasicHelper
  include WaterReportHelper

  authorize_resource class: WaterBasicController

  before_filter :set_percent_complete
  layout "basic/tool"

  def init_vars
    @@pages= 9
    super
  end

  def set_percent_complete
    flash[:percent_complete]= get_percent_complete(:water_basic_complete)
  end

  def country
    if request.post?
      country_code= params[:country]
      if is_valid_country_code(country_code)
        add_to_session_form(:water_basic_form, :water_basic_complete, 'country', country_code)
        redirect_to :action => 'water'
      end
    end
    flash[:country_code] = retrieve_previous_answer_for('country')
    flash[:pages_complete] = session[:water_basic_complete]
  end

  def water
    if request.post?
      # water index selected
      water_index= params[:water]
      if water_index && water_index.to_i > -1 && water_index.to_i <= 4
        # if a water index is not selected then the to_i method put 0 into this
        add_to_session_form(:water_basic_form, :water_basic_complete, 'water', water_index.to_i)
        redirect_to :action => 'population'
      end
    end
    @water = {}
    @water[:value] = retrieve_previous_answer_for('water') || 0
    @water[:choices] = %w(boreHold mechanised singleTown multiTown mixedPipe)
    @water[:class] = 'water-item'
  end

  def population
    @population = {}
    if request.post?
      # default value is the min value of population slider
      population= params[:population]
      if population && is_number(population) && population.to_i > -1 && population.to_i <= 1000000
        add_to_session_form(:water_basic_form, :water_basic_complete, 'population', population.to_i)
        redirect_to :action => 'capital'
      end
    end
    @population[:value] = retrieve_previous_answer_for('population')
    @population[:question_label] =  retrieve_previous_answer_for('water').present? ? t('form.water_basic.population.question', technology: @@water_values[retrieve_previous_answer_for('water').to_i][:label]) : t('form.water_basic.population.default_question')
  end

  def capital
    if request.post?
      capital_amount = params[:capital]
      if capital_amount && is_number(capital_amount) && capital_amount.to_i > -1
        add_to_session_form(:water_basic_form, :water_basic_complete, 'capital', capital_amount.to_i)
        redirect_to :action => 'recurrent'
      end
    end
    @capital = {}
    water_sources_index = retrieve_previous_answer_for('water') || 0
    range = capital_range_water_based water_sources_index
    @capital[:min_value] = range[:min_value]
    @capital[:max_value] = range[:max_value]
    @capital[:value] = retrieve_previous_answer_for('capital') || @capital[:min_value]
    #@capital[:below_value] = ((@capital[:max_value]-@capital[:min_value]).to_f*0.2).round+@capital[:min_value]
    #@capital[:above_value] = ((@capital[:max_value]-@capital[:min_value]).to_f*0.8).round+@capital[:min_value]
    @capital[:below_value] = range[:below_value]
    @capital[:above_value] = range[:above_value]
  end

  def recurrent
    if request.post?
      recurrent_amount = params[:recurrent]
      if recurrent_amount && is_number(recurrent_amount) && recurrent_amount.to_i > -1
        add_to_session_form(:water_basic_form, :water_basic_complete, 'recurrent', recurrent_amount.to_i)
        redirect_to :action => 'time'
      end
    end
    @recurrent = {}
    water_sources_index = retrieve_previous_answer_for('water') || 0
    range = recurrent_range_water_based water_sources_index
    @recurrent[:min_value] = range[:min_value]
    @recurrent[:max_value] = range[:max_value]
    @recurrent[:value] = retrieve_previous_answer_for('recurrent') || @recurrent[:min_value]
    @recurrent[:above_value] = range[:above_value]
    @recurrent[:below_value] = range[:below_value]
  end

  def time
    if request.post?
      time_index= params[:time]
      if time_index && is_number(time_index) && time_index.to_i > -1 && time_index.to_i < 4
        add_to_session_form(:water_basic_form, :water_basic_complete, 'time', time_index.to_i)
        redirect_to :action => 'quantity'
      end
    end
    @time = retrieve_previous_answer_for('time')
  end

  def quantity
    if request.post?
      quantity_index= params[:quantity]
      if quantity_index && quantity_index.to_i > -1 && quantity_index.to_i <= 3
        add_to_session_form(:water_basic_form, :water_basic_complete, 'quantity', quantity_index.to_i)
        redirect_to :action => 'quality'
      end
    end
    @quantity = {}
    @quantity[:value] = retrieve_previous_answer_for('quantity') || 0
    @quantity[:choices] = %w(waterLessThan waterFromFive waterFromTwenty waterMoreThan)
    @quantity[:class] = 'quantity-item'
  end

  def quality
    if request.post?
      quality_index= params[:quality]
      if quality_index && quality_index.to_i > -1 && quality_index.to_i <= 3
        add_to_session_form(:water_basic_form, :water_basic_complete, 'quality', quality_index.to_i)
        redirect_to :action => 'reliability'
      end
    end
    @quality = {}
    @quality[:value] = retrieve_previous_answer_for('quality') || 0
    @quality[:choices] = %w(noTest test occasional regular)
    @quality[:class] = 'quality-item'
  end

  def reliability
    if request.post?
      reliability_index= params[:reliability]
      if reliability_index && reliability_index.to_i > -1 && reliability_index.to_i <= 3
        add_to_session_form(:water_basic_form, :water_basic_complete, 'reliability', reliability_index.to_i)
        redirect_to :action => 'report'
      end
    end
    @reliability = {}
    @reliability[:value] = retrieve_previous_answer_for('reliability') || 0
    @reliability[:choices] = %w(worksAll worksMostly breakDown notWorking)
    @reliability[:class] = 'reliability-item'
  end

  def report
    flash[:results] = water_basic_report
    render layout: 'basic/report/main'
  end

  def data_info_box
    trigger=params[:trigger]
    index= params[:index]
    @info_box = {header: I18n.t("form.water_basic.#{trigger}.answers.a#{index}", :default => "Info"), content: I18n.t("form.water_basic.#{params[:trigger]}.info.i#{index}", :default => 'No Info')}
    respond_to do |format|
      format.js
    end
  end

  private

  def retrieve_previous_answer_for(user_step)
    begin
      session[:water_basic_form].has_key?(user_step) ? session[:water_basic_form][user_step] : nil
    rescue
      nil
    end
  end
end
