import matplotlib.pyplot as plt
import numpy as np
from keras.datasets import mnist
from sklearn.cluster import MiniBatchKMeans, KMeans
from sklearn.manifold import TSNE
from sklearn.metrics import accuracy_score, confusion_matrix
from sklearn import metrics
import pandas as pd
import seaborn as sn
import parse_my_mnist


def show_TSNE(x_part, y_part):
    view = TSNE(n_components=2, random_state=123).fit_transform(x_part)
    plt.figure(figsize=(20, 10))
    plt.scatter(view[:, 0], view[:, 1], c=y_part, alpha=0.5)
    plt.xlabel('t-SNE-1')
    plt.ylabel('t-SNE-2')
    plt.show()


def retrieve_info(k_means, y_train):
    reference_labels = {}
    for i in range(len(np.unique(k_means.labels_))):
        index = np.where(k_means.labels_ == i, 1, 0)
        num = np.bincount(y_train[index == 1]).argmax()
        reference_labels[i] = num
    return reference_labels


def calculate_metrics(k_means, y_pred, expected):
    print(f'Number of clusters is {k_means.n_clusters}.')
    print(f'Accuracy: {accuracy_score(y_pred, expected)}.')
    print(f'Inertia: {k_means.inertia_}.')
    print(f'Homogeneity: {metrics.homogeneity_score(expected, k_means.labels_)}.')
    print()


def show_heatmap(conf_mat, title):
    df_cm = pd.DataFrame(np.array(conf_mat),
                         index=[i for i in range(10)],
                         columns=[i for i in range(10)])
    plt.figure(figsize=(10, 7))
    sn.heatmap(df_cm, annot=True, cmap="YlGnBu").set_title(title)

    plt.show()


def inertia_from_number_of_clusters(x_train, y_train):
    inertia_dict = {}
    for number_of_clusters in range(7, 12):
        # k_means = KMeans(n_clusters=number_of_clusters, algorithm="elkan")
        k_means = MiniBatchKMeans(n_clusters=number_of_clusters)
        k_means.fit(x_train)
        reference_labels = retrieve_info(k_means, y_train)

        y_pred = np.zeros(len(k_means.labels_))
        for i in range(len(k_means.labels_)):
            y_pred[i] = reference_labels[k_means.labels_[i]]

        calculate_metrics(k_means, y_pred, y_train)

        # conf_mat = confusion_matrix(y_train, y_pred)
        # show_heatmap(conf_mat=conf_mat, title=f"number of clusters = {number_of_clusters}")

        centroids = k_means.cluster_centers_.reshape(number_of_clusters, 28, 28)
        centroids *= 255

        _, axs = plt.subplots(3, 4, figsize=(12, 12))
        axs = axs.flatten()
        for i, (img, ax) in enumerate(zip(centroids, axs)):
            ax.imshow(img)
            ax.set_title(f'Number: {reference_labels[i]}')
        plt.show()

        inertia_dict[number_of_clusters] = k_means.inertia_

    x, y = zip(*sorted(inertia_dict.items()))
    plt.plot(x, y)
    plt.show()


def main():
    (x_train, y_train), (_, _) = mnist.load_data()
    x_train = x_train / 255.0
    x_train = x_train.reshape(len(x_train), -1)

    # Digit allocation
    mini_k_means = MiniBatchKMeans(n_clusters=10)
    mini_k_means.fit(x_train)

    conf_mat = confusion_matrix(y_train, mini_k_means.labels_)
    show_heatmap(conf_mat=conf_mat, title="Digit Allocation to 10 clusters.")

    # Hand written digits
    x_my_mnist, y_my_mnist = parse_my_mnist.get_parsed_my_mnist()
    x_my_mnist = x_my_mnist / 255.0
    x_my_mnist = x_my_mnist.reshape(len(x_my_mnist), -1)
    y_my_mnist_pred = mini_k_means.predict(x_my_mnist)
    reference_labels = retrieve_info(mini_k_means, y_train)

    y_my_mnist_pred_classed = np.zeros(len(y_my_mnist))
    for i in range(len(y_my_mnist)):
        y_my_mnist_pred_classed[i] = reference_labels[y_my_mnist_pred[i]]

    conf_mat = confusion_matrix(y_my_mnist, y_my_mnist_pred_classed)

    show_heatmap(conf_mat=conf_mat, title="Confusion matrix for hand written digits.")

    # Inertia based on different cluster numbers
    # inertia_from_number_of_clusters(x_train=x_train, y_train=y_train)


if __name__ == "__main__":
    main()
