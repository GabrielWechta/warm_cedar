from cmath import exp
from math import pi


class FastBigNum(object):
    def __init__(self, str_number):
        self.str_number = str_number
        self.vec_number = self.strToVec(str_number)
        self.trans_vec_number = self.dft(self.vec_number, 2 * len(self.vec_number))
        print(self.vec_number)
        print(self.trans_vec_number)

    def __str__(self):
        sum = 0
        for i in range(len(self.vec_number) - 1):
            sum += self.vec_number[i] * 10 ** (len(self.vec_number) - i - 2)
        return str(sum)

    def __mul__(self, other):
        z = []
        for i in range(len(self.trans_vec_number)):
            z.append(self.trans_vec_number[i] * other.trans_vec_number[i])
        self.trans_vec_number = z

        self.vec_number = self.idft(self.trans_vec_number, len(self.trans_vec_number))
        return self

    def dft(self, x, n):
        return [sum(x[i] * self.omega(i * k, n) if i < len(x) else 0 for i in range(n)) for k in range(n)]

    def idft(self, x, n):
        return [int(round(sum(x[i] * self.omega(-i * k, n) if i < len(x) else 0 for i in range(n)).real) / n) for k in
                range(n)]

    def omega(self, k, n):
        return exp(-2j * k * pi / n)

    def strToVec(self, str_number):
        vector = [int(s) for s in str_number]
        print(vector)
        return vector


A = "123123123123123123123123123123123123123123123123123"
B = "123412341234123412341234123412341234123412341234123"

a = FastBigNum(A)
b = FastBigNum(B)

print(a * b)
print(123123123123123123123123123123123123123123123123123 * 123412341234123412341234123412341234123412341234123 )
