require 'test_helper'

class FloatAnnuitiesTest < Minitest::Test
  include AnnuitiesHelper

  def test_improve_interest_rate
    # Based on Example 6 in http://oakroadsystems.com/math/loan.htm .
    assert_improve_interest_rate payment: 291.0, periods: 48.0,
      principal: 11200.0, guess: 0.01, expected: 0.0094295242,
      delta: 0.00000001
  end

  def test_interest_rate_stops_if_improvement_is_small
    # Based on Example 6 in http://oakroadsystems.com/math/loan.htm .
    assert_interest_rate_stops_if_improvement_is_small payment: 291.0,
      periods: 48.0, principal: 11200.0, guess: 0.01, precision: 0.5,
      expected: 0.0094295242, delta: 0.00000001
  end

  def test_interest_rate_does_multiple_iterations
    # Based on Example 6 in http://oakroadsystems.com/math/loan.htm .
    assert_interest_rate_does_multiple_iterations payment: 291.0,
      periods: 48.0, principal: 11200.0, guess: 0.01, precision: 0.0,
      max_decimals: 10, max_iterations: 4, expected: 0.0094007411,
      delta: 0.0000000001
  end

  def test_interest_rate_stops_if_max_iterations_reached
    expected = 0.42
    actual = Refinance::Annuities.interest_rate(0, 0, 0, expected, 0, 1, 0)

    assert_equal expected, actual
  end

  def test_payment
    # Based on Example 2 in http://oakroadsystems.com/math/loan.htm .
    assert_payment interest_rate: 0.0065, periods: 360.0, principal: 225000.0,
      expected: 1619.708627, delta: 0.000001
  end

  def test_periods
    # Based on Example 3 in http://oakroadsystems.com/math/loan.htm .
    assert_periods interest_rate: 0.005, payment: 100.0, principal: 3500.0,
      expected: 38.57, delta: 0.01
  end

  def test_principal
    # Based on Example 5 in http://oakroadsystems.com/math/loan.htm .
    assert_principal interest_rate: 0.014083, payment: 60.0, periods: 36.0,
      expected: 1685.26, delta: 0.01
  end

  def test_effective_interest_rate
    assert_effective_interest_rate nominal_annual_interest_rate: 0.1,
      compounding_periods_per_year: 12.0, expected: 0.10471, delta: 0.00001
  end
end
