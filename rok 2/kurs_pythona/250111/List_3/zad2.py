def flatten(x):
    if isinstance(x, list):
        for value in x:
            for sub_value in flatten(value):
                yield sub_value
    else:
        yield x


l = [[1, 2, ["a", 4, "b", 5, 5, 5]], [4, 5, 6 ], 7, [[9, [123, [[123]]]], 10]]
print(list(flatten(l)))