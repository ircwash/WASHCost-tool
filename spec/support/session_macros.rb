# Uses rack_session_access and Capybara integration to quickly modify the session at will
# for use in feature specs
module SessionMacros

  # Public interface method session
  def session(session_hash = nil)
    SessionHandler.new(page).session(session_hash)
  end

  # Public interface method clear_session!
  def clear_session!
    SessionHandler.new(page).clear_session!
  end

  # get a session handler from anywhere
  def session_handler
    SessionHandler.new(page)
  end

  # Hides all logic and complex methods from the public interface (and IDE's autocomplete)
  class SessionHandler

    # Holds the Capybara::Session object
    attr_reader :page

    def initialize(page)
      @page = page
    end

    # Sets the session to whatever it is passed completely erasing previous session data
    # @param session_hash [Hash] a hash representing the session that you wish to force
    def set_session=(session_hash)
      page.set_rack_session(session_hash)
    end

    # Retrieves the session
    # @param session_hash [Hash] a hash representing the session that you wish to force
    def get_session
      special_session_recursive_symbolize_keys!(page.get_rack_session)
    end

    # A way of accessing and setting the session in a more convenient 'session' method
    # e.g. session[:something] => 'some value' retrieves the given value from the session, but
    # session(:some => 'stuff') will set/override the 'stuff' in the session key "some"
    # @param session_hash [Hash] a hash representing the session that you wish to override
    def session(session_hash = nil)
      session_hash ? override_session(session_hash) : get_session
    end

    # Overrides the given key/value pairs in the current session to those you pass
    # @param session_hash [Hash] a hash representing the session that you wish to override
    def override_session(session_hash)
      page.set_rack_session get_session.deep_merge(session_hash)
    end

    # Clears the session completely! (except for the 'session_id' key)
    def clear_session!
      set_session({"session_id" => get_session["session_id"]})
    end

    ### Special session key symbolization utilities ###
    # This is only used to write symbols

    # Symbolizes a hash's keys provided those keys are strings and match the special symbolizable regex
    # @param session_hash [Hash] any hash (but particulary a session-derived hash)
    def special_session_symbolize_keys!(hash)
      hash.keys.each do |key|
        hash[(key.to_sym)] = hash.delete(key) if special_session_key_symbolizable?(key)
      end
      hash
    end

    # Recursively symbolizes session-specially the keys of a hash
    # @param hash [Hash] any hash (but particulary a session-derived hash)
    def special_session_recursive_symbolize_keys!(hash)
      hash = special_session_symbolize_keys!(hash)
      #hash.values.select{|nested_hash| nested_hash.is_a? Hash}.each{|nested_hash| nested_hash = special_session_recursive_symbolize_keys!(nested_hash)}
      hash.select{|key, value| value.is_a?(Hash)}.each do |key, value|
        hash[key] = special_session_symbolize_keys!(value)
      end
      hash
    end

    # Checks if the given key in a hash (particulary session hash) is symbolizable
    # @param key [Object] any key of a hash (could be anything) (particulary from session hash) to check
    def special_session_key_symbolizable?(key)
      key.is_a?(String) && key.to_s =~ special_session_symbolizable_regex
    end

    # Regex used to check if a given String 'key' is symbolizable
    def special_session_symbolizable_regex
      /^[a-z_][a-zA-Z_0-9]*$/
    end
  end

end
