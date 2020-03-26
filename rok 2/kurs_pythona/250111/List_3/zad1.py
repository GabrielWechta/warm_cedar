n = int(input("Give me square matrix size: "))

x = ["".join(["{}.{} ".format(x, x) for x in range(y, y + n)]) for y in range(1, n ** 2, n)]
print(x)
my_list = [" ".join([x[j].split()[i] for j in range(len(x))]) for i in range(len(x))]
print(my_list)

# Maybe not in one liner, but still, right?
