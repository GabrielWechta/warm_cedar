import time

from Fifteen import Fifteen, get_random_solvable_fifteen
from Solver import Solver, calculate_total_manhattan_distances

if __name__ == '__main__':
    # fifteen = Fifteen([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 12, 15], [13, 14, 11, 0]])
    fifteen = Fifteen([[1, 2, 3, 4], [5, 6, 8, 9], [7, 10, 12, 15], [13, 14, 11, 0]])
    # fifteen = Fifteen([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 15], [14, 13, 12, 0]])
    # fifteen = Fifteen([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 0]])
    print(fifteen.is_solvable())
    print(fifteen.his())
    print(fifteen)

    solver = Solver(fifteen, calculate_total_manhattan_distances)
    if fifteen.is_solvable():
        before = time.time()
        solver.solve()
        print(time.time() - before)

    print(solver.number_of_examined_nodes)
    for part in solver.solution:
        print(part)
