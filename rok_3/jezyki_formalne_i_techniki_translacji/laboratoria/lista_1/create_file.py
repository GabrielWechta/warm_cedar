import os

size = 1024*1024*1024
small = 1024

with open("large_file", "wb") as file:
	file.write(os.urandom(small))
