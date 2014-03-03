class Session

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  def initialize( session, identifier )

    @identifier = identifier
    @session    = session

    if ( session != nil && session[ @identifier ] )
      unarchive
    end

  end


  def update_attributes( attributes )

    if attributes != nil
      attributes.each do |name, value|

        if value == ''
          value = nil
        elsif value.kind_of?(Array)
          value.reject! { |v| v.empty? }

        end

        if respond_to?( "#{name}=" )
          send( "#{name}=", value )
        end
      end

      archive
    end
  end


  def persisted?
    false
  end


  def attributes
    Hash[ property_attributes.map{ |a| [ a, self.send(a) ] } ]
  end


  def reset
    set_properties

    archive
  end


  def complete?
    complete == 100
  end


  protected


  def property_attributes
    @attributes
  end


  def property_attributes(*attributes)
    @attributes ||= []
    @attributes.concat attributes
  end


  private


  def archive
    @session[ @identifier ] = attributes unless @session == nil
  end


  def unarchive
    @session[ @identifier ].each do |name, value|
      send( "#{name}=", value ) unless !self.respond_to? name
    end
  end


  def set_properties

  end

end
