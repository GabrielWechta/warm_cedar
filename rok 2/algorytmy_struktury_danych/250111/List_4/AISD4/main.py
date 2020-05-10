import binary_tree
import red_black_tree
import hash_table
import sys
import time


def parse(struc, fun, arg):
    if fun == "insert":
        arg = ''.join(filter(str.isalpha, arg))  # for non letter characters input
        struc.insert(arg)
    if fun == "delete":
        struc.delete(arg)
    if fun == "find":
        sys.stdout.write(str(struc.find(arg)) + "\n")
    if fun == "successor":
        if not isinstance(struc, hash_table.HashTable):
            tmp = struc.successor(arg)
            if tmp is not None:
                sys.stdout.write(str(tmp.data) + "\n")
            else:
                sys.stdout.write("\n")
        else:
            sys.stdout.write("\n")
    if fun == "load":
        with open(arg, 'r') as file:
            inserts = file.readline()
        for ins in inserts.split():
            ins = ''.join(filter(str.isalpha, ins))  # for non letter characters input
            struc.insert(ins)
    if fun == "min":
        if not isinstance(struc, hash_table.HashTable):
            tmp = struc.min(struc.root)
            if tmp is not None:
                sys.stdout.write(str(tmp.data) + "\n")
            else:
                sys.stdout.write("\n")
        else:
            sys.stdout.write("\n")
    if fun == "max":
        if not isinstance(struc, hash_table.HashTable):
            tmp = struc.max(struc.root)
            if tmp is not None:
                sys.stdout.write(str(tmp.data) + "\n")
            else:
                sys.stdout.write("\n")
        else:
            sys.stdout.write("\n")
    if fun == "inorder":
        if not isinstance(struc, hash_table.HashTable):
            struc.inorder()
            sys.stdout.write("\n")
        else:
            sys.stdout.write("\n")


if __name__ == "__main__":
    structure = None
    if sys.argv[1] == "--type":
        if sys.argv[2] == "bst":
            structure = binary_tree.BinaryTree()
        elif sys.argv[2] == "rbt":
            structure = red_black_tree.RedBlackTree()
        elif sys.argv[2] == "hmap":
            structure = hash_table.HashTable(1, 10)  # TODO tweak
        else:
            print("I don't support this data structure. You can use 'bst', 'rbt', 'hmap' flags.")

        number_of_lines = sys.stdin.readline().strip()

        for line in sys.stdin:
            line = line.strip()
            function = line.split(" ")[0]
            if function in ["insert", "load", "delete", "find", "successor"]:
                argument = line.split(" ")[1]
                parse(structure, function, argument)
            else:
                parse(structure, function, None)

    else:
        raise Exception("I only understand '--type' flag.")

# x = red_black_tree.RedBlackTree()
# parse(x, "max", "1.txt")
# parse(x, "find", "nic")
# parse(x, "min", "nothing here")
# parse(x, "max", "nothing here")
# parse(x, "inorder", "nothing here")
