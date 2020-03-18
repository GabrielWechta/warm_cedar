from random import randint
import random
import sys
import math


def gcd(a, b):
    while b != 0:
        a, b = b, a % b
    return a


def random_with_n_digits(n):
    range_start = 10 ** (n - 1)
    range_end = (10 ** n) - 1
    return randint(range_start, range_end)


def is_Prime(n):
    if n != int(n):
        return False
    n = int(n)
    # Miller-Rabin test for prime
    if n == 0 or n == 1 or n == 4 or n == 6 or n == 8 or n == 9:
        return False

    if n == 2 or n == 3 or n == 5 or n == 7:
        return True
    s = 0
    d = n - 1
    while d % 2 == 0:
        d >>= 1
        s += 1
    assert (2 ** s * d == n - 1)

    def trial_composite(a):
        if pow(a, d, n) == 1:
            return False
        for i in range(s):
            if pow(a, 2 ** i * d, n) == n - 1:
                return False
        return True

    for i in range(20):  # number of trials
        a = random.randrange(2, n)
        if trial_composite(a):
            return False

    return True


def multiplicative_inverse(a, b):
    """Returns a tuple (r, i, j) such that r = gcd(a, b) = ia + jb
    """
    # r = gcd(a,b) i = multiplicitive inverse of a mod b
    #      or      j = multiplicitive inverse of b mod a
    # Neg return values for i or j are made positive mod b or a respectively
    # Iterateive Version is faster and uses much less stack space
    x = 0
    y = 1
    lx = 1
    ly = 0
    oa = a  # Remember original a/b to remove
    ob = b  # negative values from return results
    while b != 0:
        q = a // b
        (a, b) = (b, a % b)
        (x, lx) = ((lx - (q * x)), x)
        (y, ly) = ((ly - (q * y)), y)
    if lx < 0:
        lx += ob  # If neg wrap modulo orignal b
    if ly < 0:
        ly += oa  # If neg wrap modulo orignal a
    # return a , lx, ly  # Return only positive values
    return lx


def generate_keypair(p, q):
    if p == q:
        raise ValueError('p and q cannot be equal')
    n = p * q
    phi = (p - 1) * (q - 1)

    e = random.randrange(1, phi)

    g = gcd(e, phi)
    while g != 1:
        e = random.randrange(1, phi)
        g = gcd(e, phi)

    d = multiplicative_inverse(e, phi)

    return (e, n), (d, n)


if __name__ == '__main__':
    arguments = sys.argv
    if arguments[1] == "--gen-keys":

        bits = int(arguments[2])
        n_digits = int(math.log(2) / math.log(10) * bits)

        while 1:  # generating p
            p = random_with_n_digits(n_digits)
            if is_Prime(p):
                break

        while 1:  # generating q
            q = random_with_n_digits(n_digits)
            if is_Prime(q):
                break

        # Now both p and q are prime

        print(p, q, sep=" and ")

        public, private = generate_keypair(p, q)

        with open("key.pub", 'w') as public_file:
            public_file.write(str(public))

        with open("key.prv", 'w') as private_file:
            private_file.write(str(private))

    elif arguments[1] == "--encrypt":
            x = 1
    elif arguments[1] == "--decrypt":
            x = 1
    else:
        print("Please use '--gen-keys', '--encrypt' or '--decrypt' options")




