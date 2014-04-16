require 'upc/base_operation'

module Upc
  class Request < BaseOperation
    attr_accessor :purchase_desc
    attr_accessor :purchase_time

    attr_accessor :locale

    attr_accessor :currency
    attr_accessor :currency_id

    def initialize(options = {})
      super(options)

      @purchase_desc = options[:purchase_desc]
      @purchase_time = Time.now.strftime("%y%m%d%H%M%S")

      @locale = options[:locale].to_s

      @currency    = options[:currency].to_sym
      @currency_id = Upc::CURRENCIES[@currency]

      validate!
    end

    def data
      @data ||= make_data
    end

  private
    def make_data
      "#{@merchant_id};#{@terminal_id};#{@purchase_time};#{@order_id};#{@currency_id};#{@total_amount};;"
    end

    def validate!
      %w(merchant_id terminal_id order_id currency total_amount).each do |required_field|
        raise Upc::Exception.new(required_field + ' is a required field') unless self.send(required_field).to_s != ''
      end

      raise Upc::Exception.new('currency must be one of ' + Upc::CURRENCIES.keys.join(', ')) unless Upc::CURRENCIES.has_key?(currency)
      raise Upc::Exception.new('locale must be one of ' + Upc::LOCALES.join(', ')) unless Upc::LOCALES.include?(self.locale)

      if !self.purchase_desc.nil? && !self.purchase_desc.size.between?(1, 25)
        raise Upc::Exception.new('purchase_desc length must be between 1 or 25')
      end

      begin
        self.total_amount = Integer(self.total_amount)
      rescue ArgumentError, TypeError
        raise Upc::Exception.new('total_amount must be a number')
      end
    end

  end
end
