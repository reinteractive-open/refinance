require 'bigdecimal'

module Refinance
  module Annuities
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

    def self.improve_interest_rate(payment, periods, principal, guess)
      top = payment - (payment * ((guess + 1) ** -periods)) -
        (principal * guess)
      bottom = (periods * payment * ((guess + 1) ** (-periods - 1))) -
        principal
      guess - (top / bottom)
    end

    def self.payment(interest_rate, periods, principal)
      interest = BigDecimal.new(interest_rate, 0)
      periods = BigDecimal.new(periods, 0)
      principal = BigDecimal.new(principal, 0)

      (interest_rate * principal) / (1 - ((interest_rate + 1) ** -periods))
    end

    def self.periods(interest_rate, payment, principal)
      interest_rate = BigDecimal.new(interest_rate, 0)
      payment = BigDecimal.new(payment, 0)
      principal = BigDecimal.new(principal, 0)

      -Math.log(1 - ((interest_rate * principal) / payment)) /
        Math.log(interest_rate + 1)
    end

    def self.principal(interest_rate, payment, periods)
      interest_rate = BigDecimal.new(interest_rate, 0)
      payment = BigDecimal.new(payment, 0)
      periods = BigDecimal.new(periods, 0)

      (payment / interest_rate) * (1 - ((interest_rate + 1) ** -periods))
    end
  end
end
