#!/usr/bin/env ruby

# nlsolve.rb
# An example for solving nonlinear algebraic equation system.
#

require "bigdecimal"
require "bigdecimal/newton"
include Newton

class FunctionBase
  def initialize()
    @zero = BigDecimal::new("0.0")
    @one  = BigDecimal::new("1.0")
    @two  = BigDecimal::new("2.0")
    @ten  = BigDecimal::new("10.0")
    @eps  = BigDecimal::new("1.0e-16")
  end
  def zero;@zero;end
  def one ;@one ;end
  def two ;@two ;end
  def ten ;@ten ;end
  def eps ;@eps ;end
end
