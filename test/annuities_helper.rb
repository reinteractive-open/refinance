module AnnuitiesHelper
  def assert_improve_interest_rate options
    actual = Refinance::Annuities.improve_interest_rate(
      options.fetch(:payment),
      options.fetch(:periods),
      options.fetch(:principal),
      options.fetch(:guess))

    assert_in_delta options.fetch(:expected), actual, options.fetch(:delta)
  end

  def assert_interest_rate_stops_if_improvement_is_small options
    actual = Refinance::Annuities.interest_rate(options.fetch(:payment),
      options.fetch(:periods), options.fetch(:principal),
      options.fetch(:guess), options.fetch(:precision))

    assert_in_delta options.fetch(:expected), actual, options.fetch(:delta)
  end

  def assert_interest_rate_does_multiple_iterations options
    actual = Refinance::Annuities.interest_rate(options.fetch(:payment),
      options.fetch(:periods), options.fetch(:principal),
      options.fetch(:guess), options.fetch(:precision),
      options.fetch(:max_decimals), options.fetch(:max_iterations))

    assert_in_delta options.fetch(:expected), actual, options.fetch(:delta)
  end

  def assert_payment options
    actual = Refinance::Annuities.payment(options.fetch(:interest_rate),
      options.fetch(:periods), options.fetch(:principal))

    assert_in_delta options.fetch(:expected), actual, options.fetch(:delta)
  end

  def assert_periods options
    actual = Refinance::Annuities.periods(options.fetch(:interest_rate),
      options.fetch(:payment), options.fetch(:principal))

    assert_in_delta options.fetch(:expected), actual, options.fetch(:delta)
  end

  def assert_principal options
    actual = Refinance::Annuities.principal(options.fetch(:interest_rate),
      options.fetch(:payment), options.fetch(:periods))

    assert_in_delta options.fetch(:expected), actual, options.fetch(:delta)
  end

  def assert_effective_interest_rate options
    actual = Refinance::Annuities.effective_interest_rate(
      options.fetch(:nominal_annual_interest_rate),
      options.fetch(:compounding_periods_per_year))

    assert_in_delta options.fetch(:expected), actual, options.fetch(:delta)
  end
end
