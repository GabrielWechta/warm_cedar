from cmath import exp
from math import pi

def vecToInt(z):
    sum = 0
    for i in range(len(z) - 1):
        sum += z[i]*10**(len(z) - i - 2)
    return sum


def omega(k, n):
    return exp(-2j * k * pi / n)


def dft(x, n):
    return [sum(x[i] * omega(i * k, n) if i < len(x) else 0 for i in range(n)) for k in range(n)]


def idft(x, n):
    return [int(round(sum(x[i] * omega(-i * k, n) if i < len(x) else 0 for i in range(n)).real) / n) for k in range(n)]


x = dft([1, 2], 4)
y = dft([1, 1], 4)
z = []
for i in range(4):
    z.append(x[i] * y[i])

print(x)
print(y)
print(z)

z = idft(z, 4)

print(z)

z = vecToInt(z)
print(z)
