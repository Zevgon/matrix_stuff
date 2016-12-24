require 'set'

def factorial(n)
	idx = 1
	prod = 1
	while idx <= n
		prod *= idx
		idx += 1
	end
	prod
end

def num_uniques(num, base = 2)
	top = base ** num - 1
	set1 = Set.new
	set2 = Set.new
	uniques = []
	while top >= 0
		str = top.to_s(base).rjust(num, '0')
		set1 << str
		top -= 1
	end
	set1.each do |bin|
		uniques << bin unless set2.include?(bin.reverse)
		set2 << bin
	end
	uniques.length

	# half = num / 2
	# multiplier = base ** (half - 1) * (1 + base ** half)
	# num.odd? ? multiplier * 2 : multiplier

	# numerator = factorial(num * 2)
	# denomenator = (factorial(num) * (factorial(num + 1)))
	# multiplier = numerator / denomenator
	# multiplier * (base ** num)
end

# base = 4
# p num_uniques(1, base)
# p num_uniques(2, base)
# p num_uniques(3, base)
# p num_uniques(4, base)
# p num_uniques(5, base)
# p num_uniques(6, base)
# p num_uniques(7, base)
# p num_uniques(8, base)
# p num_uniques(9, base)
# p num_uniques(10, base)


def combos(num, base)
	return [[]] if num == 0
	prev = combos(num - 1, base)
	new_arr = []
	new_num = 0
	while new_num < base
		prev.each do |el|
			new_arr << el + [new_num]
		end
		new_num += 1
	end

	new_arr.map{|el| el.sort}.uniq
end

def num_combos(num, base)
	combos(num, base).length
end

p num_combos(4, 2)
