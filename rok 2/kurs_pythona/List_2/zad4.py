import os
import hashlib
from itertools import chain

BLOCK_SIZE = 65536
list = []

# os.chdir("/home/gabriel/Desktop/studia/rok 2/kurs_pythona")

for root, dirs, files in os.walk(".", topdown=True):
    for name in files:
        file_hash = hashlib.sha256()
        file_name = os.path.join(root, name)
        with open(file_name, 'rb') as f:
            fb = f.read(BLOCK_SIZE)
            while len(fb) > 0:
                file_hash.update(fb)
                fb = f.read(BLOCK_SIZE)
        list.append((file_name, file_hash.hexdigest()))

sorted_list = sorted(list, key=lambda tup: tup[1])

flag = False # flag is False when if is supposed to print also current line

for i in range(len(sorted_list) - 1):
    x, y = sorted_list[i]
    x2, y2 = sorted_list[i + 1]
    if y == y2:
        if flag == False:
            print(x)
            flag = True
        print(x2)
    else:
        print("*****************")
        flag = False

print(sorted_list)

# for key in dictionary.keys():
#     if dictionary[key] == dictionary[next(key)]: print(key)
