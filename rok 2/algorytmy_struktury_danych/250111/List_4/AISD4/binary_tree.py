import sys


class Node:
    def __init__(self, data):
        self.data = data
        self.parent = None
        self.left = None
        self.right = None


class BinaryTree:

    def __init__(self):
        self.root = None

    def __printHelper(self, curr_ptr, indent, last):
        # print the tree structure on the screen
        if curr_ptr is not None:
            sys.stdout.write(indent)
            if last:
                sys.stdout.write("R----")
                indent += "     "
            else:
                sys.stdout.write("L----")
                indent += "|    "

            print(curr_ptr.data)

            self.__printHelper(curr_ptr.left, indent, False)
            self.__printHelper(curr_ptr.right, indent, True)

    def __searchTreeHelper(self, node, key):
        if node is None or key == node.data:
            return node

        if key < node.data:
            return self.__searchTreeHelper(node.left, key)
        return self.__searchTreeHelper(node.right, key)

    def __deleteNodeHelper(self, node, key):
        if node is None:
            return node
        elif key < node.data:
            node.left = self.__deleteNodeHelper(node.left, key)
        elif key > node.data:
            node.right = self.__deleteNodeHelper(node.right, key)
        else:
            if node.left is None and node.right is None:
                node = None

            elif node.left is None:
                temp = node
                node = node.right

            elif node.right is None:
                temp = node
                node = node.left

            else:
                temp = self.min(node.right)
                node.data = temp.data
                node.right = self.__deleteNodeHelper(node.right, temp.data)
        return node

    def __preOrderHelper(self, node):
        if node is not None:
            sys.stdout.write(str(node.data) + " ")
            self.__preOrderHelper(node.left)
            self.__preOrderHelper(node.right)

    def __inOrderHelper(self, node):
        if node is not None:
            self.__inOrderHelper(node.left)
            sys.stdout.write(str(node.data) + " ")
            self.__inOrderHelper(node.right)

    def __postOrderHelper(self, node):
        if node is not None:
            self.__postOrderHelper(node.left)
            self.__postOrderHelper(node.right)
            sys.stdout.write(str(node.data) + " ")

    def preorder(self):
        self.__preOrderHelper(self.root)

    def inorder(self):
        self.__inOrderHelper(self.root)

    def postorder(self):
        self.__postOrderHelper(self.root)

    def searchTree(self, k):
        return self.__searchTreeHelper(self.root, k)

    def find(self, k):
        return 1 if self.searchTree(k) is not None else 0

    def min(self, node):
        if node is None:
            return
        while node.left is not None:
            node = node.left
        return node

    def max(self, node):
        if node is None:
            return
        while node.right is not None:
            node = node.right
        return node

    def successor(self, x):
        if x.right is not None:
            return self.min(x.right)

        y = x.parent
        while y is not None and x == y.right:
            x = y
            y = y.parent
        return y

    def predecessor(self, x):
        if x.left is not None:
            return self.max(x.left)

        y = x.parent
        while y is not None and x == y.left:
            x = y
            y = y.parent
        return y

    def insert(self, key):
        node = Node(key)
        y = None
        x = self.root

        while x is not None:
            y = x
            if node.data < x.data:
                x = x.left
            else:
                x = x.right

        node.parent = y
        if y is None:
            self.root = node
        elif node.data < y.data:
            y.left = node
        else:
            y.right = node

    def deleteNode(self, data):
        return self.__deleteNodeHelper(self.root, data)

    def delete(self, k):
        self.deleteNode(k)

    def prettyPrint(self):
        self.__printHelper(self.root, "", True)
