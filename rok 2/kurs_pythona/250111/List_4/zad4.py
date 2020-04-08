from inspect import getfullargspec
import math

named_func = dict()

def overload(func):
    named_func[len(getfullargspec(func).args)] = func

    def wrapper(*args):
        args_list = [arg for arg in args]
        here = named_func[len(args_list)]
        val = here(*args)
        return val

    return wrapper


@overload
def norm(x, y):
    return math.sqrt(x * x + y * y)


@overload
def norm(x, y, z):
    return abs(x) + abs(y) + abs(z)


print(f"norm(2,4) = {norm(2, 4)}")

print(f"norm(2,3,4) = {norm(2, 3, 4)}")
