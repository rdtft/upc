require 'upc/base_operation'

module Upc
  class Response < BaseOperation
    SUCCESS_TRANSITION_CODES = [000]

    ATTRIBUTES = [
      "merchant_id", "terminal_id", "tran_code", "currency", "alt_currency", "approval_code", "order_id", "signature",
      "purchase_time", "total_amount", "alt_total_amount", "proxy_pan", "sd", "x_id", "r_rn", "delay", "locale", "email"
    ].each do |attr|
      attr_reader attr
    end

    alias card proxy_pan
    alias status tran_code
    alias currency_id currency

    def initialize(options = {})
      # TODO: refactor, add signature varififaction
      super(options)
      decode!(options)

      @data = "#{@merchant_id};#{@terminal_id};#{@purchase_time};#{@order_id},#{@delay};#{@x_id};#{@currency},#{@alt_currency};#{@total_amount},#{@alt_total_amount};#{@sd};#{@tran_code};#{@approval_code};"
    end

    def success?
      SUCCESS_TRANSITION_CODES.include? self.status.to_i
    end

  private
    # TODO: refactor this ugly code
    def decode!(options)
      ATTRIBUTES.each do |attr|
        s = attr.gsub('_', '')

        options.select { |k, v| v != '' }.each_pair do |key, value|
          self.instance_variable_set('@'+attr, value) if key.match(/#{s}/i)
        end
      end
    end

  end
end
