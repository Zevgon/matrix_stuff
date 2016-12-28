#"Partition" in this file is illustrated by the following example
#The five partitions of 4 are (4, 0, 0, 0), (2, 1, 0, 0), (0, 2, 0, 0), (0, 0, 0, 1), and (1, 0, 1, 0)
#(4, 0, 0, 0) is read as "4 ones, zero twos, zero threes, and zero fours"
#(2, 1, 0, 0) is read as "2 ones, 1 twos, zero threes, and zero fours"


class Fixnum
	def !
		self == 0 ? 1 : (1..self).reduce(:*)
	end

	def ∑(start = 1, finish = self, prc = nil)
		prc ||= proc {|x| x}
		sum = 0
		while start <= finish
			sum += prc.call(start)
			start += 1
		end
		sum
	end
end

def denominator_part(partition, i)
	k_sub_i = partition[i]
	k_sub_i.! * ((i + 1) ** k_sub_i)
end

def denominator(partition)
	prod = 1
	(0...partition.length).each do |num|
		prod *= denominator_part(partition, num)
	end
	prod
end

def c_sub_j_of_pi(partition, j, m)
	sum = 0
	i = 1
	while i <= m
		k_sub_i = partition[i - 1]
		gcd = i.gcd(j)
		sum += k_sub_i * gcd
		i += 1
	end

	2 ** sum
end

partition = [1, 0, 1, 0]
i = 1
m = 4

# p denominator(partition)
# p c_sub_j_of_pi([0, 0, 1], 3, 3)

def cycle_index_of_dihedral_permutation_group(num_sides, x)
	#Keys of perm_map are in the form of [num_cycles_in_perm, size_cycle_in_perm]
	#If the items in a key don't multiply to num_sides, it's necessary later on to factor in the fact that there are num_sides - product remaining 1-cycles
	perm_map = Hash.new(0)
	#Add the identity permutation
	perm_map[[num_sides, 1]] = 1

	#Add rotations
	idx = 1
	while idx <= num_sides / 2
		if num_sides % idx == 0
			if num_sides / idx == 2
				perm_map[[idx, num_sides / idx]] += 1
			else
				perm_map[[idx, num_sides / idx]] += 2
			end
		else
			perm_map[[1, num_sides]] += 2
		end
		idx += 1
	end

	#Add reflections
	if num_sides.odd?
		perm_map[[num_sides / 2, 2]] += num_sides
	else
		perm_map[[num_sides / 2 - 1, 2]] += num_sides / 2
		perm_map[[num_sides / 2, 2]] += num_sides / 2
	end

	answer = 0
	perm_map.each do |k, v|
		if k[0] * k[1] == num_sides
			answer += v * (x ** k[0])
		else
			num_singles = num_sides - k[0] * k[1]
			answer += v * (x ** num_singles) * (x ** k[0])
		end
	end

	answer / (num_sides * 2)
end

p cycle_reduced_dihedral_permutation_group(6, 3)
