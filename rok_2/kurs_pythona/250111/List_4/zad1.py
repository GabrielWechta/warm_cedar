import time


def time_decorator(func):
    def wrapper(*args):
        start = time.time()
        val = func(*args)
        end = time.time()
        print("Function took {}".format(end - start))
        return val

    return wrapper


@time_decorator
def foo(a, b):
    return a ^ 2 + 2 * a * b + b ^ 2


print(foo(2, 3))
