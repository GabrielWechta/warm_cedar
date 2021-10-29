from Fifteen import Fifteen
from heapdict import heapdict


def calculate_total_manhattan_distances(fifteen: Fifteen):
    manhattan = 0
    for y in range(fifteen.rows_num):
        for x in range(fifteen.columns_num):
            right_y, right_x = fifteen.find_tile(fifteen.position[y][x], fifteen.finish_position)
            manhattan += abs(right_x - x)
            manhattan += abs(right_y - y)
    return manhattan


def flat_tuple(position):
    flat = [item for sublist in position for item in sublist]
    return tuple(flat)


class Solver:
    def __init__(self, start_fifteen, heuristic):
        self.start_fifteen = start_fifteen
        self.heuristic = heuristic
        self.number_of_examined_nodes = 0
        self.solution = []

    def distance(self, move_fifteen: Fifteen):
        return self.heuristic(move_fifteen)

    def solve(self):
        heap_dict = heapdict()
        heap_dict[self.start_fifteen] = self.heuristic(self.start_fifteen)
        examined = set()
        number_of_examined_nodes = 0
        path = None

        while heap_dict:
            current_fifteen, _ = heap_dict.popitem()
            # print(cost, end_node)

            if current_fifteen.position == current_fifteen.finish_position:
                return list(current_fifteen.path_to_me), number_of_examined_nodes
            if flat_tuple(current_fifteen.position) in examined:
                continue
            examined.add(flat_tuple(current_fifteen.position))

            for move in current_fifteen.get_possible_moves():
                if flat_tuple(move.position) in examined:
                    continue
                path_list = move.path_to_me
                g_cost = len(path_list)
                h_cost = self.heuristic(move)
                heap_dict[move] = g_cost + h_cost

            number_of_examined_nodes += 1

        self.number_of_examined_nodes = number_of_examined_nodes
