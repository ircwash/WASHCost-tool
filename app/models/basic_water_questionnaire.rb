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
