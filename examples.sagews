r"""
Files containing examples of codes.

"""


sys.path.append(".")
import basiccodes as codes   ## This allows you to type codes.<TAB>   to see available functions
from basiccodes import *
example_codes =  [
                 [[0,0,1,0,0],[0,0,0,1,1],[1,1,1,1,1],[1,1,0,0,0]],
                 [[0,0,0],[1,1,1]], # Code from tutorial 1 problem 3
                 [(0,0,1,0,1),(1,1,0,1,1),(1,0,1,0,0),(1,0,0,1,0)]# Code from tutorial 1 problem 1
                 ]

︡5f75bb7e-3471-4bad-8fa4-2d4946172901︡
︠751e0cb0-4f05-4e80-a34e-cfb2fbc3461d︠
︠0792cbd9-3cd6-46c7-ab9f-1a72d78d8f8f︠

︡f60bfa41-ce4c-4eb8-ad93-7e45edbd043f︡
︠0ad812a6-e2b1-4d49-ae33-a58f56af82b3︠
# Tutorial 1 Problem 1
C = example_codes[2]; C
︡386638c4-b50c-4e32-8190-8d3060a8910b︡{"stdout":"[(0, 0, 1, 0, 1), (1, 1, 0, 1, 1), (1, 0, 1, 0, 0), (1, 0, 0, 1, 0)]\n"}︡

︠e4d1965c-748c-428d-99a1-b6728d22848c︠
sphere( (0,0,0,0,0),1,C)
sphere( (0,0,0,0,0),2,C)

︡7286ccc8-fd88-4001-8d11-b02c41906708︡{"stdout":"[]\n"}︡{"stdout":"[(0, 0, 1, 0, 1), (1, 0, 1, 0, 0), (1, 0, 0, 1, 0)]\n"}︡
︠8ea0fbca-35af-4820-b63f-14cd0bc76b5a︠
# Thus there is no unique nearest neighbour for the word (0,0,0,0,0)
sphere( (1,1,1,1,1),1,C)
︡3d0672f5-291f-418d-8f89-e84284b62502︡{"stdout":"[(1, 1, 0, 1, 1)]\n"}︡
︠da8bacff-7916-439c-b684-6d7a1ab9fab6︠
# The unique nearest neighbour of (1,1,1,1,1) is (1,1,0,1,1)

# Test nearest neighbour decoding
success = 0
C = example_codes[0]
N = 10000
error_stats = {0:0,1:0,2:0,3:0,4:0,5:0}
for x in C:
    for i in range(N):
        y = symmetric_binary_channel(x)
        w = nearest_neighbour_decoding(y,C,complete_decoding = False)
        d = Hamming_distance(x,y)
        error_stats[d]+=1
        if x == w:
            success = success + 1
        if d>=2 and x==w:
            print "{0} is transported to {1} and decoded to {2}".format(x,y,w)
print "Succesful decoding rate: {0}".format(1.0*success/(N*len(C)))
︡9667a47e-4e83-4b55-8e65-1528497c6883︡{"stdout":"Succesful decoding rate: 0.187400000000000\n"}︡
︠f0223359-6885-4d0d-84bd-e34a1729a2b3︠

# Note: The probability of having exactly one error is 6/32 = 0.1875 so the above result is consistend with the fact that the code C can correct up to one error.









