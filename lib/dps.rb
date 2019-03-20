require 'dbc'
require "dps/dns"
require "dps/engine"
require "dps/version"

module Dps
  class Error < StandardError; end
  class ProcNotSetError < StandardError; end

  mattr_accessor :endpoints
  mattr_accessor :new_payment_endpoints_renderers
  self.new_payment_endpoints_renderers = {}
  
  def self.setup
    yield(self)
  end
  
  def self.get_new_payment_renderer(endpoint)
    begin
      new_payment_endpoints_renderers.fetch(endpoint.to_sym)
    rescue KeyError
      ProcNotSetError.new("Endpoint proc not set: '#{endpoint}'")
    end
  end
  
  def self.new_payment_renderer(endpoint, renderer)
    DBC.require(!renderer.is_a?(Class), "Renderer '#{renderer}' must not be a Class for delegation to work.")
    DBC.require(renderer.is_a?(Module), "Renderer '#{renderer}' must be a Module for delegation to work.")
    
    new_payment_endpoints_renderers[endpoint.to_sym] = renderer
  end
  
end
