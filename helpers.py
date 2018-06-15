from collections import defaultdict

def sigma(start_or_set, end = None, lam = None):
	if lam == None:
		lam = lambda x: x
	if start_or_set.__class__ == int:
		if end == None:
			raise "Must provide an end number"
		else:
			start_or_set = [i for i in range(start_or_set, end + 1)]
	total = 0
	for el in start_or_set:
		total += lam(el)
	return total

def row_essences(m, s):
	essences = []
	for _ in range(len(m)):
		default_el = []
		for _ in range(s):
			default_el.append(0)
		essences.append(default_el)
	row_idx = 0
	while row_idx < len(m):
		row = m[row_idx]
		for col_idx, num in enumerate(row):
			essences[row_idx][num] += 1
		row_idx += 1
	return essences

def transpose(m):
	idx = 0
	result = []
	while idx < len(m[0]):
		next_list = []
		for row in m:
			next_list.append(row[idx])
		result.append(next_list)
		idx += 1
	return result

def col_essences(m, s):
	t = transpose(m)
	return row_essences(t, s)

def reduce_matrix(m, s):
	t = transpose(m)
	res = row_essences(m, s)
	ces = col_essences(m, s)
	h = defaultdict(list)
	#For matrix [[0, 1], [0, 0]]
	#Want this hash to look like: {1 => [[[2, 1], [3, 0]], [[2, 1], [2, 2]]]}
	idx = 0
	while idx < len(m):
		idx2 = 0
		row = m[idx]
		col = t[idx]
		while idx2 < len(row):
			num = row[idx2]
			cur_res = list(res[idx])
			cur_ces = list(ces[idx2])
			cur_res[num] -= 1
			cur_ces[num] -= 1
			h[num].append([cur_res, cur_ces])
			idx2 += 1

		idx += 1

	new_dict = {}
	for k in h:
		v = h[k]
		v.sort()
		new_dict[k] = v
	return new_dict

def similar(m1, m2, s):
	return reduce_matrix(m1, s) == reduce_matrix(m2, s)

def similarity_counts(ms, s):
	d = {}
	idx = 1
	for m in ms:
		reduced = reduce_matrix(m, s)
		hashed = hash(str(reduced))
		if hashed in d:
			d[hashed][0] += 1
			d[hashed][1].append(idx)
		else:
			d[hashed] = [1, [idx]]
		idx += 1
	return d

def group_by_similarity(d):
	mapped = []
	for key in d:
		mapped.append(d[key][1])
	return mapped

def group_counts(d):
	mapped = []
	for key in d:
		mapped.append(d[key][0])
	result = [0 for i in range(max(mapped))]
	for el in mapped:
		result[el - 1] += 1
	return result

def first_of_group_and_group_size(similarity_group):
	d = {}
	for group in similarity_group:
		d[group[0]] = len(group)
	keys = d.keys()
	keys.sort()
	result = []
	for key in keys:
		result.append([key, d[key]])
	return result

def reverse(a):
	a.reverse()
	return a

def group_by_num_in_group(firsts_and_sizes):
	d = {}
	for arr in firsts_and_sizes:
		size = arr[1]
		if size in d:
			d[size].append(arr[0])
		else:
			d[size] = [arr[0]]
	return d

def each_slice(arr, num):
	idx = 0
	result = []
	next_arr = []
	while idx < len(arr):
		if idx % num == 0 and idx != 0:
			result.append(next_arr)
			next_arr = []
		next_arr.append(arr[idx])
		idx += 1
	result.append(next_arr)
	return result

def num_members_in_group_by_matrix_id(similarity_group):
	d = {}
	for group in similarity_group:
		for matrix_id in group:
			d[matrix_id] = len(group)
	result = [None for _ in range(max(d.keys()))]
	for key in d:
		result[key - 1] = d[key]

	return result


# print(reduce_matrix([[1, 1, 0], [2, 2, 1], [1, 2, 1]], 3))
# m1 = [[1, 1, 0], [1, 0, 0], [0, 0, 0]]
# m2 = [[1, 1, 0], [0, 0, 1], [0, 0, 0]]
# print(similar(m1, m2, 2))
# print(sigma(1, 4, lambda x: x * 2))
