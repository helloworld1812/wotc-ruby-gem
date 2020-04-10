require File.expand_path('../connection', __FILE__)
require File.expand_path('../request', __FILE__)
require File.expand_path('../configuration', __FILE__)

module WOTC
  class API
    include Connection
    include Request

    attr_accessor *WOTC::Configuration::VALID_OPTIONS_KEYS

    # Creates a new API
    def initialize(options={})
      options = WOTC.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def config
      conf = {}
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        conf[key] = send key
      end
      conf
    end
  end
end
