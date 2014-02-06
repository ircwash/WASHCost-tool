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

end
