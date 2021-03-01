import os
import hashlib
import sys

arguments = sys.argv  # main arguments
BLOCK_SIZE = 65536  # for reading from file
list = []
os.chdir(arguments[1])  # change directory to that given in argument

for root, dirs, files in os.walk(".", topdown=True):
    for name in files:
        file_hash = hashlib.sha256()
        file_name = os.path.join(root, name)
        with open(file_name, 'rb') as f:
            fb = f.read(BLOCK_SIZE)
            while len(fb) > 0:
                file_hash.update(fb)
                fb = f.read(BLOCK_SIZE)
        list.append((file_name, file_hash.hexdigest(), os.stat(file_name).st_size))

sorted_list = sorted(list, key=lambda tup: tup[1])  # sorting by hash, because it's more unlikely to repeat then size

flag = False  # flag is False when if is supposed to print also current line

for i in range(len(sorted_list) - 1):
    x, y, z = sorted_list[i]
    x2, y2, z2 = sorted_list[i + 1]
    if y == y2 and z == z2:
        if flag is False:
            print(x)
            flag = True
        print(x2)
    elif (y != y2 or z != z) and flag is True:
        print("*****************")
        flag = False
