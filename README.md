# Refinance

Refinance is a Ruby gem that provides a collection of finance algorithms.
Currently, it contains algorithms for calculating the properties of ordinary
annuities: principal, interest rate, number of payment periods, and payment
amount.

The algorithms are simple rather than fast and numerically robust. Thanks to
duck typing, they work with both BigDecimals and Floats. At present, they deal
only with _annuities immediate_ (in which the interest is accumulated _before_
the payment), not _annuities due_ (in which the interest is accumulated _after_
the payment). There are many opportunities for extension and improvement.

## Requirements

This library is tested with versions 1.9.3 and 2.0.0 of MRI (Matz's Ruby
Interpreter). It also works with version 1.9.2 if you only use Float, not
BigDecimal, for floating-point values.

## Installation

Add this line to your application's Gemfile:

    gem 'refinance'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install refinance

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Authorship and copyright information

This software was written by [reInteractive](http://reinteractive.net/), a
software consulting company in Sydney, Australia. It is distributed under the
MIT License; see LICENSE.txt for details.

## Acknowledgements

Thanks to Stan Brown for his paper _[Loan or Investment
Formulas](http://oakroadsystems.com/math/loan.htm)_. It is an excellent
introduction to the mathematics of annuities, and we used some of its examples
as test cases.
