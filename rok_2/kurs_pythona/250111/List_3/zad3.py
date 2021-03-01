with open("test.txt", 'r') as f:
    content = f.read()

sizes = [int(size[-1]) for size in
         (word for word in (line.split() for line in (line for line in content.splitlines())))]

print("Total sum of bytes: {}".format(sum(sizes)))
