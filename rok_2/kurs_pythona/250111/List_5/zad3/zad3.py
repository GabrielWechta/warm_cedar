from scipy import sparse
from scipy.sparse.linalg import norm
import numpy as np
import pandas as pd

np.seterr(divide='ignore', invalid='ignore')
pd.set_option('display.max_columns', None)

ratings_data = pd.read_csv("zad3/ratingsBIG.csv")
movie_names = pd.read_csv("zad3/moviesBIG.csv")

# print(ratings_data.describe())
# print(movie_names.describe())

row = ratings_data.userId
col = ratings_data.movieId
data = ratings_data.rating
b = sparse.coo_matrix((data, (row, col)), shape=(283229, 193887), dtype=float)  # checked max in *.describe()
b = sparse.csr_matrix(b)
# print(b)


def divide(x, vec):
    rows, cols = x.nonzero()
    for row, col in zip(rows, cols):
        x[row, col] = x[row, col] / vec[col]


def divide2(x, vec):
    rows, cols = x.nonzero()
    for i in range(len(rows)):
        x[rows[i], cols[i]] = x[rows[i], cols[i]] / vec[cols[i]]


def normalize(matrix):
    matrix_alg = sparse.linalg.norm(matrix, axis=0)
    divide2(matrix, matrix_alg)


normalize(b)

_, sec_dim = b.shape
my_rates = np.zeros((sec_dim, 1))
my_rates[2] = 5
my_rates[4] = 4
my_rates = sparse.csr_matrix(my_rates, dtype=float)
normalize(my_rates)

z = b.dot(my_rates)

normalize(z)

b = b.T
ans = b.dot(z)
# print(ans)

my_array = -ans.toarray()
top_ten = my_array.argsort(axis=0)[:10]
for index in top_ten:
    try:
        movie = movie_names[movie_names.movieId == index[0]].values[0]
        movie_title = movie[1]
        print(ans[index[0], 0], " - ", movie_title)
    except IndexError:
        pass
