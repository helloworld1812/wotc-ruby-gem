require File.expand_path('../wotc/error', __FILE__)
require File.expand_path('../wotc/api', __FILE__)
require File.expand_path('../wotc/client', __FILE__)
require File.expand_path('../wotc/response', __FILE__)

module WOTC
  extend Configuration

  # Alias for WOTC::Client.new
  #
  # @return [WOTC::Client]
  def self.client(options={})
    WTOC::Client.new(options)
  end

  # Delegate to WOTC::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to WOTC::Client
  def self.respond_to?(method, include_all=false)
    return client.respond_to?(method, include_all) || super
  end
end