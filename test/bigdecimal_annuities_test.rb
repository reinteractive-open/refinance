require 'test_helper'
require 'bigdecimal'

class BigDecimalAnnuitiesTest < MiniTest::Unit::TestCase

  def test_improve_interest_rate
    # Based on Example 6 in http://oakroadsystems.com/math/loan.htm .
    payment = BigDecimal.new('291')
    periods = BigDecimal.new('48')
    principal = BigDecimal.new('11200')
    guess = BigDecimal.new('0.01')

    expected = BigDecimal.new('0.0094295242')
    actual = Refinance::Annuities.improve_interest_rate(payment, periods,
      principal, guess)

    assert_in_delta expected, actual, BigDecimal.new('0.00000001')
  end

  def test_interest_rate_stops_if_improvement_is_small
    # Based on Example 6 in http://oakroadsystems.com/math/loan.htm .
    payment = BigDecimal.new('291')
    periods = BigDecimal.new('48')
    principal = BigDecimal.new('11200')
    guess = BigDecimal.new('0.01')
    imprecision = BigDecimal.new('0.5')

    expected = BigDecimal.new('0.0094295242')
    actual = Refinance::Annuities.interest_rate(payment, periods, principal,
      guess, imprecision)

    assert_in_delta expected, actual, BigDecimal.new('0.00000001')
  end

  def test_interest_rate_stops_if_max_iterations_reached
    extreme_precision = BigDecimal.new('0')
    guess = BigDecimal.new('0.01')

    expected = guess
    actual = Refinance::Annuities.interest_rate(0, 0, 0, guess,
      extreme_precision, 1, 0)

    assert_equal expected, actual
  end

  def test_interest_rate_does_multiple_iterations
    # Based on Example 6 in http://oakroadsystems.com/math/loan.htm .
    payment = BigDecimal.new('291')
    periods = BigDecimal.new('48')
    principal = BigDecimal.new('11200')
    guess = BigDecimal.new('0.01')
    extreme_precision = BigDecimal.new('0')
    max_iterations = 4

    expected = BigDecimal.new('0.0094007411')
    actual = Refinance::Annuities.interest_rate(payment, periods, principal,
      guess, extreme_precision, 10, 4)

    assert_in_delta expected, actual, BigDecimal.new('0.0000000001')
  end

  def test_payment
    # Based on Example 2 in http://oakroadsystems.com/math/loan.htm .
    interest_rate = BigDecimal.new('0.0065')
    periods = BigDecimal.new('360')
    principal = BigDecimal.new('225000')

    expected = BigDecimal.new('1619.708627')
    actual = Refinance::Annuities.payment(interest_rate, periods, principal)

    assert_in_delta expected, actual, BigDecimal.new('0.000001')
  end

  def test_periods
    # Based on Example 3 in http://oakroadsystems.com/math/loan.htm .
    interest_rate = BigDecimal.new('0.005')
    payment = BigDecimal.new('100')
    principal = BigDecimal.new('3500')

    expected = BigDecimal.new('38.57')
    actual = Refinance::Annuities.periods(interest_rate, payment, principal)

    assert_in_delta expected, actual, BigDecimal.new('0.01')
  end

  def test_principal
    # Based on Example 5 in http://oakroadsystems.com/math/loan.htm .
    interest_rate = BigDecimal.new('0.014083')
    payment = BigDecimal.new('60')
    periods = BigDecimal.new('36')

    expected = BigDecimal.new('1685.26') # Example fudges to 1685.25.
    actual = Refinance::Annuities.principal(interest_rate, payment, periods)

    assert_in_delta expected, actual, BigDecimal.new('0.01')
  end

  def test_effective_interest_rate
    nominal_annual_interest_rate = BigDecimal.new('0.1')
    compounding_periods_per_year = BigDecimal.new('12')

    expected = BigDecimal.new('0.10471')
    actual = Refinance::Annuities.effective_interest_rate(
      nominal_annual_interest_rate, compounding_periods_per_year)

    assert_in_delta expected, actual, BigDecimal.new('0.00001')
  end
end
