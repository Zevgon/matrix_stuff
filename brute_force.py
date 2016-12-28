http://www-cs-students.stanford.edu/~blynn//polya/cycleindex.html

from collections import Set

def answer(r, c, s):
	uniques = set()
	all_matrices = create_all(r, c, s)
	for m in all_matrices:
		uniques.add(str(essence_of(m, s)))
	l = list(uniques)
	l.sort()
	print l
	return str(len(uniques))

def essence_of(m, s):
	rows = row_essences(m, s)
	cols = col_essences(m, s)
	return rows + cols

def row_essences(m, s):
	essences = [[0] * s for _ in range(len(m))]
	row_idx = 0
	while row_idx < len(m):
		row = m[row_idx]
		for col_idx, num in enumerate(row):
			essences[row_idx][num] += 1
		row_idx += 1
	essences.sort()
	return essences

def col_essences(m, s):
	essences = [[0] * s for _ in range(len(m[0]))]
	idx = 0
	while idx < len(m[0]):
		for row in m:
			num = row[idx]
			essences[idx][num] += 1
		idx += 1
	essences.sort()
	return essences

def create_all(r, c, s):
	return all_possible_ms(all_possible_rows(c, s), r)

def all_possible_rows(c, s):
	if c == 0:
		return [[]]
	prev = all_possible_rows(c - 1, s)
	next_arr = []
	for combo in prev:
		for num in range(s):
			arr = deep_dup(combo)
			arr.append(num)
			next_arr.append(arr)
	return next_arr

def all_possible_ms(rows, num_rows):
	if num_rows == 0:
		return [[]]
	prev = all_possible_ms(rows, num_rows - 1)
	next_arr = []
	for m in prev:
		for row in rows:
			new_m = deep_dup(m)
			new_m.append(row)
			next_arr.append(new_m)
	return next_arr

def deep_dup(arr):
	result = []
	for el in arr:
		if el.__class__() == []:
			result.append(deep_dup(el))
		else:
			result.append(el)
	return result

print(answer(2, 2, 3))
