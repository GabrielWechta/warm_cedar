import sys
import os


def file_size(file_name):
    stats_info = os.stat(file_name)
    return stats_info.st_size


arguments = sys.argv
# How incredible is that all those variables have the same length?
number_of_lines = 0
number_of_words = 0
max_line_length = 0

if len(arguments) != 2:
    # In case of wrong input
    print("Please as argument give me name of the file that you want to interrogate.")
else:
    with open(arguments[1], 'r') as f:
        # All we need about content in file
        content = f.read()

for line in content.splitlines():
    number_of_lines += 1
    if len(line) > max_line_length: max_line_length = len(line)

    for word in line.split():
        number_of_words += 1
        #print(word)

print("number of bytes: {}".format(file_size(arguments[1])))
print("number of words: {}".format(number_of_words))
print("number of lines: {}".format(number_of_lines))
print("longest line: {}".format(max_line_length))
