from scipy import sparse
from scipy.sparse.linalg import norm
import numpy as np
import pandas as pd

np.seterr(divide='ignore', invalid='ignore')
pd.set_option('display.max_columns', None)

ratings_data = pd.read_csv("ratings.csv")
movie_names = pd.read_csv("movies.csv")

movie_data = pd.merge(ratings_data, movie_names, on="movieId")
user_movie_rating = movie_data.pivot_table(index='userId', columns='movieId', values='rating').fillna(0)
# print(user_movie_rating.head())
b = sparse.csr_matrix(user_movie_rating.values)


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
