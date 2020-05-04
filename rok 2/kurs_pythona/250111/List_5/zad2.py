import sys
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

np.seterr(divide='ignore', invalid='ignore')
np.set_printoptions(threshold=sys.maxsize)

ratings = pd.read_csv("ratings.csv")
cropped = ratings[ratings.movieId <= 9999]
users = ratings.userId.to_frame().drop_duplicates()
pseudo = pd.DataFrame([[u, m] for u in users.userId for m in range(1, 9020)], columns=["userId", "movieId"])
full_ratings = pseudo.merge(ratings, 'left', ['userId', 'movieId']).fillna(0).drop(columns="timestamp")
x = np.array([full_ratings[full_ratings.userId == user].rating for user in users.userId])

x_ready = np.nan_to_num(x / np.linalg.norm(x, axis=0))
y = np.zeros((9019, 1))
y[2571] = 5  # 2571 - Matrix
y[32] = 4  # 32 - Twelve Monkeys
y[260] = 5  # 260 - Star Wars IV
y_ready = np.nan_to_num(y / np.linalg.norm(y, axis=0))
z = np.dot(x_ready, y_ready)
z_ready = np.nan_to_num(z / np.linalg.norm(z, axis=0))
recommendation = np.dot(x_ready.T, z_ready)
sorted_indexes = np.argsort(-recommendation, axis=0)

movies = pd.read_csv("movies.csv", header=0)
i = 0
for index in sorted_indexes:
    if i > 9:
        break
    movie = movies.loc[movies['movieId'] == index[0]]
    try:
        print(index[0], " - ", movie.iloc[0]['title'])
        i += 1
    except IndexError:
        pass
