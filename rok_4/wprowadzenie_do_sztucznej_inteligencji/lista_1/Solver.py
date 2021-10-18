from Fifteen import Fifteen


class Solver:
    def __init__(self, start_position):
        self.start_position = start_position
        self.num_expanded_nodes = 0
        self.solution = []

    @staticmethod
    def calculate_distances(move_position: Fifteen, end_position: Fifteen):
        return move_position.calculate_total_manhattan_distances() - end_position.calculate_total_manhattan_distances()

    def solve(self):
        queue = [[self.start_position.calculate_total_manhattan_distances(), self.start_position]]
        expanded = []
        num_expanded_nodes = 0
        path = None

        while queue:
            i = 0
            for j in range(1, len(queue)):
                if queue[i][0] > queue[j][0]:  # minimum
                    i = j

            path = queue[i]
            queue = queue[:i] + queue[i + 1:]
            end_node = path[-1]

            if end_node.position == end_node.finish_position:
                break
            if end_node.position in expanded:
                continue

            for move in end_node.get_possible_moves():
                if move.position in expanded:
                    continue
                new_path = [path[0] + self.calculate_distances(move, end_node)] + path[1:] + [move]
                queue.append(new_path)
                expanded.append(end_node.position)

            num_expanded_nodes += 1

        self.num_expanded_nodes = num_expanded_nodes
        self.solution = path[1:]
