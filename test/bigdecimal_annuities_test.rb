require 'test_helper'

class BigDecimalAnnuitiesTest < Minitest::Test
  include AnnuitiesHelper

  def test_improve_interest_rate
    # Based on Example 6 in http://oakroadsystems.com/math/loan.htm .
    assert_improve_interest_rate payment: BigDecimal.new('291'),
      periods: BigDecimal.new('48'), principal: BigDecimal.new('11200'),
      guess: BigDecimal.new('0.01'), expected: BigDecimal.new('0.0094295242'),
      delta: BigDecimal.new('0.00000001')
  end

  def test_interest_rate_stops_if_improvement_is_small
    # Based on Example 6 in http://oakroadsystems.com/math/loan.htm .
    assert_interest_rate_stops_if_improvement_is_small \
      payment: BigDecimal.new('291'), periods: BigDecimal.new('48'),
      principal: BigDecimal.new('11200'), guess: BigDecimal.new('0.01'),
      precision: BigDecimal.new('0.5'),
      expected: BigDecimal.new('0.0094295242'),
      delta: BigDecimal.new('0.00000001')
  end

  def test_interest_rate_does_multiple_iterations
    # Based on Example 6 in http://oakroadsystems.com/math/loan.htm .
    assert_interest_rate_does_multiple_iterations \
      payment: BigDecimal.new('291'), periods: BigDecimal.new('48'),
      principal: BigDecimal.new('11200'), guess: BigDecimal.new('0.01'),
      precision: BigDecimal.new('0'), max_decimals: 10, max_iterations: 4,
      expected: BigDecimal.new('0.0094007411'),
      delta: BigDecimal.new('0.0000000001')
  end

  def test_interest_rate_stops_if_max_iterations_reached
    expected = BigDecimal.new('0.42')
    actual = Refinance::Annuities.interest_rate(0, 0, 0, expected, 0, 1, 0)

    assert_equal expected, actual
  end

  def test_payment
    # Based on Example 2 in http://oakroadsystems.com/math/loan.htm .
    assert_payment interest_rate: BigDecimal.new('0.0065'),
      periods: BigDecimal.new('360'), principal: BigDecimal.new('225000'),
      expected: BigDecimal.new('1619.708627'),
      delta: BigDecimal.new('0.000001')
  end

  def test_periods
    # Based on Example 3 in http://oakroadsystems.com/math/loan.htm .
    assert_periods interest_rate: BigDecimal.new('0.005'),
      payment: BigDecimal.new('100.0'), principal: BigDecimal.new('3500.0'),
      expected: BigDecimal.new('38.57'), delta: BigDecimal.new('0.01')
  end

  def test_principal
    # Based on Example 5 in http://oakroadsystems.com/math/loan.htm .
    assert_principal interest_rate: BigDecimal.new('0.014083'),
      payment: BigDecimal.new('60'), periods: BigDecimal.new('36'),
      expected: BigDecimal.new('1685.26'), delta: BigDecimal.new('0.01')
  end

  def test_effective_interest_rate
    assert_effective_interest_rate \
      nominal_annual_interest_rate: BigDecimal.new('0.1'),
      compounding_periods_per_year: BigDecimal.new('12'),
      expected: BigDecimal.new('0.10471'), delta: BigDecimal.new('0.00001')
  end
end
