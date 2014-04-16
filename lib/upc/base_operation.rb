module Upc
  CURRENCIES = {
    rub: 643,
    usd: 840,
    eur: 978,
    uah: 980,
  }

  LOCALES = [
    'en',
    'ru',
    'uk'
  ]

  class BaseOperation
    require 'base64'
    require 'openssl'

    attr_accessor :merchant_id
    attr_accessor :terminal_id

    attr_accessor :order_id
    attr_accessor :total_amount

    def initialize(options = {})
      options.replace(Upc.default_options.merge(options))

      @order_id    = options[:order_id]
      @merchant_id = options[:merchant_id]
      @terminal_id = options[:terminal_id]

      @pem    = options[:pem]
      @digest = OpenSSL::Digest::SHA1.new
      @pkey   = OpenSSL::PKey::RSA.new @pem

      @total_amount  = options[:total_amount]
    end

    def b64sign
      Base64.encode64(signature).split.join
    end

    def signature
      @signature ||= sign(data)
    end

  private
    def sign(data)
      @pkey.sign(@digest, data)
    end
  end
end
