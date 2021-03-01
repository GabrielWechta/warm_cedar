from functools import reduce


def powerset(my_list):
    return reduce(lambda result, x: result + [subset + [x] for subset in result],
                  my_list, [[]])


print(powerset(['a', 'b', 'c', 'd']))
