from Fifteen import Fifteen



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
    def __init__(self, start_position, heuristic):
        self.start_position = start_position
        self.heuristic = heuristic
        self.number_of_examined_nodes = 0
        self.solution = []

    def distance(self, move_fifteen: Fifteen):
        return self.heuristic(move_fifteen)

    def solve(self):
        solutions_to_check = [(self.heuristic(self.start_position), self.start_position)]
        examined = set()
        number_of_examined_nodes = 0
        path = None

        while solutions_to_check:
            i = 0
            for j in range(1, len(solutions_to_check)):
                if solutions_to_check[i][0] > solutions_to_check[j][0]:  # minimum
                    i = j

            cost = solutions_to_check[i][0]
            path = solutions_to_check[i][1:]
            solutions_to_check = solutions_to_check[:i] + solutions_to_check[i + 1:]
            end_node = path[-1]
            print(cost, end_node)

            if end_node.position == end_node.finish_position:
                break
            if flat_tuple(end_node.position) in examined:
                continue

            for move in end_node.get_possible_moves():
                if flat_tuple(move.position) in examined:
                    continue
                path_list = list(path)
                g_cost = len(path_list)
                h_cost = self.heuristic(move)
                path_list.append(move)
                solutions_to_check.append(tuple([g_cost + h_cost] + path_list))
                examined.add(flat_tuple(end_node.position))

            number_of_examined_nodes += 1

        self.number_of_examined_nodes = number_of_examined_nodes
        self.solution = path[1:]
