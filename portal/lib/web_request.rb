dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require File.join(dir, 'httparty')
require 'pp'

class WebRequest
  include HTTParty
  base_uri 'https://localhost:4000/api/v1'

  def initialize(service)
  	binding.pry
    @options = { query: { site: service } }
  end
end
