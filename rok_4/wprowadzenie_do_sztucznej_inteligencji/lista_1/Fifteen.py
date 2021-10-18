import copy

class Fifteen:
    def __init__(self, start_position):
        self.position = start_position
        self.finish_position = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 0]]
        self.rows_num = 4
        self.columns_num = 4

    def show_puzzle(self):
        row_band = "—" * 13 + "\n"
        for y in range(self.rows_num):
            for x in range(self.columns_num):
                row_band += f"{self.position[y][x]} \t"
                if x == self.rows_num - 1:
                    row_band += "\n"
        row_band += "—" * 13 + "\n"
        print(row_band)

    def _swap_elements(self, x1, y1, x2, y2):
        puzzle_copy = copy.deepcopy(self.position)
        puzzle_copy[x1][y1], puzzle_copy[x2][y2] = puzzle_copy[x2][y2], puzzle_copy[x1][y1]

        return puzzle_copy

    def _find_tile(self, tile, position=None):
        if position is None:
            position = self.position

        for y in range(self.rows_num):
            for x in range(self.columns_num):
                if position[y][x] == tile:
                    return y, x

    @staticmethod
    def flatten_list(tab):
        return [item for sublist in tab for item in sublist]

    def _get_inversions_count(self):
        inversion_count = 0
        puzzle_flat = self.flatten_list(self.position)

        for i in range(len(puzzle_flat)):
            for j in range(i + 1, len(puzzle_flat)):
                if puzzle_flat[i] > puzzle_flat[j]:
                    inversion_count += 1

        return inversion_count

    def get_possible_moves(self):
        moves = []
        y, x = self._find_tile(0)

        if y > 0:
            moves.append(Fifteen(self._swap_elements(y, x, y - 1, x)))
        if y < self.rows_num - 1:
            moves.append(Fifteen(self._swap_elements(y, x, y + 1, x)))
        if x < self.rows_num - 1:
            moves.append(Fifteen(self._swap_elements(y, x, y, x + 1)))
        if x > 0:
            moves.append(Fifteen(self._swap_elements(y, x, y, x - 1)))
        return moves

    def how_many_wrong(self):
        wrong = 0
        for y in range(self.rows_num):
            for x in range(self.columns_num):
                if self.position[y][x] != self.finish_position[y][x]:
                    wrong += 1
        return wrong

    def calculate_total_manhattan_distances(self):
        manhattan = 0
        for y in range(self.rows_num):
            for x in range(self.columns_num):
                right_y, right_x = self._find_tile(self.position[y][x], self.finish_position)
                manhattan += abs(right_x - x)
                manhattan += abs(right_y - y)
        return manhattan

    def is_solvable(self):
        y, _ = self._find_tile(0)
        zero_position = (self.rows_num - y) - 1
        return True if (self._get_inversions_count() % 2 == 0 and zero_position % 2 == 0) or (
                self._get_inversions_count() % 2 == 1 and zero_position % 2 == 1) else False
