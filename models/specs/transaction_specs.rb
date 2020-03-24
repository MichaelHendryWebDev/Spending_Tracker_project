require("minitest/autorun")
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../transaction')

class TestTransaction < MiniTest::Test

def setup()
  options = {'id' => 1,
    'merchant_id' => 2,
    'tag_id' => 3,
    'amount' => 100}

  @transaction = Transaction.new(options)
end

def test_merchant_id()
  result = @transaction.merchant_id()
  assert_equal(2, result)
end

def test_tag_id()
  result = @transaction.tag_id()
  assert_equal(3, result)
end

def test_amount()
  result = @transaction.amount()
  assert_equal(100, result)
end

  def test_add_to_total()
    result = Transaction.add_total([@transaction])
    assert_equal(100, result)
end
end
