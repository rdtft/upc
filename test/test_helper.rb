require 'minitest/autorun'
require 'mocha/setup'
require 'upc'

Upc.default_options[:merchant_id] = 1754002
Upc.default_options[:terminal_id] = 'E7882002'
Upc.default_options[:pem] = File.read 'vendor/generate-keys/1754002.pem'
