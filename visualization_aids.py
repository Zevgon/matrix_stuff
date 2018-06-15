from helpers import *

def arrangements(n):
	if n == 2:
		return [[[1, 1], [0, 0]], [[1, 0], [0, 1]], [[1, 0], [1, 0]]]
	prev = arrangements(n - 1)
	new_list = []
	for matrix in prev:
		new_matrix = []
		for idx, row in enumerate(matrix):
			if idx == 0:
				new_row = list(row)
				new_row.insert(0, 1)
			else:
				new_row = list(row)
				new_row.insert(0, 0)
			new_matrix.append(new_row)
		last_line = [0 for i in range(len(matrix[0]) + 1)]
		new_matrix.append(last_line)
		new_list.append(new_matrix)

	for matrix in prev:
		first_row = [0 for i in range(len(matrix[0]) + 1)]
		first_row[0] = 1
		new_matrix = [first_row]
		for row in matrix:
			new_row = list(row)
			new_row.insert(0, 0)
			new_matrix.append(new_row)
		new_list.append(new_matrix)

	for matrix in prev:
		first_row = [0 for i in range(len(matrix[0]) + 1)]
		first_row[0] = 1
		new_matrix = [first_row]
		for row in matrix:
			new_row = list(row)
			new_row.append(0)
			new_matrix.append(new_row)
		new_list.append(new_matrix)
	return new_list

def show_arrangements(n):
	arrs = arrangements(n)
	idx = 1
	print
	for matrix in arrs:
		print('({0})'.format(idx))
		for row in matrix:
			for num in row:
				if num == 0:
					print(' '),
				else:
					print(num),
			print
		print
		print
		print
		idx += 1

def show_arrangements_in_groups(arrs, group_size):
	size = len(arrs[0])
	idx = 0
	while idx < len(arrs):
		print(' ' * (size + 4)),
		for matrix_id in range(idx, idx + group_size):
			print('({0})'.format(matrix_id + 1)),
			num_length = len(str(matrix_id))
			print(' ' * (size * 2 + 3 - num_length)),
		print
		next_group = arrs[idx:idx + group_size]
		zipped = zip(*next_group)
		for row_group in zipped:
			for row in row_group:
				print('      '),
				for num in row:
					if num == 0:
						print(' '),
					else:
						print(num),
			print
		print
		print
		idx += group_size


n = 5
show_arrangements_in_groups(arrangements(n), 9)

arrs = arrangements(n)
counts = similarity_counts(arrs, 2)
sim_group = group_by_similarity(counts)
sim_group.sort()
firsts_and_sizes = first_of_group_and_group_size(sim_group)
members_in_group_map = num_members_in_group_by_matrix_id(sim_group)
members_in_group_map = each_slice(members_in_group_map, 3)
# print(group_counts(counts))
# print
# print(sim_group)
# print
# print(firsts_and_sizes)
# print
# print(group_by_num_in_group(firsts_and_sizes))

idx = 1
for three in members_in_group_map:
	print('                             '),
	print(str(idx) + ' ' * (3 - len(str(idx)))),
	print three
	idx += 1
