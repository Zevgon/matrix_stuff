def find_numbers_1_through_54321
	idx = 10000
	valid_numbers = []
	while idx <= 54321
		if valid_number?(idx)
			valid_numbers << idx
		end
		idx += 1
	end
	valid_numbers
end

def valid_number?(number)
	return number.to_s.split("").sort.join == '12345'
end

p find_numbers_1_through_54321
p [1, 2, 3, 4, 5, 6, 7, 8].permutation(8).to_a.map{|el| el.join("")}.map(&:to_i)
[8]
[7, 1]
[6, 2]
[6, 1, 1]

[2, 2, 1] 5
(12)(34)(5)
(13)(24)(5)
(14)(23)(5)

[3, 2, 2, 2, 1]
(123)(45)(6)
(123)(46)(5)
(123)(54)(6)
(123)(56)(4)
(123)(64)(5)
(123)(65)(4)

[[2, 2, 2], [1]]
