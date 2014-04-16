require 'upc/version'
require 'upc/request'
require 'upc/response'
require 'core_ext/hash'

require 'upc/railtie' if defined?(Rails)

module Upc
  UPC_API_VERSION  = '1'
  UPC_ENDPOINT_URL = 'https://secure.upc.ua/ecgtest/enter'

  @default_options = {}

  class << self
    attr_accessor :default_options
  end

  class Exception < ::Exception; end
  class InvalidResponse < Exception; end
end
