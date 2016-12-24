require 'set'

def num_uniques(r, c, s)
	uniques = Hash.new{|h, k| h[k] = []}
	all_matrices = create_all(r, c, s)
	all_matrices.each do |m|
		uniques[essence_of(m, s)] << m
	end
	counts = Hash.new(0)
	total = 0
	uniques = uniques.sort_by{|k, v| v.length}
	# uniques.each do |k, v|
	# 	print k
	# 	print ' => '
	# 	print v.length
	# 	total += v.length
	# 	counts[v.length] += 1
	# 	puts
	# end
	# puts
	# puts
	# puts
	# puts counts
	# puts total
	uniques.length
end

def format_hash(h)
	h.each do |k, v|
		print k
		print ' => '
		print v.length
		puts
	end
end

def essence_of(m, s)
	rows = row_essences(m, s)
	cols = col_essences(m, s)
	rows + cols
end

def row_essences(m, s)
	essences = Array.new(m.length) {Array.new(s, 0)}
	m.each.with_index do |row, row_idx|
		row.each.with_index do |num, col_idx|
			essences[row_idx][num] += 1
		end
	end

	essences.sort
end

def col_essences(m, s)
	essences = Array.new(m[0].length) {Array.new(s, 0)}
	idx = 0
	while idx < m[0].length
		m.each.with_index do |row|
			num = row[idx]
			essences[idx][num] += 1
		end
		idx += 1
	end

	essences.sort
end

def create_all(r, c, s)
	all_possible_ms(all_possible_rows(c, s), r)
end

def all_possible_rows(c, s)
	return [[]] if c == 0
	prev = all_possible_rows(c - 1, s)
	next_arr = []
	prev.each do |combo|
		(0...s).each do |num|
			arr = combo.dup
			next_arr << arr.push(num)
		end
	end
	next_arr
end

def all_possible_ms(rows, num_rows)
	return [[]] if num_rows == 0
	prev = all_possible_ms(rows, num_rows - 1)
	next_arr = []
	prev.each do |m|
		rows.each do |row|
			new_m = deep_dup(m)
			new_m << row
			next_arr << new_m
		end
	end

	next_arr
end

def deep_dup(arr)
	result = []
	arr.each do |el|
		if el.is_a?(Array)
			result << deep_dup(el)
		else
			result << el
		end
	end

	result
end

# m = [[0, 0, 1], [1, 1, 1], [2, 1, 1]]
# p essence_of(m, 3)


# def seq(n)
# 	arr = [1]
# 	counter = 2
# 	until arr.length == n
# 		arr << arr[-1] + counter
# 		counter += 1
# 	end
#
# 	arr
# end
#
# p seq(70)


p num_uniques(3, 3, 2)
