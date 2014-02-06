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
    [ latrine, capital_expenditure, recurrent_expenditure, reliability ].all?
  end


  # DEFINITIONS

  def minimum_basic_population
    100
  end

  def maximum_basic_population
    1000000
  end

  def minimum_capital_expenditure
    0
  end

  def maximum_capital_expenditure
    50
  end

  def minimum_guidance_capital_expenditure
    7
  end

  def maximum_guidance_capital_expenditure
    26
  end

  def minimum_recurrent_expenditure
    0
  end

  def maximum_recurrent_expenditure
    8
  end

  def minimum_guidance_recurrent_expenditure
    1.5
  end

  def maximum_guidance_recurrent_expenditure
    4.0
  end

  # CALCULATIONS


  def total_cost
    if capital_expenditure != nil && recurrent_expenditure != nil && population != nil
      total_cost = get_capital(capital_expenditure) + (get_recurrent(recurrent_expenditure) * 10)
      (total_cost * get_population(population)).to_i
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

end
