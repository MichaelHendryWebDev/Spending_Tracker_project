require("minitest/autorun")
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../tag')

class TestTag < MiniTest::Test

def setup()
  options = {'id' => 1, 'type' => 'scientific'}

  @tag = Tag.new(options)
end

def test_tag_type()
  result = @tag.type()
  assert_equal('scientific', result)
end

end
