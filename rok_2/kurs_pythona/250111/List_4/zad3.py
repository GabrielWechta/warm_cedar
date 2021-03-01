import random
from queue import Queue


class Node(object):
    def __init__(self, value):
        self.value = value
        self.children = []

    def addChildren(self, node):
        self.children.append(node)

    def getChildren(self):
        return self.children

    def show(self, stick="-"):
        print(stick, self.value)
        stick = stick + "-"
        for node in self.getChildren():
            node.show(stick)


def generate_tree(height):
    tree_root = Node(1)
    root = tree_root
    for i in range(random.randint(1, 3)):
        tree_root.addChildren(Node(random.randint(0, 20)))
    root = tree_root
    while height > 2:
        for kid in root.getChildren():
            for i in range(random.randint(1, 3)):
                kid.addChildren(Node(random.randint(0, 20)))
        root = root.getChildren()[0]
        height -= 1
    return tree_root


def dfs(node):
    yield node.value
    if node.getChildren().count != 0:
        for current in node.getChildren():
            for s_node in dfs(current):
                yield s_node
    return node


def bfs(node):
    q = Queue()
    q.put(node)
    while q.empty() is False:
        u = q.get()
        yield u.value
        for s_node in u.getChildren():
            q.put(s_node)


tree = generate_tree(3)
tree.show()
print(list(dfs(tree)))
print(list(bfs(tree)))
