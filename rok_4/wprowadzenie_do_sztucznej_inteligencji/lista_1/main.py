import time

from Fifteen import *
from Solver import *

if __name__ == '__main__':
    fifteen, true_shuffles = get_shuffled_by(10)
    print("Will be working on this puzzle: ")
    print(fifteen)
    print(f"with initial {true_shuffles} shuffles.")

    solver = Solver(fifteen, calculate_total_manhattan_distances)
    assert fifteen.is_solvable()

    before = time.time()
    path, path_length, num_nodes = solver.solve()  # solving
    print(f"time: {time.time() - before}s")
    print(f"solution length: {len(path)}, number of examined nodes: {num_nodes}")
    print("path to solution: ", end="")
    solver.pretty_print_solution()
