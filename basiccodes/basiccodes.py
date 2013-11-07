r"""
Some (very) basic algorithms in coding theory.

Currently codes are implemented as lists of lists. Other representations should be added (e.g. strings, matrices etc.)

Example of format:
  C = [[0,0,0],[0,1,1],[1,2,2]]  ## An initial example of a code, this is also written as {000,011,122} in {0,1}^3


"""


def is_code(C):
    r"""
    Check if the input C represents a code, i.e. is a list of lists.

    INPUT:
     - 'C' -- code
    OUTPUT:
     - Boolean

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
     - 'C' -- code
    OUTPUT:
     - '(n,M)' -- tuple of integers
    """
    if not is_code(C):
        raise ValueError,"Input is not a code! We got ".format(C)
    n = len(C[0])
    M = len(C)
    return n,M

def Hamming_distance(x,y):
    r"""
    Calculate the Hamming distance between the code words x and y.


    INPUT:
     - 'x' -- code word
     - 'y' -- code word
     OUTPUT:
     - non-negative integer

"""
    d = 0
    for i in range(len(x)):
        if x[i]<>y[i]:
            d = d + 1
    return d

def minimum_distance(C):
    r"""
    Find the minimum distance for a code.

    INPUT:
     - 'C' -- code
    OUTPUT:
     - integer

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


def symmetric_binary_channel(word_in,p=0.5):
    r"""
    Simulate the transmission of a code word through a symmetric binary channel.

    INPUT:
    - 'word_in' -- code word
    OUTPUT:
    - 'word_out' -- code word
    """
    from sage.all import random
    word_out = []
    for d in word_in:
        if random()<=p:
            if d == 0:
                y = 1
            else:
                y = 0
        else:
            y = d
        word_out.append(y)
    return word_out

def nearest_neighbour_decoding(word_in,C,complete_decoding = False):
    r"""
    Use nearest neighbour decoding to decode a word.
    If 'complete_decoding' is True then we always return a code word even if there is no unique nearest neighbour, otherwise we return -1 to signify an error in the algorithm.
    INPUT:
    - 'word_in' -- code word
    - 'C' -- code
    - 'complete_decoding' -- boolean
    OUTPUT:
    - 'nearest_neighbour' -- code word
    """
    if not is_code(C):
        raise ValueError,"Input is not a code! We got ".format(C)
    min_dist = len(C)+1   # larger than the maximum distance
    nearest_neighbour = []    # start with an empty word
    for x in C:
        if x == word_in:
            return x   # If we have a code word then we return it.
        d = Hamming_distance(x,word_in)
        if d < min_dist:
            min_dist = d
            nearest_neighbour = x

    # Raise error if something went wrong and we couldn't find a closest neighbour
    if nearest_neighbour == []:
       raise ArithmeticError,"Could not find nearest neighbour to {0} in {1}!".format(word_in,C)
    if complete_decoding == False and len(sphere(word_in,min_dist,C))>1:
        return -1
    return nearest_neighbour


def sphere(w,r,C):
    r"""
    Find the sphere in the code C with center w and radius r.

    INPUT:
    - 'w' -- word
    - 'r' -- integer
    - 'C' -- code
    OUTPUT:
    - list of code words
    """
    sphere = []
    for x in C:
        d = Hamming_distance(x,w)
        if d <= r:
            sphere.append(x)
    return sphere

def number_of_errors_detected(C):
    r"""
    Calculate the number of errors which C can detect.

    INPUT:
    - 'C' -- code
    OUTPUT:
    - integer
    """
    d = minimum_distance(C)
    return d - 1


def number_of_errors_corrected_by_nnd(C):
    r"""
    Calculate the number of errors which C can correct with nearest neighbour decoding/

    INPUT:
    - 'C' -- code
    OUTPUT:
    - integer
    """
    from sage.all import floor
    d = minimum_distance(C)
    return floor( (d - 1.0)/2.0)


