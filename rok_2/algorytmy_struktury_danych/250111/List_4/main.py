import binary_tree
import red_black_tree
import hash_table
import scientist
import sys
import time


def parse(struc, fun, arg):
    if fun == "insert":
        arg = ''.join(filter(str.isalpha, arg))  # for non letter characters input
        sci.start_clock()
        struc.insert(arg)
        sci.insert_happened()

    if fun == "delete":
        sci.start_clock()
        struc.delete(arg)
        sci.delete_happened()

    if fun == "find":
        sci.start_clock()
        sys.stdout.write(str(struc.find(arg)) + "\n")
        sci.find_happened()
        # sci.set_compare_counter(struc.compares)
        # sys.stdout.write(arg + ": ")
        # sci.describe_compares()
    if fun == "successor":
        if not isinstance(struc, hash_table.HashTable):
            sci.start_clock()
            tmp = struc.successor(arg)
            sci.successor_happened()
            if tmp is not None:
                sys.stdout.write(str(tmp.data) + "\n")
            else:
                sys.stdout.write("\n")
        else:
            sys.stdout.write("\n")
    if fun == "load":
        try:
            with open(arg, 'r') as file:
                inserts = file.read()
            for ins in inserts.split():
                ins = ''.join(filter(str.isalpha, ins))  # for non letter characters input
                sci.start_clock()
                struc.insert(ins)
                sci.insert_happened()
        except:
            sys.stdout.write("No file \n")
    if fun == "min":
        if not isinstance(struc, hash_table.HashTable):
            sci.start_clock()
            tmp = struc.min(struc.root)
            sci.min_happened()
            if tmp is not None:
                sys.stdout.write(str(tmp.data) + "\n")
            else:
                sys.stdout.write("\n")
        else:
            sys.stdout.write("\n")
    if fun == "max":
        if not isinstance(struc, hash_table.HashTable):
            sci.start_clock()
            tmp = struc.max(struc.root)
            sci.max_happened()
            if tmp is not None:
                sys.stdout.write(str(tmp.data) + "\n")
            else:
                sys.stdout.write("\n")
        else:
            sys.stdout.write("\n")
    if fun == "inorder":
        if not isinstance(struc, hash_table.HashTable):
            sci.start_clock()
            struc.inorder()
            sci.inorder_happened()
            sys.stdout.write("\n")
        else:
            sys.stdout.write("\n")


if __name__ == "__main__":
    sci = scientist.Scientist()
    structure = None
    if sys.argv[1] == "--type":
        if sys.argv[2] == "bst":
            structure = binary_tree.BinaryTree()
        elif sys.argv[2] == "rbt":
            structure = red_black_tree.RedBlackTree()
        elif sys.argv[2] == "hmap":
            structure = hash_table.HashTable(3, 10)  # TODO tweak
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

    sci.describe_program()
