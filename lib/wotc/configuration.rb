require 'faraday'
require File.expand_path('../version', __FILE__)

module WOTC
  module Configuration
    # An array of valid keys in the options hash when configuring a {WOTC::API}
    OPTIONS_KEYS = [
      :access_token,
      :adapter,
      :format,
      :endpoint,
      :proxy,
      :user_agent,
    ]
    # By default, don't set a user access token.
    DEFAULT_ACCESS_TOKEN = nil

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = Faraday.default_adapter

    DEFAULT_ENDPOINT = 'https://sandbox.wotc.com/portal/api/v1/'.freeze

    DEFAULT_FORMAT = :json

    DEFAULT_PROXY = nil

    DEFAULT_USER_AGENT = "WOTC Ruby Gem #{WOTC::VERSION}".freeze
  end

  attr_accessor *OPTIONS_KEYS

  # When this module is extended, set all configuration options to their default values.
  def self.extended(base)
    base.reset
  end

  def configure
    yield self
  end

  def reset
    self.access_token       = DEFAULT_ACCESS_TOKEN
    self.adapter            = DEFAULT_ADAPTER
    self.endpoint           = DEFAULT_ENDPOINT
    self.format             = DEFAULT_FORMAT
    self.proxy              = DEFAULT_PROXY
    self.user_agent         = DEFAULT_USER_AGENT
  end
end