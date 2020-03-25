require("minitest/autorun")
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../budget')

class TestBudget < MiniTest::Test

def setup
  options = {'id' => 1, 'budget' => 10}

  @budget = Budget.new(options)
end

def test_budget()
  result = @budget.budget()
  assert_equal(10, result)
end
end
