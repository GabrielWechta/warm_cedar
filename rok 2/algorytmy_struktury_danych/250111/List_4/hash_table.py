import linked_list
import red_black_tree
import sys


class HashTable:
    def __init__(self, size, maximum_list_size):  # maximum_list_size in our notation is "m"
        self.size = size  # Size of T table = 10**size.
        self.T = [linked_list.LinkedList() for _ in range(10 ** self.size)]
        self.maximum_list_size = maximum_list_size
        self.compares = 0

    def show(self):
        for x in self.T:
            print(x)
            x.show()

    def insert(self, k):
        hash_key = abs(hash(k)) % (10 ** self.size)
        data_structure = self.T[hash_key]
        # migration from LinkedList to RBTree happening
        if isinstance(data_structure,
                      linked_list.LinkedList) and data_structure.number_of_items() > self.maximum_list_size:
            rb_tree = red_black_tree.RedBlackTree()
            for element in data_structure:
                rb_tree.insert(element)
            self.T[hash_key] = rb_tree
        data_structure.insert(k)

    def delete(self, k):
        hash_key = abs(hash(k)) % (10 ** self.size)
        self.T[hash_key].delete(k)

    def find(self, k):
        self.compares = 0
        hash_key = abs(hash(k)) % (10 ** self.size)
        answer = self.T[hash_key].find(k)
        self.compares = self.T[hash_key].compares
        return answer

    def min(self):
        sys.stdout.write("\n")

    def max(self):
        sys.stdout.write("\n")

    def successor(self, k):
        sys.stdout.write("\n")

    def inorder(self):
        sys.stdout.write("\n")


# ht = HashTable(0, 3)
# ht.insert("a")
# ht.insert("b")
# ht.insert("abc")
# ht.show()
# ht.insert("d")
# ht.insert("v")
# ht.show()
