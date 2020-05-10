import binary_tree
import red_black_tree
import hash_table

x = hash_table.HashTable(0, 9)

x.insert("aaa")
x.insert("a")
x.insert("b")
x.insert("ab")
x.inorder()
x.delete("a")
x.delete("b")
x.max()
