# Refinance

Refinance is a Ruby gem that provides a collection of finance algorithms.
Currently, it contains algorithms for calculating the properties of ordinary
annuities: principal, interest rate, number of payment periods, and payment
amount.

## Introduction

Refinance does calculations related to
[annuities](http://en.wikipedia.org/wiki/Annuity_%28finance_theory%29) in
finance theory. In general, an annuity is a finite series of regular payments;
an installment loan for a car is an example that might be familiar to you.

Refinance allows you to answer questions like these:

1. Say you have a car loan and are paying a fixed amount each month to pay it
off. If you got a reduced interest rate, exactly how much lower would your
monthly payments be?

2. If you get a reduced interest rate but continue to pay the same monthly
payments, exactly how much shorter will the loan duration be?

3. Say you want to borrow money to buy a car. If your bank will lend you money
at an X% annual interest rate, and you're willing to make monthly payments as
high as $Y, how expensive of a car can you buy?

4. Say you're making monthly payments of $X to pay off a $Y loan. What interest
rate are you being charged?

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

We want to calculate the monthly payment, so we'll use the method
Refinance::Annuities.payment. That method requires three arguments: the
interest rate (*per month*, since we're calculating the monthly payment), the
total number of monthly payments, and the principal. These are easy to
determine from the example:

* The interest rate is 7.8%, but there are two things to note here. First, 7.8%
is a [nominal annual rate](http://en.wikipedia.org/wiki/Nominal_interest_rate),
and we want the monthly interest rate. So we divide 7.8% by 12 (because there
are 12 months in a year) and get 0.65%. Second, the method wants the argument
in decimal form, not percent form, so 0.65% becomes 0.0065.

* The loan lasts 30 years, and we want the number of payment periods -- that
is, the number of months. 30 years is 360 months.

* The house's purchase price is $250,000, and we're making a 10% down payment,
so the loan's principal will be 90% of $250,000, or $225,000.

Now we can call the method:

    Refinance::Annuities.payment 0.0065, 360.0, 225000.0

(You can name the arguments "interest rate", "periods", and "principal". For
this and related methods, the arguments go in alphabetical order.)

The return value is 1619.7086268909618. So the monthly payment is about
$1,619.71.


## API

Here's a summary of the public-facing methods provided by this library. They
are all stateless "functions".

Arguments to these methods are not directly converted to a particular numeric
type; they can be any objects that support the necessary mathematical methods.
Instances of Float and BigDecimal will work for real-valued arguments.

Interest rates must be in decimal form, not percent form.


### Refinance::Annuities.interest_rate

This method calculates an annuity's interest rate over its payment period. The
result will be given as a decimal number, not as a percent. There is no
closed-form solution for this, so the answer is iteratively approximated with
the
[Newton-Raphson method](http://en.wikipedia.org/wiki/Newton-raphson_method).

Arguments:

1. The periodic payment amount.
2. The total number of payment periods.
3. The principal.
4. (Optional) The initial guess at the interest rate.
5. (Optional) The precision; the algorithm will stop if the magnitude of the
last improvement was less than this.
6. (Optional) The maximum number of decimal places. After each iteration, the
guess will be rounded to this many decimal places.
7. (Optional) The maximum number of iterations to allow.


### Refinance::Annuities.payment

This method calculates an annuity's periodic payment amount.

Arguments:

1. The interest rate over one payment period.
2. The total number of payment periods.
3. The principal.


### Refinance::Annuities.periods

This method calculates the total number of payment periods for an annuity.

Arguments:

1. The interest rate over one payment period.
2. The periodic payment amount.
3. The principal.


### Refinance::Annuities.principal

This method calculates the principal of an annuity.

Arguments:

1. The interest rate over one payment period.
2. The periodic payment amount.
3. The total number of payment periods.


### Refinance::Annuities.effective_interest_rate

This method calculates the effective annual interest rate.

Arguments:

1. The nominal annual interest rate.
2. The number of compounding periods per year.


## Implementation

The algorithms are simple rather than fast and
[numerically stable](http://en.wikipedia.org/wiki/Numerical_stability). At
present, they deal only with _annuities immediate_ (in which the interest is
accumulated _before_ the payment), not _annuities due_ (in which the interest
is accumulated _after_ the payment).


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

Thanks to Stan Brown for his paper
_[Loan or Investment Formulas](http://oakroadsystems.com/math/loan.htm)_. It is
an excellent introduction to the mathematics of annuities, and we used some of
its examples as test cases.
