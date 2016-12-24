require 'matrix'
m1 = Matrix[[1, 0, 0], [1, 0, 0], [0, 0, 1]]
m2 = Matrix[[1, 0, 0], [1, 0, 0], [1, 0, 0]]

l1, u1, p1 = m1.lup
l2, u2, p2 = m2.lup
# p l1 == l2
# p u1 == u2
# p p1 == p2
#
# p m1.determinant
# p m2.determinant

p m1.row_vectors
