"""
Problem:

    Arrange the numbers from 1 to m*n in an m-by-n grid so that
    no two consecutive numbers are placed in adjacent cells.
    In how many ways can this be done? Two squares are considered
    touching if they share a corner.

Example:

    This is a valid solution for m = 4 and n = 4.

         1  5  2  6
         9 13 10 14
         3  7  4  8
        11 15 12 16

    This is a valid solution for m = 2 and n = 4.

        5  1  6  2
        7  3  8  4

Source:

    Twitter post by @NCTM on February 17, 2012.

    "Friday Math Problem: Arrange the numbers 1 - 16 in a 4 by 4 grid
    so that consecutive numbers are not touching. How many ways are there?"

Answer: 17,464,199,440
"""

from itertools import permutations, combinations
from collections import Counter

# Test whether a row of four numbers is valid. That is, no two adjacent
# entries are consecutive integers.

def valid4(A):
    for i in range(3):
        if abs(A[i]-A[i+1]) == 1:
            return False
    return True

# Test whether a 2x4 array of numbers is valid. In other words, that
# squares which share a side or a corner never contain consecutive numbers.

def valid8(A):
    return valid4(A[:4]) and valid4(A[4:]) and valid_4_to_8(A)

# Helper function for valid8. Assuming that the first two rows are valid,
# check that the 2x4 array is valid.

def valid_4_to_8(A):
    for i in range(4):
        if abs(A[i] - A[i+4]) == 1:
            return False
    for i in range(3):
        if abs(A[i] - A[i+5]) == 1 or abs(A[i+1] - A[i+4]) == 1:
            return False
    return True

total = 0
n = 0

# We partition the integers 0-15 into two sets A and B of 8 integers each.
# B always contains 15.

for A in combinations(range(15),8):
    n += 1
    B = tuple(b for b in range(16) if not(b in A))

    # D1 contains the valid arrangements for the top half of the grid,
    # aggregated by the second row. We do not store the first row, but
    # only count the number of possible first rows for each second row.
 
    D1 = Counter()   
    for v in permutations(A):
        if v[4]<v[7] and valid8(v):   
            D1[v[4:]] += 1

            
    # D2 contains the valid arrangements for the bottom half of the grid,
    # aggregated by the third row. We do not store the fourth row, but
    # only count the number of possible third rows for each fourth row.
          
    D2 = Counter()
    for v in permutations(B):
        if v[0]<v[3] and valid8(v):
            D2[v[:4]] += 1

    # This part of the code adds up the number of ways to combine D1 and D2.
    
    for row2 in D1:
        for row3 in D2:
            if valid_4_to_8(row2 + row3):
                total += D1[row2] * D2[row3]
            backrow = (row3[3],row3[2],row3[1],row3[0])
            if valid_4_to_8(row2 + backrow):
                total += D1[row2] * D2[row3]

# We multiply the total by 4 to account for symmetry, because
#    1. We assumed that B contained 15, and
#    2. We assumed that v[4] < v[7], i.e. the first entry of the 2nd row
#       is less than the last entry of the 2nd row.

print 4*total