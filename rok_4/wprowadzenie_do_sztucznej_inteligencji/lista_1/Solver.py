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


def calculate_total_invert_distance(fifteen: Fifteen):
    """One vertical move can fix at most three inversions. If we assume the minimum number of vertical moves needed
    to fix the inversions, that results in floor(invcount / 3). If there is a remainder, the remaining inversions can
    be solved with at least one vertical move per remaining inversion. This leads to a lower bound on the number of
    vertical moves required: """
    vertical_invert = fifteen.get_inversions_count()
    vertical = vertical_invert / 3 + vertical_invert % 3

    """We can do the same for horizontal moves. However, the ordering is now top-to-bottom, left-to-right. We need to 
    compare the tiles correctly, as ordering by the tile numbers won't be enough. Instead, we need to compare the 
    tiles by the location of their correct position. For the vertical inversions, that ordering happened to be the 
    same as the ordering of the tile numbers. """
    # horizontal_invert = fifteen.get_horizontal_inversions_count()
    # horizontal = horizontal_invert / 3 + horizontal_invert % 3

    return vertical  # + horizontal


def calculate_total_misplaced_tile_distance(fifteen: Fifteen):
    return fifteen.how_many_wrong()


def flat_tuple(position):
    flat = [item for sublist in position for item in sublist]
    return tuple(flat)


class Solver:
    def __init__(self, start_fifteen, heuristic):
        self.start_fifteen = start_fifteen
        self.heuristic = heuristic
        self.solution = []

    def distance(self, move_fifteen: Fifteen):
        return self.heuristic(move_fifteen)

    def solve(self):
        heap_dict = heapdict()
        heap_dict[self.start_fifteen] = self.heuristic(self.start_fifteen)
        examined = set()
        number_of_examined_nodes = 0

        while heap_dict:
            current_fifteen, _ = heap_dict.popitem()

            if current_fifteen.position == current_fifteen.finish_position:
                self.solution = current_fifteen.path_to_me
                return current_fifteen.path_to_me, len(current_fifteen.path_to_me), number_of_examined_nodes
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

    def pretty_print_solution(self):
        print(*(position for position in self.solution), sep="->")
