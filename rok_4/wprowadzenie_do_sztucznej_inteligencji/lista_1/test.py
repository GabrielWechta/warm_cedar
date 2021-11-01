import time
import csv
from Fifteen import *
from Solver import *

if __name__ == "__main__":

    test_num = 0

    # while test_num < 10:
    #     fifteen = get_random_solvable_fifteen()
    #     print(test_num)
    #     print(fifteen)
    #
    #     solver = Solver(fifteen, calculate_total_manhattan_distances)
    #     before = time.time()
    #     _, path_length, num_nodes = solver.solve()  # solving
    #     total_time = time.time() - before
    #     writer.writerow(["manhattan", total_time, path_length, num_nodes])
    #
    #     test_num += 1

    while test_num < 20:
        # fifteen, true_shuffles = get_shuffled_by(70)
        fifteen = get_random_solvable_fifteen()
        # if 80 < true_shuffles < 150:
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

            # misplaced
            solver = Solver(fifteen, calculate_total_misplaced_tile_distance)
            before = time.time()
            _, path_length, num_nodes = solver.solve()  # solving
            total_time = time.time() - before
            writer.writerow([test_num, "misplaced", total_time, path_length, num_nodes])

            test_num += 1
