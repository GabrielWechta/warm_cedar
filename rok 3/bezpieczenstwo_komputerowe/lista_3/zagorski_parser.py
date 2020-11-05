import binascii
import sys

with open(sys.argv[1]) as file:
    for line in file:
        if line[0] != 'k' and line[0] != '(':
            if line.split() is None:
                print()
            else:
                for word in line.split():
                    print("{:02x}".format(int(word, 2)), end="")
                print()
