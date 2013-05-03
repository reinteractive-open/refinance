require 'test_helper'

class RefinanceTest < Minitest::Unit::TestCase
  def test_refinance_is_a_module
    assert_kind_of Module, ::Refinance
  end

  def test_version_is_a_string
    assert_kind_of String, ::Refinance::VERSION
  end

  def test_interest_rate_stops_if_max_iterations_reached
    expected = 0.42
    actual = Refinance::Annuities.interest_rate(0, 0, 0, expected, 0, 1, 0)

    assert_equal expected, actual
  end
end
