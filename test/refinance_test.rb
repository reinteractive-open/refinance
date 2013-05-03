require 'test_helper'

class RefinanceTest < MiniTest::Unit::TestCase
  def test_refinance_is_a_module
    assert_kind_of Module, ::Refinance
  end

  def test_version_is_a_string
    assert_kind_of String, ::Refinance::VERSION
  end
end
