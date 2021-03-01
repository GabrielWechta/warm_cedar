import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import seaborn


def sigmoid(x):
    return 1.0 / (1 + np.exp(-x))


def sigmoid_derivative(x):
    return x * (1.0 - x)


def relu(x):
    return x * (x > 0.0)


def relu_derivative(x):
    return 1. * (x > 0.0)


def tanh(x):
    return np.tanh(x)


def tanh_derivative(x):
    return 1. - np.tanh(x) ** 2


class NeuralNetwork_1n1:
    def __init__(self, neurons, x, y, a_function, a_function_derivative, eta=0.5):
        self.input = x
        self.weights1 = np.random.rand(neurons, self.input.shape[1])
        self.weights2 = np.random.rand(1, neurons)
        self.y = y
        self.output = np.zeros(self.y.shape)
        self.eta = eta
        self.layer1 = None

        self.activation_function = a_function
        self.activation_function_derivative = a_function_derivative

    def feedforward(self):
        self.layer1 = self.activation_function(np.dot(self.input, self.weights1.T))
        self.output = self.activation_function(np.dot(self.layer1, self.weights2.T))

    def backprop(self):
        delta2 = (self.y - self.output) * self.activation_function_derivative(self.output)
        d_weights2 = self.eta * np.dot(delta2.T, self.layer1)

        delta1 = self.activation_function_derivative(self.layer1) * np.dot(delta2, self.weights2)
        d_weights1 = self.eta * np.dot(delta1.T, self.input)

        self.weights1 += d_weights1
        self.weights2 += d_weights2

    def train_and_animate(self, epochs=50000):
        for i in range(epochs):
            self.feedforward()
            self.backprop()
            if i % 10000 == 0:
                plt.scatter(np.linspace(np.min(self.input), np.max(self.input), self.input.shape[0]), nn.output)
                plt.xlabel("epoch = {}".format(i))
                plt.show(block=False)
                # plt.pause(1) # for running without IDE
                plt.close()

        fig = plt.figure()
        ax1 = fig.add_subplot(111)
        ax1.scatter(np.linspace(np.min(self.input), np.max(self.input), self.input.shape[0]), nn.output, c='b',
                    label="model")
        return ax1

    def predict(self, x, target, ax1):
        predict_layer1 = self.activation_function(np.dot(x, self.weights1.T))
        predict_output = self.activation_function(np.dot(predict_layer1, self.weights2.T))
        mse = (np.square(target - predict_output)).mean(axis=1)
        print("MSE: ", mse)

        ax1.scatter(np.linspace(np.min(self.input), np.max(self.input), target.shape[0]), predict_output, c='#8c564b',
                    label="prediction")
        plt.xlabel("finished")
        plt.show()


"""Quadratic"""
x = np.linspace(-50, 50, 26)
y = x ** 2
y = y / np.linalg.norm(y)
x = x.reshape((len(x), 1))
y = y.reshape((len(y), 1))
x = np.c_[x, np.ones(26)]
nn = NeuralNetwork_1n1(5, x, y, sigmoid, sigmoid_derivative)
ax = nn.train_and_animate()

sample = np.linspace(-50, 50, 101)
sample = np.c_[sample, np.ones(101)]
for_quality = sample ** 2
for_quality = for_quality / np.linalg.norm(for_quality)
nn.predict(sample, for_quality, ax)
plt.pause(3)
plt.clf()

"""Sinus"""
x = np.linspace(0, 2, 21)
y = np.sin((3 * np.pi / 2) * x)
y = y / np.linalg.norm(y)
x = x.reshape((len(x), 1))
y = y.reshape((len(y), 1))
x = np.c_[x, np.ones(21)]
nn = NeuralNetwork_1n1(10, x, y, sigmoid, sigmoid_derivative, eta=0.25)
ax = nn.train_and_animate()

sample = np.linspace(0, 2, 161)
sample = np.c_[sample, np.ones(161)]
for_quality = np.sin((3 * np.pi / 2) * sample)
for_quality = for_quality / np.linalg.norm(for_quality)
nn.predict(sample, for_quality, ax)
