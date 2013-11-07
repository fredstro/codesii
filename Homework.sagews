︠8e4b0e07-bf53-4484-8dc1-d7f727bd861b︠
%md
We want to solve the computational homework problems

Problem 1
---------

Write a short program which verifies whether a given input string (or list) is a valid 10 digit ISBN code. Use this program to answer the following problems:

1. produce lists of all possible codes of the form

   1. 0-12-3ab6c8-X
   2. 0-12-3ab678-X
   3. 0-12-3a4678-X
   where a,b,c $\in\left\{ 0,1,\ldots,9\right\}$.

2. Use the results from (a) to give an argument for what the minimum distance “should” be. And if you calculated it above; does your estimate here agree with what you proved before?
Solution
--------
Recall that the last digit in the ISBN code represented by the vector $(x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8,x_9,x_10)$ with $x_{10} \in \left\{0,1,...,9,10\right\}$ (where 10 is represented by X) is determined by the equation
$$ \sum i \cdot x_i \equiv 0 \mod 11.$$

︡434af551-fa7a-4fa5-828a-6571f0e14cb1︡{"html":"<p>We want to solve the computational homework problem 1</p>\n\n<h2>Problem 1</h2>\n\n<p>Write a short program which verifies whether a given input string (or list) is a valid 10 digit ISBN code. Use this program to answer the following problems:</p>\n\n<ol>\n<li><p>produce lists of all possible codes of the form</p>\n\n<ol>\n<li>0-12-3ab6c8-X</li>\n<li>0-12-3ab678-X</li>\n<li>0-12-3a4678-X\nwhere a,b,c $\\in\\left\\{ 0,1,\\ldots,9\\right\\}$.</li>\n</ol></li>\n<li><p>Use the results from (a) to give an argument for what the minimum distance “should” be. And if you calculated it above; does your estimate here agree with what you proved before?</p>\n\n<h2>Solution</h2></li>\n</ol>\n\n<p>Recall that the last digit in the ISBN code represented by the vector $(x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8,x_9,x_10)$ with $x_{10} \\in \\left\\{0,1,...,9,10\\right\\}$ (where 10 is represented by X) is determined by the equation\n$$ \\sum i \\cdot x_i \\equiv 0 \\mod 11.$$</p>\n"}︡
︠e1182d70-6bab-437b-ad28-f34b1a3557ae︠
def is_valid_isbn(code):
    r"""
    Function for verifying that an isbn code represented as a list of integers is a valid code.
    """
    test = sum(code[i]*(i+1) for i in range(len(code)))
    return (test % 11) == 0

def find_codes_with_free_parameters(code):
    r"""
    find all codes with a set of free parameters. A parameter in the input code is free parameter if it is given by a letter which is not 'X' in the last case.
    NOTE: This is a very simple brute-force solution to the problem.
    INPUT:
      - 'code' -- list of the form [x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10]
    OUTPUT:
      - list of completions of the input code to a valid ISBN code.
    """
    if len(code)<>10:
        raise ValueError,"Need list of length 10"
    valid_completions = []
    ranges = {}
    for i in range(9):
        x = code[i]
        ranges[i]=range(10)
        if isinstance(x,(int,Integer)):
            if x>=0 and x<=9:
                ranges[i] = [x]  # In this case we don't treat it as a free parameter
    # Treat the last digit specially
    ranges[9] = range(11)
    x = code[9]
    if isinstance(x,(int,Integer)):
        if x>=0 and x<=10:
            ranges[9] = [x]
    elif x == 'X':
        ranges[9] = [10]
    for a in ranges[0]:
        for b in ranges[1]:
            for c in ranges[2]:
                for d in ranges[3]:
                    for f in ranges[4]:
                        for g in ranges[5]:
                            for h in ranges[6]:
                                for i in ranges[7]:
                                    for j in ranges[8]:
                                        for k in ranges[9]:
                                            code = [a,b,c,d,f,g,h,i,j,k]
                                            if is_valid_isbn(code):
                                                valid_completions.append(code)
    return valid_completions
︡92f0aa46-3ec7-4798-a4b2-400f38eb9452︡
︠bc3b8707-6367-4d21-bcf5-02f46bc33ebc︠
# For problem 1
code1 = [0,1,2,3,'a','b',6,'c',8,'X']
ans1=find_codes_with_free_parameters(code1)
print "Numbers of codes in ans1",len(ans1)
# 2.
code2 = [0,1,2,3,'a','b',6,7,8,'X']
ans2=find_codes_with_free_parameters(code2)
print "Numbers of codes in ans2",len(ans2)
# 3.
code3 = [0,1,2,3,'a',4,6,7,8,'X']
ans3=find_codes_with_free_parameters(code3)
print "codes in ans3=",ans3
︡2b11f1ec-1cca-4154-9aff-c02be01c9965︡{"stdout":"Numbers of codes in ans1 91\n"}︡{"stdout":"Numbers of codes in ans2 9\n"}︡{"stdout":"codes in ans3= [[0, 1, 2, 3, 1, 4, 6, 7, 8, 10]]\n"}︡
︠dbdb15f4-932b-4439-b549-20a525b5ae01i︠
%md
If x=[0,1,2,3,2,5,6,7,8,10]  then $S(x,2)$ contains $9$ different code words so that the minimum distance must be less than or equal to $2$. Since $S(x,1)$ only contains $x$ we could guess that the minimum distance is indeed exactly 2. (If we believe that the choice of the point $x$ is more or less arbitrary)

︡8f30921c-3075-4f89-940b-7bb2d2a25cdf︡{"html":"<p>If x=[0,1,2,3,2,5,6,7,8,10]  then $S(x,2)$ contains $9$ different code words so that the minimum distance must be less than or equal to $2$. Since $S(x,1)$ only contains $x$ we could guess that the minimum distance is indeed exactly 2. (If we believe that the choice of the point $x$ is more or less arbitrary)</p>\n"}︡
︠03519386-184e-49e6-9336-ae04f505a2c5︠
%md
Problem 2
---------
Implement the extended Euclidean algorithm, in its standard, as well as the faster version. And you should also compare the performance of both implementations in terms of number of steps needed and CPU time.

1. Calculate the greatest common divisor, $d=\mbox{gcd}\left(x,y\right)$ of $x$ and $y$ where $x	=	424568554903874990794629493965043175075610624$ and  $y=423459514435568237580406409578357456896$.
2. Calculate the inverse of $x$ in $\mathbb{Z}_{n}$ where $x=421156587322313531465110712484894404213239117345787478016$ and $n=133709993814093786806229722142298700707230590073759904819224984$

Problem 3
---------
Use your implementation of the extended Euclidean algorithm to:

1. Calculate the inverses of $7303113$ and $8388607$ in $\mathbb{Z}_{16777216}$.

2. Let $C$ be the code in $\mathbb{Z}_{16777216}^{3}$ consisting of the solutions $\left(x_{1},x_{2},x_{3}\right)$ of
   $$\begin{eqnarray}
     7303113x_{1}+x_{4}	=	0,\\
     8388607x_{2}+x_{3}	=	0,\\
     2x_{3}	=	0\\
     4x_{4}	=	0,\\
   \end{eqnarray}$$
 Give a list of the code words in C and calculate d(C).

︡3405c358-090d-4643-974b-805dff9ca114︡{"html":"<h2>Problem 2</h2>\n\n<p>Implement the extended Euclidean algorithm, in its standard, as well as the faster version. And you should also compare the performance of both implementations in terms of number of steps needed and CPU time.</p>\n\n<ol>\n<li>Calculate the greatest common divisor, $d=\\mbox{gcd}\\left(x,y\\right)$ of $x$ and $y$ where $x\t=\t424568554903874990794629493965043175075610624$ and  $y=423459514435568237580406409578357456896$.</li>\n<li>Calculate the inverse of $x$ in $\\mathbb{Z}_{n}$ where $x=421156587322313531465110712484894404213239117345787478016$ and $n=133709993814093786806229722142298700707230590073759904819224984$</li>\n</ol>\n\n<h2>Problem 3</h2>\n\n<p>Use your implementation of the extended Euclidean algorithm to:</p>\n\n<ol>\n<li><p>Calculate the inverses of $7303113$ and $8388607$ in $\\mathbb{Z}_{16777216}$.</p></li>\n<li><p>Let $C$ be the code in $\\mathbb{Z}_{16777216}^{3}$ consisting of the solutions $\\left(x_{1},x_{2},x_{3}\\right)$ of \n$\\begin{eqnarray} \n     7303113x_{1}+x_{4}\t=\t0,\\\\\n     8388607x_{2}+x_{3}\t=\t0,\\\\\n     2x_{3}\t=\t0\\\\\n     4x_{4}\t=\t0,\\\\\n   \\end{eqnarray}$\nGive a list of the code words in C and calculate d(C).</p></li>\n</ol>\n"}︡
︠5c0a7bae-6d45-4b1e-b14f-178bfd0fb276︠
def extended_euclidean_algorithm(a,b,modified=0,verbose=0):
    r"""
    Compute the gcd of a and b using the extended Euclidean algorithm.
    Note that we can also use the xgcd function built into sage.

    INPUT:

       'a' -- integer
       'b' -- integer
       'modified' -- integer. If = 1 we use the modification with negative reminders

    OUTPUT:

       d,m,n -- tuple, wher d=gcd(a,b) = m*a+n*b

    """
    r={}; q={}; m={}; n={}
    if abs(a) > abs(b):
        r[-1] = copy(a); r[0]=copy(b)
        m[-1]=1; m[0]=0; n[-1]=0; n[0]=1
    else: # Swap a and b
        r[-1] = copy(b); r[0]=copy(a)
        n[-1]=1; n[0]=0; m[-1]=0; m[0]=1
    i = 0
    while r[i]<>0:
        r[i+1] = r[i-1] % r[i]
        if modified == 1:
            s = 2*r[i+1]
            if s > r[i] or s < -r[i]:
                r[i+1]-= r[i]
        q[i+1] = (r[i-1] - r[i+1])/r[i]
        m[i+1] = m[i-1] - q[i+1]*m[i]
        n[i+1] = n[i-1] - q[i+1]*n[i]
        if verbose>0:
            print "r{0}={1}".format(i+1,r[i+1])
            print "m{0}={1}".format(i+1,m[i+1])
            print "n{0}={1}".format(i+1,n[i+1])
        i=i+1
        #    print m,n
    if r[-1]==b: # swap back
        mtmp = n[i-1]
        n[i-1] = m[i-1]
        n[i-1] = mtmp
    assert m[i-1]*a + n[i-1]*b == r[i-1]
    return r[i-1],m[i-1],n[i-1]


︠9aeeca3a-e8f2-4cb6-b63b-de28a45ab79a︠
# For problem 2
extended_euclidean_algorithm(424568554903874990794629493965043175075610624,423459514435568237580406409578357456896)
︡e7288eb8-6caf-48ec-a8b7-b464a50b63f0︡{"stdout":"(423459514435568237580406409578357456896, 0, 1)\n"}︡

︠92cb599e-ac93-48db-b81d-8efe1cca3e2c︠
extended_euclidean_algorithm(421156587322313531465110712484894404213239117345787478016,133709993814093786806229722142298700707230590073759904819224984)
︡770cd281-6a08-4a72-b571-4920a6cfba21︡{"stdout":"(728, 59576706617053067726470047699750936609868437305112085928201, -187653306435917425118983607134119589872265179245790407)\n"}︡
︠73d95a8e-df42-429b-b50c-76fd4b5d619a︠
extended_euclidean_algorithm(16777216,7303113)
︡d09f81ba-0f47-4a15-90dc-8902167fea47︡{"stdout":"(1, 3313405, -7611783)\n"}︡
︠19cfd4db-a086-4e24-879d-0139c4ea948f︠
% md
Answers to problem 2:
 1. In fact y  divides x  so $gcd(x,y)=y=423459514435568237580406409578357456896$
 2. The greatest common divisor of $x$ and $n$ is 728 so no inverse exists.
︠bc4abbe5-5b28-46e1-b6cc-b11e97ff40f1︠
# Problem 3
 extended_euclidean_algorithm(16777216,7303113,modified=1)
︡28641c88-cf37-472e-8135-1f51a39b3668︡{"stdout":"(1, 3313405, -7611783)\n"}︡
︠3d288574-fc8e-4d7f-a13f-a2ba8c1140e1︠
-7611783 + 16777216
︡093abe6d-c608-43ea-80a7-0d4e17173f4d︡{"stdout":"9165433\n"}︡
︠c975e832-2aee-4086-ad30-eaab700eff06︠
extended_euclidean_algorithm(16777216,8388607,modified=0)
︡d5d2de14-654d-4594-b717-9c27aba2010b︡{"stdout":"(1, -4194303, 8388607)\n"}︡
︠76852c84-bc40-4bf5-b974-8aab35c1ecd1︠
%md
Answers to problem 3:
 1. The inverse of  $7303113$ in $\mathbb{Z}_{16777216}$ is $9165433$
 2. The inverse of  $8388607$ in $\mathbb{Z}_{16777216}$ is $8388607$
︠4e24fcce-bab5-4fd1-a6af-d5298ff99774o︠
%md
To solve the system of equations we get
 $$\begin{eqnarray}
     x_{1} = -(7303113)^{-1}x_{4} =	7611783 x_{4},\\
     x_{2} = -(8388607)^{-1}x_{3} =	8388609 x_3,\\
     2x_{3}	=	0\\
     4x_{4}	=	0,\\
   \end{eqnarray}$$
︠ad93fb2d-d6d4-47a0-b617-6b914619511a︠
# Timings
︠22f29813-53c1-471f-be89-d6136ca2cd59︠
16777216 - 8388607
︡a61523c7-cf40-42fe-ab6b-3ede5cff9b0d︡{"stdout":"8388609\n"}︡
︠28d5f9ce-0ec9-47ff-9ec2-fecbe5b8c9a4︠
%timeit extended_euclidean_algorithm(16777216,7303113,modified=1)
︡cd0e9c99-23cd-4d69-bf39-1ac4a9d66da2︡{"stdout":"625 loops, best of 3: 239 µs per loop"}︡{"stdout":"\n"}︡
︠735df17e-d3bf-4ad3-9d1c-199b6a685615︠
%timeit extended_euclidean_algorithm(16777216,7303113,modified=0)
︡984d28fd-4e0b-40d5-84d7-5d3a3d14fb56︡{"stdout":"625 loops, best of 3: 226 µs per loop"}︡{"stdout":"\n"}︡
︠e216c5cd-fa1d-4e8b-b1ec-ebd4b4f53b31︠
%timeit extended_euclidean_algorithm(16777216,8388607,modified=0)
︡8c7f89e9-7825-43bf-9ba6-016cb110dfa6︡{"stdout":"625 loops, best of 3: 88.1 µs per loop"}︡{"stdout":"\n"}︡
︠34bbfd32-f5c6-4de4-b227-16e7d17c7701︠
%timeit extended_euclidean_algorithm(16777216,8388607,modified=1)
︡b098ced5-a203-4fa2-8650-4457277dad6a︡{"stdout":"625 loops, best of 3: 104 µs per loop"}︡{"stdout":"\n"}︡
︠3d356098-0c7a-4728-b273-57d5eff62884︠

︠c15c4ff7-75a4-4a12-a283-fab8227e9130i︠










