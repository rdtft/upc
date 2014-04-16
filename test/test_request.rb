require 'test_helper'

class TestRequest < MiniTest::Unit::TestCase
  def setup
    @options = {
      order_id:      Time.now.to_i,
      currency:      :uah,
      purchase_desc: "Test purchase description",
      total_amount:  rand(10000) + 100,
      locale:        :uk
    }

    @request = Upc::Request.new @options
  end

  def test_currency
    assert_equal :uah, @request.currency
  end

  def test_currency_id
    assert_equal 980, @request.currency_id
  end

  def test_currency_exception
    assert_raises(Upc::Exception) do
      Upc::Request.new(@options.merge({ currency: :ru }))
    end
  end

  def test_purchase_time
    assert @request.purchase_time
  end

  def test_purchase_time_format
    assert_equal "yyMMddHHmmss".length, @request.purchase_time.length
  end

  def test_total_amount
    assert_raises(Upc::Exception) do
      Upc::Request.new(@options.merge({ total_amount: 'a' }))
    end

    assert Upc::Request.new(@options.merge({ total_amount: '42' }))
  end

  def test_required_fields
    assert_raises(Upc::Exception) do
      Upc::Request.new @options.except(:order_id)
    end

    assert_raises(Upc::Exception) do
      Upc::Request.new @options.except(:total_amount)
    end

    assert Upc::Request.new @options
  end

  def test_base64sign
    Time.stubs(:now).returns(Time.mktime(1980,1,1)) do
      @request = Upc::Request.new(@options.merge({ order_id: 42, total_amount: 42.0 }))
      assert_equal 'EJ4q1H/d5lCbnyf/Pu5vvEqhz1nf9wNe0JPGYlPjjDTv5G6oWy4CtwdZui9zRGV93CNtn33VM6FPNfuDtTwlJYm6TZ7kQE4BmKLinEZ/9Q3azDIn/nrotZHNm6y9LGi4EhvR2pWdw9C9uOI/ZcEPe9P+IaFKIQvGSI5gpnwu6xs=', @request.b64sign
    end
  end

  def test_purchase_desc
    assert_raises(Upc::Exception) do
      Upc::Request.new(@options.merge({ purchase_desc: '' }))
    end

    assert_raises(Upc::Exception) do
      Upc::Request.new(@options.merge({ purchase_desc: 'very loooooong purchase description' }))
    end

    assert Upc::Request.new(@options.merge({ purchase_desc: 'short description' }))
    assert Upc::Request.new(@options.except(:purchase_desc))
  end

  def test_locale
    assert_equal 'uk', Upc::Request.new(@options.merge({:locale => :uk})).locale
    assert_equal 'uk', Upc::Request.new(@options.merge({:locale => 'uk'})).locale

    assert_raises(Upc::Exception) do
      Upc::Request.new @options.merge({:locale => :es})
    end
  end

  def test_convert_currency_to_symbol
    assert 'uah', Upc::Request.new(@options.merge({ currency: 'uah' })).currency
  end
end
