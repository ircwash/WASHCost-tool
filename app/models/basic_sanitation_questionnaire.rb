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
