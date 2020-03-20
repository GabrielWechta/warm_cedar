import os
import sys

arguments = sys.argv
os.chdir(arguments[1])  # change directory to that given in argument

for root, dirs, files in os.walk(".", topdown=True):
    for name in files:
        file_name = os.path.join(root, name)
        print(file_name)
        os.rename(file_name, file_name.lower())
