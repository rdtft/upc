require 'test_helper'

class TestCoreExt < MiniTest::Unit::TestCase
  def setup
    @hash = {
      key1: "foo",
      key2: "bar",
      key3: "quux",
      key4: 42
    }
  end

  def test_hash_only
    assert_equal @hash.only(:key4), { key4: 42 }
    assert_equal @hash.only(:key3, :key4), {key3: "quux", key4: 42}
    assert_equal @hash.only, {}
  end

  def text_hash_except
    assert_equal @hash.except(:key1, :key2, :key3), {key4: 42}
    assert_equal @hash.except(:key1, :key1, :key2, key3), {key4: 42}
    assert_equal @hash.except, @hash
  end
end
