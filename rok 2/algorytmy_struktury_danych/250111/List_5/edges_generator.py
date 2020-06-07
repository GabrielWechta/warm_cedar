import sys

if __name__ == "__main__":
    n = int(sys.argv[1])

    print(n)
    for i in range(n):
        for j in range(i + 1, n):
            print(i, j, ((i - j) ** 2) ** 0.5, sep=" ", end="\n")
