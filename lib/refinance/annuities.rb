require 'bigdecimal'

module Refinance

  ##
  # This module contains methods for calculating the basic properties of
  # annuities. Annuities are assumed to be an annuities immediate (that is,
  # interest is accumulated before the payment).
  #
  # These methods convert most arguments to BigDecimal by passing them to
  # +BigDecimal.new+. This means you can pass in numbers in many different
  # forms: Integer, Float, Rational, BigDecimal, or String.
  #
  module Annuities

    ##
    # Determine an annuity's interest rate over some period, given:
    #
    # * Periodic payment amount
    # * Number of payment periods
    # * Principal
    #
    # This has no closed-form solution, so the answer is iteratively
    # approximated with the Newton-Raphson method. After each improvement, the
    # guess will be rounded; _max_decimals_ is the number of decimal places to
    # keep (if you set this high, the algorithm will be slow). _max_iterations_
    # is the maximum number of iterations that will be attempted. It will stop
    # iterating if the last improvement was less than _precision_ in magnitude.
    #
    def self.interest_rate(payment, periods, principal,
      initial_guess = BigDecimal.new('0.1'),
      precision = BigDecimal.new('0.0001'), max_decimals = 8,
      max_iterations = 10)

      payment = BigDecimal.new(payment, 0)
      periods = BigDecimal.new(periods, 0)
      principal = BigDecimal.new(principal, 0)
      guess = BigDecimal.new(initial_guess, 0)
      precision = BigDecimal.new(precision, 0)

      max_iterations.times do
        new_guess = improve_interest_rate(payment, periods, principal, guess).
          round(max_decimals)
        difference = (guess - new_guess).abs
        guess = new_guess
        break if difference < precision
      end

      guess
    end

    ##
    # Iteratively improve an approximated interest rate for an annuity using
    # the Newton-Raphson method. This method is used by ::interest_rate.
    #
    def self.improve_interest_rate(payment, periods, principal, guess)
      top = payment - (payment * ((guess + 1) ** -periods)) -
        (principal * guess)
      bottom = (periods * payment * ((guess + 1) ** (-periods - 1))) -
        principal
      guess - (top / bottom)
    end

    ##
    # Determine an annuity's periodic payment amount, given:
    #
    # * Interest rate over a period
    # * Number of payment periods
    # * Principal
    #
    def self.payment(interest_rate, periods, principal)
      interest = BigDecimal.new(interest_rate, 0)
      periods = BigDecimal.new(periods, 0)
      principal = BigDecimal.new(principal, 0)

      (interest_rate * principal) / (1 - ((interest_rate + 1) ** -periods))
    end

    ##
    # Determine the number of payment periods for an annuity, given:
    #
    # * Interest rate over a period
    # * Periodic payment amount
    # * Principal
    #
    def self.periods(interest_rate, payment, principal)
      interest_rate = BigDecimal.new(interest_rate, 0)
      payment = BigDecimal.new(payment, 0)
      principal = BigDecimal.new(principal, 0)

      -Math.log(1 - ((interest_rate * principal) / payment)) /
        Math.log(interest_rate + 1)
    end

    ##
    # Determine an annuity's principal, given:
    #
    # * Interest rate over a period
    # * Periodic payment amount
    # * Number of payment periods
    #
    def self.principal(interest_rate, payment, periods)
      interest_rate = BigDecimal.new(interest_rate, 0)
      payment = BigDecimal.new(payment, 0)
      periods = BigDecimal.new(periods, 0)

      (payment / interest_rate) * (1 - ((interest_rate + 1) ** -periods))
    end

    ##
    # Determines the effective interest rate, given:
    #
    # * The nominal annual interest rate
    # * The number of compounding periods per year
    #
    def self.effective_interest_rate(nominal_annual_interest_rate,
      compounding_periods_per_year)
      nair = BigDecimal.new(nominal_annual_interest_rate, 0)
      cppy = BigDecimal.new(compounding_periods_per_year, 0)

      (((nair / cppy) + 1) ** cppy) - 1
    end
  end
end
