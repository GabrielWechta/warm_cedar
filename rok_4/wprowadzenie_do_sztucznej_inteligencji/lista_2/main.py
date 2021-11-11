import keras.models
import numpy as np
import tensorflow as tf
from matplotlib import pyplot as plt
import seaborn as sn
import pandas as pd

print("TensorFlow version:", tf.__version__)


def train_model(x_train, y_train):
    model = tf.keras.models.Sequential([
        tf.keras.layers.Flatten(input_shape=(28, 28)),
        tf.keras.layers.Dense(128, activation='relu'),
        tf.keras.layers.Dense(10, activation='softmax')
    ])

    # optimizer = tf.keras.optimizers.Adam(learning_rate=0.01)

    model.compile(optimizer='adam',
                  loss='sparse_categorical_crossentropy',
                  metrics=['accuracy'])

    model.fit(x_train, y_train, epochs=5)

    model.save("mnist_model.h5", save_format='h5')


def load_model():
    return keras.models.load_model("mnist_model.h5")


def show_heatmap(confusion_matrix):
    df_cm = pd.DataFrame(np.array(confusion_matrix),
                         index=[i for i in range(10)],
                         columns=[i for i in range(10)])
    plt.figure(figsize=(10, 7))
    sn.heatmap(df_cm, annot=True, cmap="YlGnBu")

    plt.show()


if __name__ == "__main__":
    mnist = tf.keras.datasets.mnist

    (x_train, y_train), (x_test, y_test) = mnist.load_data()
    x_train, x_test = x_train / 255.0, x_test / 255.0

    # train_model(x_train=x_train, y_train=y_train)

    model = load_model()
    y_pred = model.predict(x_test)
    y_pred_classes = np.argmax(y_pred, axis=1)
    confusion_matrix = tf.math.confusion_matrix(y_test, y_pred_classes)

    show_heatmap(confusion_matrix=confusion_matrix)
