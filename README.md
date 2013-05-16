# Refinance

Refinance is a Ruby gem that provides a collection of finance algorithms.
Currently, it contains algorithms for calculating the properties of ordinary
annuities: principal, interest rate, number of payment periods, and payment
amount.

## Introduction

Refinance does calculations related to _annuities_ in finance theory. Annuities
are like installment loans. Refinance allows you to answer questions like
these:

1. Say you have a car loan and are making monthly payments -- the same amount
each month -- to pay it off. If you got a reduced interest rate, exactly how
much lower would your monthly payments be?

2. If you get a reduced interest rate but continue to pay the same monthly
payments, exactly how much shorter will the loan duration be?

3. Say you want to borrow money to buy a car. If your bank will lend you money
at an X% annual interest rate, and you're willing to make monthly payments as
high as $Y, how expensive of a car can you buy?

4. Say you're making monthly payments of $X to pay off a $Y loan. What
per-month interest rate are you being charged?

5. Say your loan has an interest rate of X% per month. What is its effective
_annual_ interest rate?

Annuities have four defining properties (at least for our purposes), and the
first four questions above provide examples of each: The first question is
asking for the annuity's _periodic payment amount_. The second is asking for
the _number of remaining payments_. The third is asking for the _principal_.
And the fourth is asking for the _interest rate_.

In general, if you know three of those properties, Refinance can calculate
the fourth.

The fifth question is about converting an interest rate. Perhaps you think this
is trivial: if you're paying 1% per month, then it's equivalent to paying 12%
per year, right? Wrong. It's more like 12.68%. You need to account for the
effects of [compound interest](http://en.wikipedia.org/wiki/Compound_interest).


## Usage example

I'll use [Example 2 from Stan Brown's paper](http://oakroadsystems.com/math/loan.htm#Sample2):

> You are buying a $250,000 house, with 10% down, on a 30-year mortgage at a
> fixed rate of 7.8%. What is the monthly payment?

We know (or can easily determine) the interest rate, the number of payment
periods, and the principal. We want Refinance to calculate the periodic
payment, so we'll use the method Refinance::Annuities.payment.

The interest rate is 7.8%, but there are two things to note here. First, the
method wants the interest rate passed in decimal form, so 7.8% becomes 0.078.
Second, since we're asking about the monthly payment, we want the per-month
interest rate, so 0.078 becomes 0.078 / 12, or 0.0065.

The loan lasts 30 years, and we want the number of payment periods (that is,
the number of months). 30 years is 360 months.

The house's purchase price is $250,000, and we're making a 10% down payment, so
the loan's principal will be 250000 * 0.9, or 225000.

Now we can call the method:

  Refinance::Annuities.payment 0.0065, 360.0, 225000.0

(You can name the arguments "interest rate", "periods", and "principal". For
this and related methods, the arguments go in alphabetical order.)

The return value is 1619.7086268909618. So the monthly payment is about
$1,619.71.

In the example above, I passed floats as the arguments. The annuity methods do
not directly convert their arguments to floats, BigDecimals, or anything else;
they use duck typing, so you can pass any object you want, as long as they
implement the necessary mathematical methods. BigDecimals will work fine in
Ruby 1.9.3 and later.


## Implementation

The algorithms are simple rather than fast and [numerically
stable](http://en.wikipedia.org/wiki/Numerical_stability). Thanks to duck
typing, they work with both BigDecimals and Floats. At present, they deal only
with _annuities immediate_ (in which the interest is accumulated _before_ the
payment), not _annuities due_ (in which the interest is accumulated _after_ the
payment).


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
