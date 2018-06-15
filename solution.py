from collections import Set

def factorial(n):
	if n == 0:
		return 1
	product = 1
	for x in range(1, n + 1):
		product *= x
	return product

def choose(n1, n2):
	numerator = factorial(n1)
	denomenator = factorial(n2) * factorial(n1 - n2)
	return numerator / denomenator

def gcd(n1, n2):
	arr = [n1, n2]
	arr.sort()
	n1, n2 = arr
	idx = n1
	while idx > 0:
		if n1 % idx == 0 and n2 % idx == 0:
			return idx
		idx -= 1
	return None

def partitions(n):
	if n == 1:
		return [[1]]
	result = [[n]]
	prev = partitions(n - 1)
	for part in prev:
		new_part = list(part)
		new_part.append(1)
		new_parts = [new_part]
		idx = len(part) - 1
		while idx >= 0:
			new_part = list(part)
			new_part[idx] += 1
			new_parts.append(new_part)
			idx -= 1
		for new_part in new_parts:
			new_part.sort()
			new_part.reverse()
			if not new_part in result:
				result.append(new_part)
	return result

def chunk_dup(nums):
	if not nums:
		return None
	idx = 1
	result = [[nums[0]]]
	while idx < len(nums):
		if nums[idx] == nums[idx - 1]:
			result[-1].append(nums[idx])
		else:
			result.append([nums[idx]])
		idx += 1
	return result


def num_arrangements_in_partition(partition, n):
	idx = 0
	total = 1
	while idx < len(partition):
		if partition[idx] == 1:
			break
		choose_num = choose(n, partition[idx])
		total *= choose_num * factorial(partition[idx] - 1)
		n -= partition[idx]
		idx += 1
	chunked = chunk_dup(partition)
	for chunk in chunked:
		if chunk[0] != 1:
			total /= factorial(len(chunk))
	return total

def polynomial_creator(row_partitions, col_partitions, r, c):
	result = {}
	for row_part in row_partitions:
		for col_part in col_partitions:
			row_factor = num_arrangements_in_partition(row_part, r)
			col_factor = num_arrangements_in_partition(col_part, c)
			prod = row_factor * col_factor
			update_polynomial(result, prod, row_part, col_part)
	return result

def update_polynomial(exp_coeff_pairs, prod, row_part, col_part):
	exp = 0
	for row_summand in row_part:
		for col_summand in col_part:
			divisor = gcd(row_summand, col_summand)
			exp += divisor
	if exp in exp_coeff_pairs:
		exp_coeff_pairs[exp] += prod
	else:
		exp_coeff_pairs[exp] = prod

def answer(r, c, s):
	row_partitions = partitions(r)
	column_partitions = partitions(c)
	polynomial = polynomial_creator(row_partitions, column_partitions, r, c)
	answer = 0
	for exp in polynomial:
		coeff = polynomial[exp]
		answer += coeff * (s ** exp)
	return str(answer / (factorial(r) * factorial(c)))

print answer(1, 4, 5)
