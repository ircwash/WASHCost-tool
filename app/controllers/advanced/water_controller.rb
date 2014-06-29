class Advanced::WaterController < CalculatorController

  include ApplicationHelper

  layout 'tool_advanced'

  authorize_resource :class => Advanced::WaterController
  load_and_authorize_resource UserReport, :only => [ :save_report, :store_report ]


  def begin
    @questionnaire = AdvancedWaterQuestionnaire.new( session )
    @questionnaire.reset

    redirect_to advanced_water_action_path( I18n.locale, :service_area, :start => true )
  end

  def questionnaire
    if params[ :start ] != nil
      session[:advanced_water][:currency] = nil
      session[:advanced_water][:country] = nil
      session[:advanced_water][:status] = nil
      session[:advanced_water][:year_of_expenditure] = nil
    end
    @questionnaire = AdvancedWaterQuestionnaire.new( session )

    render params[ :section ]
  end

  def update
    @questionnaire = AdvancedWaterQuestionnaire.new( session )
    
    # save updated questionnaire
    @questionnaire.update_attributes( params[ :advanced_water_questionnaire ] )

    redirect_to advanced_water_action_path( I18n.locale, params[ :section ] )
  end

  def dynamic_update
    @questionnaire = AdvancedWaterQuestionnaire.new( session )

    # save updated questionnaire
    @questionnaire.update_attributes( params[ :advanced_water_questionnaire ] )

    render json: { :progress => @questionnaire.complete }
  end

  def report
    @questionnaire = AdvancedWaterQuestionnaire.new( session )

    # No choice but to do the following

    benchmark_moe = Hash.new()
    benchmark_moe_new = []
    benchmark_dsc_new = []    
    out = final_usd_2011_number(@questionnaire.attributes, 1)

    if out != nil

      @questionnaire.benchmark_minor_operation_expenditure.each do |val|
        if benchmark.has_key?(val.to_s) == false
          newvalue = "#{number_with_precision( val.to_f / out.to_f, :precision => 5 )}"
          benchmark[val] = newvalue.to_s
          benchmark_moe_new.push(newvalue.to_s)
        else
          benchmark_moe_new.push(benchmark[val])
        end
      end

      @questionnaire.benchmark_direct_support_cost.each do |val|
        if benchmark.has_key?(val) == false
          newvalue = "#{number_with_precision( val.to_f / out.to_f, :precision => 5 )}"
          benchmark[val] = newvalue.to_s
          benchmark_dsc_new.push(newvalue.to_s)
        else
          benchmark_dsc_new.push(benchmark[val])
        end
      end

    end

    @questionnaire.benchmark_moe = benchmark_moe_new
    @questionnaire.benchmark_dsc = benchmark_dsc_new

    render layout: 'report'
  end

  def save_report
    @report = UserReport.new

    render layout: 'general', template: 'shared/save_report'
  end

  def share_report

    @report = Report.create( :level => 'advanced', :type => 'water', :questionnaire => AdvancedWaterQuestionnaire.new( session ).attributes )
    @back_path = advanced_water_report_path( I18n.locale )

    render layout: 'general', template: 'shared/share_report'
  end

  def store_report

    # Added logic here, to remove on the fly database rendering and calculations from views
    # calculations and logic called here and saved to the database
    # couldn't go to deep without re-writing all logic and models

    avq = AdvancedWaterQuestionnaire.new( session )
    questionnaire = avq.attributes

    cepp = final_usd_2011(questionnaire, capital_expenditure_per_person(questionnaire)).to_s
    repppy = final_usd_2011(questionnaire, recurrent_expenditure_per_person_per_year(questionnaire, 30)).to_s
    poptman = percentage_of_population_that_meets_all_norms(questionnaire).to_s

    # benchmark_moe = Hash.new()
    # benchmark_moe_new = []
    # benchmark_dsc_new = []
    # out = final_usd_2011_number(questionnaire, 1)

    # if out != nil

    #   for i in avq.benchmark_minor_operation_expenditure
    #     val = avq.benchmark_minor_operation_expenditure[i]
    #     if benchmark_moe.has_key?(val) == false
    #       newvalue = "#{number_with_precision( val.to_f / out.to_f, :precision => 5 )}"
    #       benchmark_moe[val] = newvalue.to_s
    #       benchmark_dsc_new.push(newvalue.to_s)
    #     else
    #       benchmark_moe_new.push(benchmark_moe[val])
    #     end
    #   end

    #   for i in avq.benchmark_direct_support_cost
    #     val = avq.benchmark_direct_support_cost[i]
    #     if benchmark_moe.has_key?(val) == false
    #       newvalue = "#{number_with_precision( val.to_f / out.to_f, :precision => 5 )}"
    #       benchmark_moe[val] = newvalue.to_s
    #       benchmark_dsc_new.push(newvalue.to_s)
    #     else
    #       benchmark_dsc_new.push(benchmark_moe[val])
    #     end
    #   end

    # end

    # questionnaire[:benchmark_moe] = benchmark_moe_new
    # questionnaire[:benchmark_dsc] = benchmark_dsc_new

    super( params[ :user_report ][ :title ], 'advanced', session[:advanced_water][:status], 'water', questionnaire, cepp, repppy, poptman)
  end

end
