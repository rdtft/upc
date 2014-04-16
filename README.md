# upc

This gem inspired by [leonid-shevtsov/liqpay](https://github.com/leonid-shevtsov/liqpay) gem

This Ruby gem implements the UPC billing system API, as described in the UPC [documentation](http://ecconnect.com.ua).

### Useful links:
  - http://ecconnect.com.ua/docs/reg_form.doc
  - http://ecconnect.com.ua/docs/shop_secure_payments.pdf
  - http://ecconnect.com.ua/docs/shop_gateway_interface.pdf
  - http://ecconnect.com.ua/docs/testing.pdf
  - http://ecconnect.com.ua/docs/admin_interface.pdf

## Installation

in your `Gemfile`:

```ruby
gem 'upc', :github => 'ryuk/upc'

```

## HOWTO generate public/private keys

```shell
$ cd vendor/generate-keys
$ make
```

## Configuration

```ruby
Upc.default_options[:merchant_id] = 1754002
Upc.default_options[:terminal_id] = 'E7882002'
Upc.default_options[:pem] = File.read 'generate-keys/1754002.pem'
```

## Some examples

- create a request object

  ```ruby
  @upc_request = Upc::Request.new(
    order_id:      Time.now.to_i,
    currency:      :uah,
    purchase_desc: "purchase description",
    total_amount:  rand(10000) + 100,
    locale:        :uk)
  ```

- show payment button

  ```erb
  <%= upc_button @upc_request %>
  ```

- process the response

  ```ruby
  @response = Upc::Response.new(params)
  ...
  if @response.success?
    pp @response.order_id
  end
  ...
  ```
  
