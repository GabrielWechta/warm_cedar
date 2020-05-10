import time
import sys


class Scientist:
    def __init__(self):
        self.start_time = time.time()
        self.end_time = 0
        self.measure_start = 0

        self.number_of_inserts = 0
        self.number_of_deletes = 0
        self.number_of_finds = 0
        self.number_of_successors = 0
        self.number_of_loads = 0
        self.number_of_mines = 0
        self.number_of_maxes = 0
        self.number_of_inorders = 0

        self.time_of_inserts = 0
        self.time_of_deletes = 0
        self.time_of_finds = 0
        self.time_of_successors = 0
        self.time_of_loads = 0
        self.time_of_mines = 0
        self.time_of_maxes = 0
        self.time_of_inorders = 0

        self.number_of_structure_elements = 0
        self.maximum_number_of_structure_elements = 0

    def start_clock(self):
        self.measure_start = time.time()

    def insert_happened(self):
        self.number_of_inserts += 1
        self.number_of_structure_elements += 1
        if self.number_of_structure_elements > self.maximum_number_of_structure_elements:
            self.maximum_number_of_structure_elements = self.number_of_structure_elements
        self.time_of_inserts += time.time() - self.measure_start

    def delete_happened(self):
        self.number_of_deletes += 1
        self.number_of_structure_elements -= 1
        self.time_of_deletes += time.time() - self.measure_start

    def find_happened(self):
        self.number_of_finds += 1
        self.time_of_finds += time.time() - self.measure_start

    def successor_happened(self):
        self.number_of_successors += 1
        self.time_of_successors += time.time() - self.measure_start

    def load_happened(self):
        self.number_of_loads += 1
        self.time_of_loads += time.time() - self.measure_start

    def min_happened(self):
        self.number_of_mines += 1
        self.time_of_mines += time.time() - self.measure_start

    def max_happened(self):
        self.number_of_maxes += 1
        self.time_of_maxes += time.time() - self.measure_start

    def inorder_happened(self):
        self.number_of_inorders += 1
        self.time_of_inorders += time.time() - self.measure_start

    def describe_program(self):
        sys.stderr.write("program time: " + str(time.time() - self.start_time) + "\n")
        sys.stderr.write("inserts: " + str(self.number_of_inserts) + "\n")
        sys.stderr.write("deletes: " + str(self.number_of_deletes) + "\n")
        sys.stderr.write("finds: " + str(self.number_of_finds) + "\n")
        sys.stderr.write("successors: " + str(self.number_of_successors) + "\n")
        sys.stderr.write("loads: " + str(self.number_of_loads) + "\n")
        sys.stderr.write("mines: " + str(self.number_of_mines) + "\n")
        sys.stderr.write("maxes: " + str(self.number_of_maxes) + "\n")
        sys.stderr.write("inorders: " + str(self.number_of_inorders) + "\n")
        sys.stderr.write(
            "\t" + "structure elements stats: " + "\n")
        sys.stderr.write("maximum number of elements: " + str(self.maximum_number_of_structure_elements) + "\n")
        sys.stderr.write("currently in structure: " + str(self.number_of_structure_elements) + "\n")
        sys.stderr.write(
            "\t" + "average times: " + "\n")
        # quality of this code is "Pożal się Boże" kind, but it's really enough for today
        sys.stderr.write(
            "for insert: " + str(
                self.time_of_inserts / self.number_of_inserts) if self.number_of_inserts else "for insert: " + "0")
        sys.stderr.write("\n")
        sys.stderr.write("for delete: " + str(
            self.time_of_deletes / self.number_of_deletes) if self.number_of_deletes else "for delete: " + "0")
        sys.stderr.write("\n")
        sys.stderr.write(
            "for find: " + str(
                self.time_of_finds / self.number_of_finds) if self.number_of_finds else "for find: " + "0")
        sys.stderr.write("\n")
        sys.stderr.write("for successor: " + str(
            self.time_of_successors / self.number_of_successors) if self.number_of_successors else "for successor: " + "0")
        sys.stderr.write("\n")
        sys.stderr.write(
            "for load: " + str(
                self.time_of_loads / self.number_of_loads) if self.number_of_loads else "for load: " + "0")
        sys.stderr.write("\n")
        sys.stderr.write(
            "for min: " + str(self.time_of_mines / self.number_of_mines) if self.number_of_mines else "for min: " + "0")
        sys.stderr.write("\n")
        sys.stderr.write(
            "for max: " + str(self.time_of_maxes / self.number_of_maxes) if self.number_of_maxes else "for max: " + "0")
        sys.stderr.write("\n")
        sys.stderr.write("for inorder: " + str(
            self.time_of_inorders / self.number_of_inorders) if self.number_of_inorders else "for inorder: " + "0")
        sys.stderr.write("\n")
