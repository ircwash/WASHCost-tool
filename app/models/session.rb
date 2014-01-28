class Session

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming


  def initialize( session )

    @session = session

    if ( session[ :advanced_water ] )
      unarchive
    end

  end


  def update_attributes( attributes )

    attributes.each do |name, value|

      if value == ''
        value = nil
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


  protected


  def self.attributes
    @attributes
  end

  def attributes
    self.class.attributes
  end


  private


  def self.attr_accessor(*vars)
    @attributes ||= []
    @attributes.concat vars

    super
  end





  def archive
    data = {}

    instance_variables.map { |ivar| data[ ivar.to_s.gsub( /@/, '' ) ] = instance_variable_get ivar unless ivar == :@session || ivar == :@attributes }

    @session[ :advanced_water ] = data
  end


  def unarchive
    @session[ :advanced_water ].each do |name, value|
      send( "#{name}=", value )
    end
  end

end