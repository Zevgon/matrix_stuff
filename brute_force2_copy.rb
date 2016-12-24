require 'set'
require 'matrix'

def num_uniques(r, c, s)
	uniques = Hash.new{|h, k| h[k] = []}
	relevant_matrices = upper_right_triangle(r, c, s)
	count = 0
	relevant_matrices.each do |m|
		uniques[essence_of(m)] << m
	end
	# uniques.each do |k, v|
	# 	print k
	# 	print ' => '
	# 	print v
	# 	puts
	# end
	# p count
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

def reduce
end


# def write_all(r, c, s)
# 	matrix_file = File.open('./matrices.txt', 'w')
# 	all_matrices = create_all(r, c, s)
# 	all_matrices.each do |m|
# 		matrix_file.write(' _' * c + "\n")
# 		m.each do |row|
# 			matrix_file.write('|')
# 			row.each do |num|
# 				matrix_file.write(num.to_s + '|')
# 			end
# 			matrix_file.write("\n")
# 		end
# 		matrix_file.write(' -' * c + "\n")
# 	end
# 	matrix_file.close
# end

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

# p pos_of(2, 2, 3, 3, 5)

def essence_of(m)
	rows = []
	cols = []
	m.each do |row|
		rows << row.sort
	end
	idx = 0
	while idx < m[0].length
		col = []
		m.each do |row|
			col << row[idx]
		end
		cols << col.sort
		idx += 1
	end

	rows.sort + cols.sort
end


p upper_right_triangle(2, 3, 2)
