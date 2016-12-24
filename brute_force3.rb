#This version considers the following matrices to be different, whereas brute_force2 does not:

#1 1 0
#0 0 1
#0 0 1

#1 1 0
#0 1 0
#0 0 1

'110001001'
'110010001'

require 'set'
require 'matrix'

def num_uniques(r, c, s)
	uniques = Hash.new{|h, k| h[k] = []}
	all_matrices = create_all(r, c, s)
	all_matrices.each do |m|
		uniques[reduce(m, s)] << m
	end
	# uniques.each do |k, v|
	# 	print k
	# 	print ' => '
	# 	print v
	# 	puts
	# end
	uniques.length
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

def essence_of(m)
	rows = m.dup.sort
	cols = m.transpose.sort
	[rows, cols]
end

def reduce(m, s)
	# result = []
	# m.sort.each do |row|
	# 	idx = 0
	# 	sorted = row.sort
	# 	while idx < row.length
	# 		sorted_dup = sorted.dup
	# 		sorted_dup.delete_at(row.index(row[idx]))
	# 		result << sorted_dup
	# 		idx += 1
	# 	end
	# end
	# p result
	#
	# m.transpose.sort.each do |row|
	# 	idx = 0
	# 	sorted = row.sort
	# 	while idx < row.length
	# 		sorted_dup = sorted.dup
	# 		sorted_dup.delete_at(row.index(row[idx]))
	# 		result << sorted_dup
	# 		idx += 1
	# 	end
	# end
	#
	# result
	t = m.transpose
	res = row_essences(m, s)
	ces = col_essences(m, s)
	h = Hash.new{|h, k| h[k] = []}
	#For matrix [[0, 1], [0, 0]]
	#Want this hash to look like: {1 => [[[2, 1], [3, 0]], [[2, 1], [2, 2]]]}
	idx = 0
	while idx < m.length
		idx2 = 0
		row = m[idx]
		col = t[idx]
		while idx2 < row.length
			num = row[idx2]
			cur_res = res[idx].dup
			cur_ces = ces[idx2].dup
			cur_res[num] -= 1
			cur_ces[num] -= 1
			h[num] << [cur_res, cur_ces]
			idx2 += 1
		end


		# row = m[idx]
		# col = t[idx]
		# row.each do |num|
		# 	res_dup = res[idx].dup
		# 	res_dup[num] -= 1
		# 	h[num][0] << res_dup
		# end
		#
		# col.each do |num|
		# 	ces_dup = ces[idx].dup
		# 	ces_dup[num] -= 1
		# 	h[num][1] << ces_dup
		# end


		idx += 1
	end
	new_h = {}
	h.each do |k, v|
		new_h[k] = v.sort
	end
	new_h
end

def row_essences(m, s)
	essences = Array.new(m.length) {Array.new(s, 0)}
	m.each.with_index do |row, row_idx|
		row.each.with_index do |num, col_idx|
			essences[row_idx][num] += 1
		end
	end

	essences
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

	essences
end

def all_diagonals(r, c, s)
	rows = all_possible_rows(c, s)
	ms = []
	rows.each do |row|
		ms << [row] * r
	end

	ms
end


def nth_matrix(n, r, c, s)
	#Convert n to base s
	number = n.to_s(s)

	#Rjust that to make length c * r (prepend zeroes)
	number = number.rjust(c * r, '0')

	#Split that into parts of length c
	number.split("").map(&:to_i).each_slice(c).to_a
end

def upper_right_triangle(r, c, s)
	row_count = 0
	ms = []
	while row_count < s ** c
		col_count = row_count
		while col_count < s ** r
			pos = pos_of(r, c, s, row_count, col_count)
			ms << nth_matrix(pos, r, c, s)
			col_count += 1
		end
		row_count += 1
	end

	ms
end

def pos_of(r, c, s, r_num, c_num)
	num_columns = s ** c
	num_rows = s ** r
	r_num * num_columns + c_num
end

# m1 = [[1, 0], [0, 0]]
# m2 = [[0, 1], [0, 0]]
# p reduce(m1, 2)
# p reduce(m2, 2)

p num_uniques(3, 3, 2)
