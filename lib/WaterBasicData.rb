class WaterBasicData


  def water_values
    return  [
      { :label => (I18n.t 'form.water_basic.water.answers.a0'), :value => 1,  :recExBench => { :min => 3 , :max => 6 }, :capExBench => { :min => 20, :max => 61 } },
      { :label => (I18n.t 'form.water_basic.water.answers.a1'), :value => 1, :recExBench => { :min => 3, :max => 15  }, :capExBench => { :min => 30, :max => 131 } },
      { :label => (I18n.t 'form.water_basic.water.answers.a2'), :value => 1, :recExBench => { :min => 3, :max => 15 }, :capExBench => { :min => 30, :max => 131 } },
        { :label => (I18n.t 'form.water_basic.water.answers.a3'), :value => 1, :recExBench => { :min => 3, :max => 15 }, :capExBench => { :min => 30, :max => 131 } },
        { :label => (I18n.t 'form.water_basic.water.answers.a4'), :value =>1, :recExBench => { :min => 3, :max => 15  }, :capExBench => { :min => 20, :max => 152 } }
    ]
  end

  def population_values
    return [
      { :label => "Less than 500", :value => 1 },
      { :label => "Between 501 and 5,000", :value => 2 },
      { :label => "Between 5,001 and 15,000", :value => 3 },
      { :label => "More than 15,000", :value => 4 }
    ]
  end

  def time_values
    return [
      { :label => (I18n.t 'form.water_basic.time.answers.a0'), :value => 4 },
      { :label => (I18n.t 'form.water_basic.time.answers.a1'), :value => 3 },
      { :label => (I18n.t 'form.water_basic.time.answers.a2'), :value => 2 },
      { :label => (I18n.t 'form.water_basic.time.answers.a3'), :value => 1 }
    ]
  end

  def quantity_values
    return [
      { :label =>  (I18n.t 'form.water_basic.quantity.answers.a0'), :value => (I18n.t 'form.shared.values.v0') },
      { :label =>  (I18n.t 'form.water_basic.quantity.answers.a1'), :value => (I18n.t 'form.shared.values.v1') },
      { :label =>  (I18n.t 'form.water_basic.quantity.answers.a2'), :value => (I18n.t 'form.shared.values.v2') },
      { :label =>  (I18n.t 'form.water_basic.quantity.answers.a3'), :value => (I18n.t 'form.shared.values.v3') }
    ]
  end

  def quality_values
    return [
      { :label => (I18n.t 'form.water_basic.quality.answers.a0'), :value => (I18n.t 'form.shared.values.v0') },
      { :label => (I18n.t 'form.water_basic.quality.answers.a1'), :value => (I18n.t 'form.shared.values.v1') },
      { :label => (I18n.t 'form.water_basic.quality.answers.a2'), :value => (I18n.t 'form.shared.values.v2') },
      { :label => (I18n.t 'form.water_basic.quality.answers.a3'), :value => (I18n.t 'form.shared.values.v3') }
    ]
  end

  def reliability_values
    return [
      { :label =>  ( I18n.t 'form.water_basic.reliability.answers.a0'), :value => 1.5 },
      { :label =>  ( I18n.t 'form.water_basic.reliability.answers.a1'), :value => 1.0 },
      { :label =>  ( I18n.t 'form.water_basic.reliability.answers.a2'), :value => 0.25 },
      { :label =>  ( I18n.t 'form.water_basic.reliability.answers.a3'), :value => 0.0 }
    ]
  end



end