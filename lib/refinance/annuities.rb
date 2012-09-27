module Refinance

  ##
  # This module contains methods for calculating the basic properties of
  # annuities. Annuities are assumed to be an annuities immediate (that is,
  # interest is accumulated before the payment).
  #
  # The floating-point numbers you pass in as arguments can be instances of
  # Float or BigDecimal. Actually, thanks to duck typing, they can be any
  # objects that support the necessary operations.
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
    def self.interest_rate(payment, periods, principal, initial_guess = 0.1,
      precision = 0.0001, max_decimals = 8, max_iterations = 10)
      guess = initial_guess

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
      (payment / interest_rate) * (1 - ((interest_rate + 1) ** -periods))
    end

    ##
    # Determines the effective interest rate, given:
    #
    # * The nominal annual interest rate
    # * The number of compounding periods per year
    #
    def self.effective_interest_rate(nair, cppy)
      (((nair / cppy) + 1) ** cppy) - 1
    end
  end
end
