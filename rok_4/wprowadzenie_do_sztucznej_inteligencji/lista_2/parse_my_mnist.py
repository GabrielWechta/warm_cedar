from PIL import Image, ImageEnhance, ImageOps
import matplotlib.pyplot as plt
import numpy as np


def show(img, title=None, figsize=(8, 4)):
    plt.figure(figsize=figsize)
    if title is None:
        plt.title("My Hand Written MNIST")
    else:
        plt.title(title)
    plt.imshow(img)
    plt.show()


def get_samples(image, size=30):
    samples = []
    for digit, y in enumerate(range(0, image.height, size)):
        cuts = []
        for x in range(0, image.width, size):
            cut = image.crop(box=(x, y, x + size, y + size))
            cuts.append(cut)
        samples.append(cuts)
    return samples


def center_image(sample, target_size=28):
    inv_sample = ImageOps.invert(sample)
    bbox = inv_sample.getbbox()
    crop = inv_sample.crop(bbox)
    delta_w = target_size - crop.size[0]
    delta_h = target_size - crop.size[1]
    padding = (delta_w // 2, delta_h // 2, delta_w - (delta_w // 2), delta_h - (delta_h // 2))
    return ImageOps.expand(crop, padding)


def get_parsed_my_mnist():
    my_mnist_img = Image.open("my_mnist/my_MNIST.png")
    show(my_mnist_img)

    bw_my_mnist_img = my_mnist_img.convert(mode="L")
    show(bw_my_mnist_img)

    samples = get_samples(image=bw_my_mnist_img)

    centered_samples = []
    for row in samples:
        centered_samples.append([center_image(sample) for sample in row])

    binary_samples = np.array([[sample.getdata() for sample in row] for row in centered_samples])
    binary_samples = binary_samples.reshape(len(centered_samples) * len(centered_samples[0]), 28,
                                            28)
    classes = np.array([[i] * 10 for i in range(10)]).reshape(-1)

    print(f'X shape: {binary_samples.shape}')
    print(f'y shape: {classes.shape}')


    return binary_samples, classes