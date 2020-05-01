`import sys
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

np.set_printoptions(threshold=sys.maxsize)

ratings = pd.read_csv("ratings.csv")
cropped = ratings[ratings.movieId <= 10000]
users = ratings.userId.to_frame().drop_duplicates()
pseudo = pd.DataFrame([[u, m] for u in users.userId for m in range(1, 10000)], columns=["userId", "movieId"])
full_ratings = pseudo.merge(ratings, 'left', ['userId', 'movieId']).fillna(0).drop(columns="timestamp")
print(full_ratings)
x = np.array([full_ratings[full_ratings.userId == user].rating for user in users.userId])
print(x)
# x = np.array(ratings).T
# X = x / np.linalg.norm(x, axis=0)
# print(X)
# y = np.zeros((9019, 1))
# y[2571] = 5  # patrz movies.csv  2571 - Matrix
# y[32] = 4  # 32 - Twelve Monkeys
# y[260] = 5  # 260 - Star Wars IV
# y[1097] = 4
# z = np.dot(x / np.linalg.norm(x, axis=0), np.array(y) / np.linalg.norm(y))
# Z = z / np.linalg.norm(z)
# solution = np.dot(X.T, Z)
# print(solution)
# # print(my_ratings)
