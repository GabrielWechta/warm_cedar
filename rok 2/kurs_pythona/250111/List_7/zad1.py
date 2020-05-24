# Ostatnia kolumna z samymi zerami jest prostym implementacyjnie sposobem na dodanie biasu.

# Poeksperymentowałem z etą oraz zastosowałem wszystkie możliwości funckji.
# Niepokoi mnie wynik 1.25 w OR(relu & relu) (czy to metapewność?).

# Dodałem jeszcze linijkę, którą Pan zasugerował jako fix w poleceniu
# ze zmianą ety na 0.01 gdy mamy do czynienia z relu.

import numpy as np


def sigmoid(x):
    return 1.0 / (1 + np.exp(-x))


def sigmoid_derivative(x):
    return x * (1.0 - x)


def relu(x):
    return x * (x > 0.0)


def relu_derivative(x):
    return 1. * (x > 0.0)


class NeuralNetwork:
    def __init__(self, x, y):
        self.input = x
        self.weights1 = np.random.rand(4, self.input.shape[1])
        self.weights2 = np.random.rand(1, 4)
        self.y = y
        self.output = np.zeros(self.y.shape)
        self.eta1 = 0.5
        self.eta2 = 0.5
        self.layer1 = None

    def feedforward(self, func1, func2):
        print(self.input)
        print(self.weights1.T)
        self.layer1 = func1(np.dot(self.input, self.weights1.T))
        print(self.layer1)
        print(self.weights2.T)
        self.output = func2(np.dot(self.layer1, self.weights2.T))
        print(self.output)

    def backprop(self, func1_derivative, func2_derivative):
        if func1_derivative.__name__ == "relu_derivative":
            self.eta1 = 0.01
        if func2_derivative.__name__ == "relu_derivative":
            self.eta2 = 0.01

        delta2 = (self.y - self.output) * func2_derivative(self.output)
        d_weights2 = self.eta2 * np.dot(delta2.T, self.layer1)

        delta1 = func1_derivative(self.layer1) * np.dot(delta2, self.weights2)
        d_weights1 = self.eta1 * np.dot(delta1.T, self.input)

        self.weights1 += d_weights1
        self.weights2 += d_weights2


def training_and_results(X, y, func1, func2, func1_derivative, func2_derivative):
    print("Hide layer use:", func1.__name__, "Output layer use", func2.__name__)
    nn = NeuralNetwork(X, y)
    for _ in range(5000):
        nn.feedforward(func1, func2)
        nn.backprop(func1_derivative, func2_derivative)
    print(nn.output)


def test_procedure():
    possibilities = [(sigmoid, sigmoid, sigmoid_derivative, sigmoid_derivative),
                     (sigmoid, relu, sigmoid_derivative, relu_derivative),
                     (relu, sigmoid, relu_derivative, sigmoid_derivative),
                     (relu, relu, relu_derivative, relu_derivative)]
    print("XOR: ")
    X = np.array([[0, 0, 1],
                  [0, 1, 1],
                  [1, 0, 1],
                  [1, 1, 1]])
    y = np.array([[0], [1], [1], [0]])
    for poss in possibilities:
        f1, f2, f1_d, f2_d = poss
        training_and_results(X, y, f1, f2, f1_d, f2_d)
    print("-" * 30)

    print("AND: ")
    X = np.array([[0, 0, 1],
                  [0, 1, 1],
                  [1, 0, 1],
                  [1, 1, 1]])
    y = np.array([[0], [0], [0], [1]])
    for poss in possibilities:
        f1, f2, f1_d, f2_d = poss
        training_and_results(X, y, f1, f2, f1_d, f2_d)
    print("-" * 30)

    print("OR: ")
    X = np.array([[0, 0, 1],
                  [0, 1, 1],
                  [1, 0, 1],
                  [1, 1, 1]])
    y = np.array([[0], [1], [1], [1]])
    for poss in possibilities:
        f1, f2, f1_d, f2_d = poss
        training_and_results(X, y, f1, f2, f1_d, f2_d)
    print("-" * 30)


if __name__ == "__main__":
    np.set_printoptions(precision=3, suppress=True)
    np.random.seed(17)
    test_procedure()
