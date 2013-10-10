r"""
Files containing examples of codes.

"""
︠43bc3cf2-86b8-4813-aa3e-db65f34a8d2c︠


sys.path.append(".")
import basiccodes as codes   ## This allows you to type codes.<TAB>   to see available functions
from basiccodes import *
example_codes =  [
                 [[0,0,1,0,0],
                  [0,0,0,1,1],
                  [1,1,1,1,1],
                  [1,1,0,0,0]],
                 [[0,0,0],[1,1,1]] # Code from tutorial 1 problem 3
                 [(0,0,1,0,1),(1,1,0,1,1),(1,0,1,0,0),(1,0,0,1,0)]
                 ]

︡5d0f28d8-c645-4668-a3d2-54916ff81e29︡
︠751e0cb0-4f05-4e80-a34e-cfb2fbc3461d︠
# Test nearest neighbour decoding
success = 0
C = example_codes
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
︡8e87aacf-dbe5-4180-9771-8e0a965cf834︡{"stdout":"Succesful decoding rate: 0.186850000000000\n"}︡
︠0792cbd9-3cd6-46c7-ab9f-1a72d78d8f8f︠
# Note: The probability of having exactly one error is 6/32 = 0.1875
︠0ad812a6-e2b1-4d49-ae33-a58f56af82b3︠
︠e4d1965c-748c-428d-99a1-b6728d22848c︠









