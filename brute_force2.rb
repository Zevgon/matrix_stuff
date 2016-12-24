require 'set'

def num_uniques(r, c, s)
	uniques = Hash.new{|h, k| h[k] = []}
	all_matrices = create_all(r, c, s)
	all_matrices.each do |m|
		uniques[essence_of(m)] << m
	end
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

p num_uniques(2, 3, 4)
