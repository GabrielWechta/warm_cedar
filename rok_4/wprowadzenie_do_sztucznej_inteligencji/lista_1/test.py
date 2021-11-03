import time
import csv
from Fifteen import *
from Solver import *
import pandas


def append_tests():
    test_num = 0
    while test_num < 2000:
        fifteen, true_shuffles = get_shuffled_by(45)
        if 70 < true_shuffles < 80:
            with open('results.csv', 'a', encoding='UTF8', newline='') as f:
                writer = csv.writer(f)
                print(test_num)
                print(fifteen)

                # manhattan
                solver = Solver(fifteen, calculate_total_manhattan_distances)
                before = time.time()
                _, path_length, num_nodes = solver.solve()  # solving
                total_time = time.time() - before
                writer.writerow([test_num, "manhattan", total_time, path_length, num_nodes])
                print("manhattan done")

                # misplaced
                solver = Solver(fifteen, calculate_total_misplaced_tile_distance)
                before = time.time()
                _, path_length, num_nodes = solver.solve()  # solving
                total_time = time.time() - before
                writer.writerow([test_num, "misplaced", total_time, path_length, num_nodes])
                print("misplaced done")

                test_num += 1


def show_csv_stats():
    df = pandas.read_csv("results.csv")
    print(
        f"path length mean = {df['path_length'].mean()}, median = {df['path_length'].median()}, max = {df['path_length'].max()} ")
    print(
        f"examined nodes mean = {df['examined_nodes'].mean()}, median = {df['examined_nodes'].median()}, max = {df['examined_nodes'].max()} ")


if __name__ == "__main__":
    # biggest: manhattan,654.8294560909271,42,385099
    show_csv_stats()
