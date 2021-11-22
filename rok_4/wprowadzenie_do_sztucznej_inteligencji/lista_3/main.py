from keras.datasets import mnist
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.manifold import TSNE
from sklearn.cluster import MiniBatchKMeans


def show_TSNE(x_part, y_part):
    view = TSNE(n_components=2, random_state=123).fit_transform(x_part)
    plt.figure(figsize=(20, 10))
    plt.scatter(view[:, 0], view[:, 1], c=y_part, alpha=0.5)
    plt.xlabel('t-SNE-1')
    plt.ylabel('t-SNE-2')
    plt.show()


def main():
    (x_train, y_train), (x_test, y_test) = mnist.load_data()
    x_train = x_train / 255.0
    x_test = x_test / 255.0

    x_train = x_train.reshape(len(x_train), -1)
    x_test = x_test.reshape(len(x_test), -1)

    # show_TSNE(x_train[:2000], y_train[:2000].astype('int'))

    for number_of_clusters in range(10, 11):
        # for number_of_clusters in range(7, 12):
        k_means = MiniBatchKMeans(n_clusters=number_of_clusters)
        k_means.fit(x_train)
        print(k_means.labels_)


if __name__ == "__main__":
    main()
