r"""
Some (very) basic algorithms in coding theory.

"""

C1 = [[0,0,0],[0,1,1],[1,2,2]]  ## An initial example of a code, this is also written as {000,011,122} in {0,1}^3
C2 = [[0,0,0],[0,1,1],[1,2,1]]

def is_code(C):
    r"""
    Check if the input C represents a code, i.e. is a list of lists.
    """
    if not isinstance(C,list):
        return False
    if len(C)==0:  # An empty code is still a code.
        return True
    w = C[0] # The first word. We now check the format of this word.
    if not isinstance(w,(list,tuple)):
        return False
    n = len(w)
    for x in C:
        if len(x)<>n:
            return False
    return True


def get_signature_of_code(C):
    r"""
    Find the signature (n,M) of the code.
    INPUT:
     - 'C' -- a list of lsits representing a code.
    OUTPUT:
     - '(n,M)' --
    """
    if not is_code(C):
        raise ValueError,"Input is not a code! We got ".format(C)
    n = len(C[0])
    M = len(C)
    return n,M

def Hamming_distance(x,y):
    r"""
    Calculate the Hamming distance between the code words x and y.
    """
    d = 0
    for i in range(len(x)):
        if x[i]<>y[i]:
            d = d + 1
    return d

def minimum_distance(C):
    r"""
    Find the minimum distance for a code.
    """
    if not is_code(C):
        raise ValueError,"Input is not a code! We got ".format(C)
    min_distance = len(C[0])  # This is the largest it can be, namely if all digits are different for all words in the code.
    for x in C:
        for y in C:
            if x == y: # We want to compare different elements.
                continue
            d = Hamming_distance(x,y)
            if d < min_distance:
                min_distance = d
    return min_distance
