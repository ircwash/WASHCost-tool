# Builds on SessionMacros and provides more explicit application usage
# for use in feature specs for WashCost app
module WashCostSessionMacros

  # Public interface method basic_water_session
  def basic_water_session(session_hash = nil)
    WashCostSessionHandler.new(session_handler).basic_water_session(session_hash)
  end

  # Public interface method clear_basic_water_session!
  def clear_basic_water_session!
    WashCostSessionHandler.new(session_handler).clear_basic_water_session!
  end

  # Builds on the generic 'SessionHandler' class and provides convenience methods for managing washcost session namespaces
  class WashCostSessionHandler

    def initialize(session_handler)
      @session_handler = session_handler
    end

    def basic_water_session(session_hash = nil)
      session_hash ? @session_handler.override_session(basic_water_session_key => session_hash) : @session_handler.session[basic_water_session_key]
    end

    def clear_basic_water_session!
      @session_handler.override_session({ basic_water_session_key => nil })
    end

    def basic_water_session_key
      :water_basic_form
    end
  end

end
