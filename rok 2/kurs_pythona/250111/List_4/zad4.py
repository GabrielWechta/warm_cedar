from inspect import getfullargspec
import math


def overload(func):
    def wrapper(*args):
        val = func(*args)
        print(getfullargspec(func).args)
        return val

    return wrapper


@overload
def norm(x, y):
    return math.sqrt(x * x + y * y)


print(norm(1, 2))


@overload
def norm(x, y, z):
    return abs(x) + abs(y) + abs(z)


print(norm(1, 2, 3))
print(norm(1, 2))
