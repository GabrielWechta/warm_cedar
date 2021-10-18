from Fifteen import Fifteen
from Solver import Solver

if __name__ == '__main__':
    fifteen = Fifteen([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 12, 11], [0, 13, 15, 14]])
    fifteen.show_puzzle()
    print(fifteen.is_solvable())
    solver = Solver(fifteen)
    solver.solve()
    print(solver.num_expanded_nodes)
    print(solver.solution)