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


  def persisted?
    false
  end


  def attributes
    Hash[ property_attributes.map{ |a| [ a, send( "#{a}" ) ] } ]
  end


  protected


  def self.property_attributes
    @attributes
  end

  def property_attributes
    self.class.property_attributes
  end


  private


  def self.attr_accessor(*vars)
    @attributes ||= []
    @attributes.concat vars

    super
  end


  def archive
    data = {}

    property_attributes.each do |a|
      data[ a ] = send( a )
    end

    @session[ @identifier ] = data unless @session == nil
  end


  def unarchive
    @session[ @identifier ].each do |name, value|
      send( "#{name}=", value ) unless !self.respond_to? name
    end
  end

end
