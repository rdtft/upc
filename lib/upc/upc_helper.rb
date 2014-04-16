module Upc
  module UpcHelper
    def upc_button(upc_request, options = {}, &block)
      title = options.fetch(:title, 'Pay with UPC')

      content_tag(:form, :action => Upc::UPC_ENDPOINT_URL, :method => :post) do
        result = \
          hidden_field_tag("Version",      Upc::UPC_API_VERSION) + \
          hidden_field_tag("MerchantID",   upc_request.merchant_id) + \
          hidden_field_tag("TerminalID",   upc_request.terminal_id) + \
          hidden_field_tag("TotalAmount",  upc_request.total_amount) + \
          hidden_field_tag("Currency",     upc_request.currency_id) + \
          hidden_field_tag("PurchaseTime", upc_request.purchase_time) + \
          hidden_field_tag("locale",       upc_request.locale) + \
          hidden_field_tag("OrderID",      upc_request.order_id) + \
          hidden_field_tag("SD",           "") + \
          hidden_field_tag("PurchaseDesc", upc_request.purchase_desc) + \
          hidden_field_tag("Signature",    upc_request.b64sign) + \
          submit_tag(title, :name => nil)
      end
    end
  end
end
