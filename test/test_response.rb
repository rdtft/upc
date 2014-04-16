require 'test_helper'

class TestResponseUpc < MiniTest::Unit::TestCase
  def setup
    @params = {
      "MerchantID"     => "1754002",
      "TerminalID"     => "E7882002",
      "TranCode"       => "000",
      "Currency"       => "980",
      "AltCurrency"    => "",
      "ApprovalCode"   => "339302",
      "OrderID"        => "208",
      "Signature"      => "Kx5daMbkZlWil4Q0EUxnEXD08QLtjav+/5OnQ48ctcFG3adE8gvZ+8imxZnVPMmoK5rL6zz6n2Bo\r\nJVqbUScG4iwoVXr7FvnhPjJ+cEjgl8Do2r67CiRGykQxKu2Z9yL3aju/Yc5U8uFb7rX8I5JteAoZ\r\n1THzO+DvL0k26qnI7hY=",
      "PurchaseTime"   => "131024101505",
      "TotalAmount"    => "120000",
      "AltTotalAmount" => "",
      "ProxyPan"       => "499999******0011",
      "SD"             => "",
      "XID"            => "13102410-376059",
      "Rrn"            => "329710254716",
      "Delay"          => "",
      "locale"         => "uk",
      "Email"          => ""
    }

    @response = Upc::Response.new(@params)
  end

  def test_merchant_id
    assert_equal "1754002", @response.merchant_id
  end

  def test_order_id
    assert_equal "208", @response.order_id
  end

  def test_session_data
    assert_equal nil, @response.sd
  end

  def test_success_helper
    assert_equal true, @response.success?
  end

  def test_currency_id
    assert_equal "980", @response.currency_id
  end

  def test_card_number
    assert_equal "499999******0011", @response.card
  end

  def test_locale
    assert_equal 'uk', @response.locale
  end
end
