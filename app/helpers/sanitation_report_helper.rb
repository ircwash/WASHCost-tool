module SanitationReportHelper

  def get_sanitation_basic_report

    form= get_session_form

    cost_rating= get_cost_rating(form[:water], form[:capital])
    cost_rating_label= get_cost_rating_label(cost_rating)

    results = {

        :cost_rating=> cost_rating,
        :cost_rating_label=> cost_rating_label,
        :country => get_country(form[:country]),
        :household => get_household(form[:household]),
        :latrine_index => form[:latrine],
        :latrine => get_latrine(form[:latrine]),
        :capital => get_capital(form[:capital]),
        :recurrent => get_recurrent(form[:recurrent]),
        :total => get_total(form[:capital], form[:recurrent], 500),
        :providing => get_providing(form[:providing]),
        :usage => get_usage(form[:usage]),
        :impermeability => get_impermeability(form[:impermeability]),
        :environment => get_environment(form[:environment]),
        :reliability => get_reliability(form[:reliability])
    }

    return results

  end

  def get_session_form

    puts "form from session"
    puts session[:sanitation_basic_form]

    form= {
        :country => session[:sanitation_basic_form]["country"],
        :household => session[:sanitation_basic_form]["household"],
        :latrine => session[:sanitation_basic_form]["latrine"],
        :capital => session[:sanitation_basic_form]["capital"],
        :recurrent => session[:sanitation_basic_form]["recurrent"],
        :providing => session[:sanitation_basic_form]["providing"],
        :usage => session[:sanitation_basic_form]["usage"],
        :impermeability => session[:sanitation_basic_form]["impermeability"],
        :environment => session[:sanitation_basic_form]["environment"],
        :reliability => session[:sanitation_basic_form]["reliability"]
    }

    return form
  end

  def get_country(country_code)

    country= Country.new(country_code)
    if(country.data == nil)
      country = nil
    end

    return country
  end

  def get_household(household)

    return household
  end

  def get_latrine(index)

    latrine= @@latrine_values[index][:value]

    return latrine
  end

  def get_usage(index)

    usage= @@usage_values[index][:value]
    return usage
  end

  def get_capital(capital)

    return capital
  end

  def get_recurrent(recurrent)

    return recurrent
  end

  def get_providing(index)

    providing= @@providing_values[index][:value]

    return providing
  end

  def get_environment(index)
    environment= @@environment_values[index][:value]
    return environment
  end

  def get_impermeability(index)

    impermeability= @@impermeability_values[index][:value]

    return impermeability
  end

  def get_reliability(index)


    reliability= @@reliability_values[index][:value]

    return reliability
  end

  @@latrine_values= [
    { :value => (I18n.t 'form.sanitation_basic.latrine.answers.a0')},
    { :value => (I18n.t 'form.sanitation_basic.latrine.answers.a1')} ,
    { :value => (I18n.t 'form.sanitation_basic.latrine.answers.a2')},
    { :value => (I18n.t 'form.sanitation_basic.latrine.answers.a3')},
    { :value => (I18n.t 'form.sanitation_basic.latrine.answers.a4') }
  ]

  @@providing_values= [
      { :value => (I18n.t 'form.sanitation_basic.providing.answers.a0')},
      { :value => (I18n.t 'form.sanitation_basic.providing.answers.a1')}
  ]

  @@permeability_values= [
      { :value => (I18n.t 'form.sanitation_basic.permeability.answers.a0')},
      { :value => (I18n.t 'form.sanitation_basic.permeability.answers.a1')}
  ]

  @@environment_values= [
      { :value => (I18n.t 'form.sanitation_basic.environment.answers.a0')},
      { :value => (I18n.t 'form.sanitation_basic.environment.answers.a1')},
      { :value => (I18n.t 'form.sanitation_basic.environment.answers.a2')}
  ]

  @@usage_values= [
      { :value => (I18n.t 'form.sanitation_basic.usage.answers.a0')},
      { :value => (I18n.t 'form.sanitation_basic.usage.answers.a1')} ,
      { :value => (I18n.t 'form.sanitation_basic.usage.answers.a2')}
  ]

  @@impermeability_values= [
      { :value => (I18n.t 'form.sanitation_basic.impermeability.answers.a0')},
      { :value => (I18n.t 'form.sanitation_basic.impermeability.answers.a1')} ,
      { :value => (I18n.t 'form.sanitation_basic.impermeability.answers.a2')}
  ]

  @@reliability_values= [
      { :value => (I18n.t 'form.sanitation_basic.reliability.answers.a0')},
      { :value => (I18n.t 'form.sanitation_basic.reliability.answers.a1')} ,
      { :value => (I18n.t 'form.sanitation_basic.reliability.answers.a2')}
  ]

  def get_total(capital, recurrent, population)

    total_cost = capital + (recurrent * 10)
    total_cost_for_population = total_cost * population
    return total_cost_for_population

  end


  def get_cost_rating(water_index, capEx)
    benchmark= 0

    if water_index && capEx
      if water_index==0

        if capEx < 20
          0
        elsif capEx > 61
          1
        else
          2
        end

      else

        if capEx < 30
          0
        elsif capEx > 131
          1
        else
          2
        end

      end
    end

    return benchmark
  end

  def get_cost_rating_label(rating)

    label=  t 'report.benchmark_below'

    if rating==0
      label= (t 'report.benchmark_below')
    elsif rating==1
      label= (t 'report.benchmark_within')
    elsif rating==2
      label= (t 'report.benchmark_above')
    else
      label= 'Please Enter a <a href="./water">waterIndex</a> and <a href="./capital">Capital Expenditure<a/>'
    end

    return label

  end
end