import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression


def score_fit(x, y, m, trainers=215):
    test_x = x[:trainers, :m - 1]
    model = LinearRegression().fit(test_x, y[:trainers])
    return model.score(test_x, y)


def predict_fit(x, y, m, trainers=215):
    test_x = x[:trainers, :m - 1]
    model = LinearRegression().fit(test_x, y[:trainers])
    return model.predict(x[trainers:, :m - 1])


ratings = pd.read_csv("ratings.csv")
users = ratings[ratings.movieId == 1].userId
cropped = ratings[(ratings.userId.isin(users)) & ratings.movieId <= 10000]
movies = pd.DataFrame([[u, m] for u in users for m in range(2, 10001)], columns=["userId", "movieId"])
full_ratings = movies.merge(ratings, 'left', ['userId', 'movieId']).fillna(0).drop(columns="timestamp")

x = np.array([full_ratings[full_ratings.userId == user].rating for user in users])
y = np.array(ratings[ratings.movieId == 1].rating).reshape(-1, 1)

first_m = np.array([10, 1000, 10000])
plt.plot(first_m, [1 - score_fit(x, y, m) for m in first_m])
plt.savefig("weakChart")
plt.show()

second_m = np.array([10, 100, 200, 500, 1000, 10000])
for m in second_m:
    predictions = predict_fit(x, y, m, 200)
    print(predictions)
    print("m: ", m, "------------")
    for i in range(15):
        print(i, "predicted: ", predictions[i], "actual: "
              , y[200 + i])
