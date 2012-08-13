#!/usr/bin/env ruby

require 'newton_utils'

module Finance

	def pmt(n, r, pv = 0, fv = 0)
		if pv == 0
			if fv != 0
				return fv * r / (1 + r**n - 1)
			end
		else fv == 0
			return pv * r / (1 - (1 + r)**-n)
		end
		0
	end

	def pv(n, r, pmt)
		pmt * (1 - (1 + r)**-n) / r;
	end

	def fv(n, r, pmt)
		pmt * ((1 + r)**n - 1) / r
	end

	def irr(values, guess = 1)
		x = [guess]
		f = FunctionBase.new
		f.class.instance_eval do
			define_method :values do |x|
				res = values[0]
				t = 1 + x[0]
				for i in 1..values.length-1
					res += values[i] / t**i
				end
				[res]
			end
		end
		nlsolve(f, x)
		x
	end

	def npv(values, r)
		res = values[0]
		t = 1 + r
		for i in 1..values.length-1
			res += values[i] / t**i
		end
		res
	end

	BigDecimal::limit(100)

end
