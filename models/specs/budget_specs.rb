require("minitest/autorun")
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../budget')
require_relative('../transaction')

class TestBudget < MiniTest::Test

def setup
  options = {'id' => 1, 'cash' => 10}

  @budget = Budget.new(options)
end

def test_budget()
  result = @budget.cash()
  assert_equal(10, result)
end


end
