require("minitest/autorun")
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../merchant')

class TestMerchant < MiniTest::Test

def setup
  options = {'id' => 1, 'name' => 'OzCorp', 'state' => true}

  @merchant = Merchant.new(options)
end

def test_name()
  result = @merchant.name()
  assert_equal("OzCorp", result)
end


end
