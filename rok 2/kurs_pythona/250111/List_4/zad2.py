import random
from queue import Queue


def generate_tree(height):
    tree = [1, None, None]
    current = tree
    level = 1
    while level < height:
        if current[1] is None:
            current[1] = [random.randint(0, 20), None, None]
        if current[2] is None:
            current[2] = [random.randint(0, 20), None, None]

        level += 1
        current = current[1]

    return tree


def dfs(tree_dfs):
    yield tree_dfs[0]
    if tree_dfs[1] is not None:
        for x in dfs(tree_dfs[1]):
            yield x
    if tree_dfs[2] is not None:
        for x in dfs(tree_dfs[2]):
            yield x
    return tree_dfs


def bfs(tree_bfs):
    q = Queue()
    q.put(tree_bfs)
    while q.empty() is False:
        u = q.get()
        yield u[0]
        if u[1] is not None:
            q.put(u[1])
        if u[2] is not None:
            q.put(u[2])


tree = generate_tree(5)
print(tree)
print(list(dfs(tree)))
print(list(bfs(tree)))

