import copy
from random import shuffle


class Fifteen:
    def __init__(self, start_position):
        self.position = start_position
        self.finish_position = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 0]]
        self.rows_num = 4
        self.columns_num = 4

    def __str__(self):
        row_band = "—" * 13 + "\n"
        for y in range(self.rows_num):
            for x in range(self.columns_num):
                row_band += f"{self.position[y][x]} \t"
                if x == self.rows_num - 1:
                    row_band += "\n"
        row_band += "—" * 13 + "\n"
        return row_band

    @staticmethod
    def flatten_list(tab):
        return [item for sublist in tab for item in sublist]

    def swap_elements(self, x1, y1, x2, y2):
        position_copy = copy.deepcopy(self.position)
        position_copy[x1][y1], position_copy[x2][y2] = position_copy[x2][y2], position_copy[x1][y1]

        return position_copy

    def find_tile(self, tile, position=None):
        if position is None:
            position = self.position

        for y in range(self.rows_num):
            for x in range(self.columns_num):
                if position[y][x] == tile:
                    return y, x

    def _get_inversions_count(self):
        inversion_count = 0
        puzzle_flat = [number for row in self.position for number in row if number != 0]

        for i in range(len(puzzle_flat)):
            for j in range(i + 1, len(puzzle_flat)):
                if puzzle_flat[i] > puzzle_flat[j]:
                    inversion_count += 1

        return inversion_count

    def get_possible_moves(self):
        moves = []
        y, x = self.find_tile(0)

        if y > 0:
            moves.append(Fifteen(self.swap_elements(y, x, y - 1, x)))
        if y < self.rows_num - 1:
            moves.append(Fifteen(self.swap_elements(y, x, y + 1, x)))
        if x < self.rows_num - 1:
            moves.append(Fifteen(self.swap_elements(y, x, y, x + 1)))
        if x > 0:
            moves.append(Fifteen(self.swap_elements(y, x, y, x - 1)))
        return moves

    def how_many_wrong(self):
        wrong = 0
        for y in range(self.rows_num):
            for x in range(self.columns_num):
                if self.position[y][x] != self.finish_position[y][x]:
                    wrong += 1
        return wrong

    def is_solvable(self):
        y, _ = self.find_tile(0)
        zero_position = (self.rows_num - y) - 1
        return True if (self._get_inversions_count() % 2 == 0 and zero_position % 2 == 0) or (
                self._get_inversions_count() % 2 == 1 and zero_position % 2 == 1) else False

    def _get_blank_space_row_counting_from_bottom(self):
        zero_row, _ = self.find_tile(0)  # blank space
        return self.rows_num - zero_row

    @staticmethod
    def _is_odd(num):
        return num % 2 != 0

    @staticmethod
    def _is_even(num):
        return num % 2 == 0

    def his(self):
        inversions_count = self._get_inversions_count()
        blank_position = self._get_blank_space_row_counting_from_bottom()

        if self._is_odd(self.rows_num) and self._is_even(inversions_count):
            return True
        elif self._is_even(self.rows_num) and self._is_even(blank_position) and self._is_odd(inversions_count):
            return True
        elif self._is_even(self.rows_num) and self._is_odd(blank_position) and self._is_even(inversions_count):
            return True
        else:
            return False


def get_random_solvable_fifteen():
    basic_list = [i for i in range(1, 16)]
    shuffle(basic_list)
    fifteen_list = []
    for i in range(4):
        fifteen_list.append(basic_list[i * 4:(i + 1) * 4])
    fifteen_list[-1].append(0)
    fifteen = Fifteen(fifteen_list)
    if not fifteen.is_solvable():
        fifteen = Fifteen(fifteen.swap_elements(x1=0, y1=0, x2=0, y2=1))
        assert fifteen.is_solvable()
    return fifteen
