class BasicWaterQuestionnaire < Session

  attr_accessor :country,
                :technology,
                :population,
                :capital_expenditure,
                :recurrent_expenditure,
                :access,
                :quantity,
                :quality,
                :reliability


  def initialize( session )
    super( session, :basic_water )
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


  def reportable?
    [ technology, capital_expenditure, recurrent_expenditure, access, quality, quantity, reliability ].all?
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
    300
  end

  def minimum_guidance_capital_expenditure
    20
  end

  def maximum_guidance_capital_expenditure
    61
  end

  def minimum_recurrent_expenditure
    0
  end

  def maximum_recurrent_expenditure
    30
  end

  def minimum_guidance_recurrent_expenditure
    3
  end

  def maximum_guidance_recurrent_expenditure
    6
  end

  def minimum_access
    0
  end

  def maximum_access
    3
  end


  # CALCULATIONS


  def total_cost
    if capital_expenditure != nil && recurrent_expenditure != nil && population != nil
      ( capital_expenditure.to_i + recurrent_expenditure.to_i * 10 ) * population.to_i
    else
      nil
    end
  end

  def service_rating
    if access != nil && quality != nil && quantity != nil && reliability != nil
      access_rating = service_level_rating( access.to_i )
      quality_rating       = service_level_rating( quality.to_i )
      quantity_rating = service_level_rating( quantity.to_i )
      reliability_rating = service_level_rating( reliability.to_i )

      [ access_rating, quality_rating, quantity_rating, reliability_rating ].min
    else
      nil
    end
  end

  def cost_rating_inside_benchmarks?
    if capital_expenditure != nil && recurrent_expenditure != nil
      capital_expenditure_inside_benchmarks && recurrent_expenditure_inside_benchmarks
    else
      false
    end
  end

  def level_of_service
    if technology != nil && capital_expenditure != nil && recurrent_expenditure != nil && access != nil && quantity != nil && quality != nil && reliability != nil

      capital_expenditure_code   = expenditure_rating( capital_expenditure.to_f, minimum_guidance_capital_expenditure, maximum_guidance_capital_expenditure )
      recurrent_expenditure_code = expenditure_rating( recurrent_expenditure.to_f, minimum_guidance_recurrent_expenditure, maximum_guidance_recurrent_expenditure )

      access_code                = service_level_rating( access.to_i )
      quality_code               = service_level_rating( quality.to_i )
      reliability_code           = service_level_rating( reliability.to_i )

      quantity_code              = quantity.to_i + 1

      concat_first_service_group  = recurrent_expenditure_code.to_s + quantity_code.to_s + access_code.to_s
      concat_second_service_group = capital_expenditure_code.to_s   + quality_code.to_s  + reliability_code.to_s

      [ concat_first_service_group, concat_second_service_group ]
    else
      nil
    end
  end


  private


  def set_properties
    @country               = nil
    @technology            = nil
    @population            = nil
    @capital_expenditure   = nil
    @recurrent_expenditure = nil
    @access                = nil
    @quantity              = nil
    @quality               = nil
    @reliability           = nil
  end

  def service_level_rating( service )
    { 0 => 3, 1 => 2, 2 => 1, 3 => 0 }[ service ]
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

end
