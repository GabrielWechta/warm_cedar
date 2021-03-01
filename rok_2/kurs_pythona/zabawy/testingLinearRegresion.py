import numpy as np
from matplotlib import pyplot as plt

# plt.plot([0, 1], [1, 0])
# plt.gcf().set_size_inches([10, 8])
x = np.linspace(0, 10, 100)
plt.subplot(2, 1, 1)
plt.plot(x, np.sin(x))
plt.subplot(2, 1, 2)
plt.plot(x, np.cos(x))
# plt.plot(x, x, label="linear")
# plt.plot(x, x ** 3, label="quadritc")
# plt.xlabel("x label")
# plt.ylabel("y label")
# plt.title("Simple Plot")
# plt.legend()
plt.show()
