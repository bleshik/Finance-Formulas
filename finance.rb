#!/usr/bin/env ruby

require './newton_utils.rb'

module Finance

	def pmt(n, r, pv = 0, fv = 0)
		return pv * r / (1 - (1 + r)**-n) + fv * r / ((1 + r)**n - 1)
	end

	def paf(r, n, g)
		(1-((1+g)/(1+r))**n)/(r-g)
	end

	def pv(n, r, pmt, fv = 0)
		pmt * (1 - (1 + r)**-n) / r + fv / (1 + r)**n
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
		x[0]
	end

	def npv(values, r)
		res = values[0]
		t = 1 + r
		for i in 1..values.length-1
			res += values[i] / t**i
		end
		res
	end

	def m(valuesWithProb)
		res = 0
		for i in 0..valuesWithProb.length-1
			res += valuesWithProb[i][0] * valuesWithProb[i][1]
		end
		res
	end

	def d(valuesWithProb)
		m = m(valuesWithProb)
		res = 0
		for i in 0..valuesWithProb.length-1
			res += (valuesWithProb[i][0] - m) ** 2 * valuesWithProb[i][1]
		end
		res
	end

	def cov(valuesWithProb0, valuesWithProb1)
		m0 = m(valuesWithProb0)
		m1 = m(valuesWithProb1)
		common = []
		for i in 0..valuesWithProb0.length-1
			for j in 0..valuesWithProb1.length-1
				com_val = [valuesWithProb0[i][0] * valuesWithProb1[j][0], valuesWithProb0[i][1] * valuesWithProb1[j][1]]
				found = false
				for k in 0..common.length-1
					if common[k][0] == com_val[0]
						common[k][1] += com_val[1]
						found = true
						break
					end
				end
				if !found
					common << com_val
				end
			end
		end
		m(common) - m0 * m1
	end

	def selection_cor(values0, values1)
		m0 = mean(values0)
		m1 = mean(values1)
		res0 = 0
		res1 = 0
		res2 = 0
		for i in 0..values0.length-1
			res0 += (values0[i] - m0) * (values1[i] - m1)
			res1 += (values0[i] - m0) ** 2.0
			res2 += (values1[i] - m1) ** 2.0
		end
		res0 / (res1 * res2) ** 0.5
	end

	def mean(values)
		res = 0
		m = values.length
		for i in 0..m-1
			res += values[i] / m
		end
		res
	end

	BigDecimal::limit(100)

end
