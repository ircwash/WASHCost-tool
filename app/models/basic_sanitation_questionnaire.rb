class BasicSanitationQuestionnaire < Session

  attr_accessor :country,
                :population,
                :latrine,
                :capital_expenditure,
                :recurrent_expenditure,
                :household_latrine,
                :impermeability,
                :environmental_impact,
                :usage,
                :reliability


  def initialize( session )
    super( session, :basic_sanitation )

    property_attributes :country, :population, :latrine, :capital_expenditure, :recurrent_expenditure, :household_latrine, :impermeability, :environmental_impact, :usage, :reliability
  end


  def complete
    attributes_with_values = 0
    total_attributes = property_attributes.count

    property_attributes.each do |attribute|
      value = send( "#{attribute}" )

      if value != nil && value.kind_of?( Array ) && value & [''] == value
        value = nil
      end

      if value != nil
        attributes_with_values = attributes_with_values + 1
      end
    end

    100 * attributes_with_values / total_attributes
  end

  def service_reportable?
    [ service_rating ].all?
  end

  def reportable?
    [ latrine, capital_expenditure, recurrent_expenditure, reliability, service_rating ].all?
  end


  # DEFINITIONS


  def minimum_population
    100
  end

  def maximum_population
    1000000
  end

  def minimum_capital_expenditure
    0
  end

  def maximum_capital_expenditure
    case latrine.to_i
      when 0
        100
      when 1..5
        500
      else
        500
    end
  end

  def minimum_guidance_capital_expenditure
    case latrine.to_i
      when 0
        7
      when 1..2
        36
      when 3..5
        92
      else
        7
    end
  end

  def maximum_guidance_capital_expenditure
    case latrine.to_i
      when 0
        26
      when 1..5
        358
      else
        26
    end
  end

  def minimum_recurrent_expenditure
    0
  end

  def maximum_recurrent_expenditure
    case latrine.to_i
      when 0
        8
      when 1..2
        17
      when 3..5
        23
      else
        8
    end
  end

  def minimum_guidance_recurrent_expenditure
    case latrine.to_i
      when 0
        1.5
      when 1..2
        2.5
      when 3..5
        3.5
      else
        1.5
    end
  end

  def maximum_guidance_recurrent_expenditure
    case latrine.to_i
      when 0
        4.0
      when 1..2
        8.5
      when 3..5
        11.5
      else
        4.0
    end
  end


  # CALCULATIONS


  def total_cost
    if capital_expenditure != nil && recurrent_expenditure != nil && population != nil
      ( capital_expenditure.to_f + recurrent_expenditure.to_f * 10 ) * population.to_f
    else
      nil
    end
  end

  def service_rating
    if household_latrine != nil && impermeability != nil && environmental_impact != nil && usage != nil && reliability != nil
      environment_rating = service_level_rating( environmental_impact.to_i )
      usage_rating       = service_level_rating( usage.to_i )
      reliability_rating = service_level_rating( reliability.to_i )

      [ access_rating, environment_rating, usage_rating, reliability_rating ].min
    else
      nil
    end
  end

  def access_rating
    # changed this from [1, 1] to [2, 1] to fix latrine error
    [ [ 3, 1 ], [ 2, 1 ] ][ household_latrine.to_i ][ impermeability.to_i ]
  end

  def cost_rating_inside_benchmarks?
    if capital_expenditure != nil && recurrent_expenditure != nil
      capital_expenditure_inside_benchmarks && recurrent_expenditure_inside_benchmarks
    else
      false
    end
  end

  def level_of_service
    if latrine != nil && capital_expenditure != nil && recurrent_expenditure != nil && usage != nil && reliability != nil && household_latrine != nil && impermeability != nil && environmental_impact != nil

      capital_expenditure_code    = expenditure_rating( capital_expenditure.to_f, minimum_guidance_capital_expenditure, maximum_guidance_capital_expenditure )
      recurrent_expenditure_code  = expenditure_rating( recurrent_expenditure.to_f, minimum_guidance_recurrent_expenditure, maximum_guidance_recurrent_expenditure )

      usage_code                  = map_indicator_to_output( usage.to_i )
      reliability_code            = map_indicator_to_output( reliability.to_i )
      evironment_code             = map_indicator_to_output( environmental_impact.to_i )

      concat_first_service_group  = recurrent_expenditure_code.to_s + usage_code.to_s    + reliability_code.to_s
      concat_second_service_group = capital_expenditure_code.to_s   + access_rating.to_s + evironment_code.to_s
      [ concat_first_service_group, concat_second_service_group ]
    else
      nil
    end
  end


  private


  def set_properties
    @country               = nil
    @population            = nil
    @latrine               = nil
    @capital_expenditure   = nil
    @recurrent_expenditure = nil
    @household_latrine     = nil
    @impermeability        = nil
    @environmental_impact  = nil
    @usage                 = nil
    @reliability           = nil
  end

  def service_level_rating( service )
    { 0 => 3, 1 => 2, 2 => 1 }[ service ]
  end

  def capital_expenditure_inside_benchmarks
    capital_expenditure.to_f >= minimum_guidance_capital_expenditure && capital_expenditure.to_f <= maximum_guidance_capital_expenditure
  end

  def recurrent_expenditure_inside_benchmarks
    recurrent_expenditure.to_f >= minimum_guidance_recurrent_expenditure && recurrent_expenditure.to_f <= maximum_guidance_recurrent_expenditure
  end

  def expenditure_rating( value, minimum, maximum )
    if value < minimum
      1
    elsif value >= minimum && value <= maximum
      2
    else
      3
    end
  end

  def map_indicator_to_output( index )
    { 0 => 4, 1 => 3, 2 => 1}[ index ]
  end

end
