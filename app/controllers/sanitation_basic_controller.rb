class SanitationBasicController < ApplicationController

  before_filter :set_percent_complete
  include SanitationBasicHelper
  authorize_resource class: WaterBasicController
  layout 'basic/tool'

  def init_vars
    @@pages= 11
    super
  end

  def set_percent_complete
    flash[:percent_complete]= get_percent_complete(:sanitation_basic_complete)
  end

  def country
    if request.post?
      country_code = params[:country]
      if is_valid_country_code(country_code)
        add_to_session_form(:sanitation_basic_form, :sanitation_basic_complete, 'country', country_code)
        redirect_to :action => 'population'
      end
    end
    flash[:country_code] = retrieve_previous_answer_for('country')
    @navigation_header = {}
    @navigation_header[:number_of_items] = params[:number_of_items] || -1
  end

  def population
    if request.post?
      population= params[:population]
      if population && is_number(population) && population.to_i > -1 && population.to_i <= 1000000
        add_to_session_form(:sanitation_basic_form, :sanitation_basic_complete, "population", population.to_i)
        redirect_to :action => "latrine"
      end
    end
    @population = retrieve_previous_answer_for("population") || 0
  end

  def latrine
    if request.post?
      latrine_index= params[:latrine]
      if latrine_index && latrine_index.to_i > -1 && latrine_index.to_i < 6
        add_to_session_form(:sanitation_basic_form, :sanitation_basic_complete, 'latrine', latrine_index.to_i)
        redirect_to :action => 'capital'
      end
    end
    @latrine = {}
    @latrine[:value] = retrieve_previous_answer_for('latrine') || 0
    @latrine[:choices] = %w(traditional improved slab vip flush septik)
    @latrine[:class] = 'latrine-item'
  end

  def capital
    if request.post?
      capital_amount = params[:capital]
      if capital_amount && is_number(capital_amount) && capital_amount.to_i > -1
        add_to_session_form(:sanitation_basic_form, :sanitation_basic_complete, 'capital', capital_amount.to_i)
        redirect_to :action => 'recurrent'
      end
    end
    @capital = {}
    latrine_sources_index = retrieve_previous_answer_for('latrine') || 0
    range = capital_range_latrine_based latrine_sources_index
    @capital[:min_value] = range[:min_value]
    @capital[:max_value] = range[:max_value]
    @capital[:value] = retrieve_previous_answer_for('capital') || @capital[:min_value]
    #@capital[:below_value] = ((@capital[:max_value]-@capital[:min_value]).to_f*0.2).round+@capital[:min_value]
    #@capital[:above_value] = ((@capital[:max_value]-@capital[:min_value]).to_f*0.8).round+@capital[:min_value]
    @capital[:below_value] = range[:below_value]
    @capital[:above_value] = range[:above_value]
    @navigation_header = {}
    @navigation_header[:number_of_items] = params[:number_of_items] || -1
  end

  def recurrent
    if request.post?
      recurrent_amount = params[:recurrent]
      if recurrent_amount && recurrent_amount.to_i > -1
        add_to_session_form(:sanitation_basic_form, :sanitation_basic_complete, 'recurrent', recurrent_amount.to_i)
        redirect_to :action => 'providing'
      end
    end
    @recurrent = {}
    latrine_sources_index = retrieve_previous_answer_for('latrine') || 0
    range = recurrent_range_latrine_based latrine_sources_index
    @recurrent[:min_value] = range[:min_value]
    @recurrent[:max_value] = range[:max_value]
    @recurrent[:value] = retrieve_previous_answer_for('recurrent') || @recurrent[:min_value]
    @recurrent[:below_value] = range[:below_value]
    @recurrent[:above_value] = range[:above_value]
  end

  def providing
    if request.post?
      providing_index= params[:providing]
      if providing_index && providing_index.to_i > -1 && providing_index.to_i < 2
        add_to_session_form(:sanitation_basic_form, :sanitation_basic_complete, 'providing', providing_index.to_i)
        redirect_to :action => 'impermeability'
      end
    end
    @providing = {}
    @providing[:value] = retrieve_previous_answer_for('providing') || 0
    @providing[:choices] = %w(capitalYes capitalNo)
    @providing[:class] = 'providing-item'
    @navigation_header = {}
    @navigation_header[:number_of_items] = params[:number_of_items] || -1
  end

  def impermeability
    if request.post?
      impermeability_index= params[:impermeability]
      if impermeability_index && impermeability_index.to_i > -1 && impermeability_index.to_i < 2
        add_to_session_form(:sanitation_basic_form, :sanitation_basic_complete,'impermeability',  impermeability_index.to_i)
        redirect_to :action => 'environment'
      end
    end
    @impermeability = {}
    @impermeability[:value] = retrieve_previous_answer_for('impermeability') || 0
    @impermeability[:choices] = %w(capitalYes capitalNo)
    @impermeability[:class] = 'impermeability-item'
  end

  def environment
    if request.post?
      environment_index= params[:environment]
      if environment_index && environment_index.to_i > -1 && environment_index.to_i < 3
        add_to_session_form(:sanitation_basic_form, :sanitation_basic_complete, 'environment',  environment_index.to_i)
        redirect_to :action =>'usage'
      end
    end
    @environment = {}
    @environment[:value] = retrieve_previous_answer_for('environment') || 0
    @environment[:choices] = %w(safe reusable pollution)
    @environment[:class] = 'environment-item'
  end

  def usage
    if request.post?
      usage_index= params[:usage]
      if usage_index && usage_index.to_i > -1 && usage_index.to_i < 3
        add_to_session_form(:sanitation_basic_form,:sanitation_basic_complete, 'usage',  usage_index.to_i)
        redirect_to :action =>'reliability'
      end
    end
    @usage = {}
    @usage[:value] = retrieve_previous_answer_for('usage') || 0
    @usage[:choices] = %w(all some none)
    @usage[:class] = 'usage-item'
  end

  def reliability
    if request.post?
      put_index_in_session(:reliability, -1, 3, 'report')
    end
    @reliability = {}
    @reliability[:value] = retrieve_previous_answer_for('reliability') || 0
    @reliability[:choices] = %w(reliYes unreliable relyNot)
    @reliability[:class] = 'reliability-item'
  end

  def put_index_in_session(key, min, max, redirect)
    radio_index= params[key]
    if radio_index && radio_index.to_i > min && radio_index.to_i < max
      add_to_session_form(:sanitation_basic_form, :sanitation_basic_complete, key.to_s,  radio_index.to_i)
      #increase_pages_complete
      redirect_to :action => redirect
    end
  end

  def header_navigation
    redirect_to :action => params[:redirect_to], number_of_items: params[:number_of_items]
  end

  def report
    flash[:results] = sanitation_basic_report
    render layout: 'basic/report/main'
  end

  private

  def retrieve_previous_answer_for(user_step)
    begin
      session[:sanitation_basic_form].has_key?(user_step) ? session[:sanitation_basic_form][user_step] : nil
    rescue
      nil
    end
  end

end
