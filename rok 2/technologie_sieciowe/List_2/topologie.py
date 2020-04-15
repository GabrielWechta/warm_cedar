from functools import reduce
import random

import networkx as nx
import matplotlib.pyplot as plt


def createMatrix(matrix_size):
    matrix = []
    for x in range(matrix_size):
        matrix_row = []
        for y in range(matrix_size):
            matrix_row.append((x, y))
        matrix.append(matrix_row)
    return matrix


def evaluate(matrix, up_range):
    evaluated_matrix = []
    for matrix_row in matrix:
        evaluated_row = []
        for x, y in matrix_row:
            if x == y:
                evaluated_row.append(0)
            else:
                evaluated_row.append(random.randint(0, up_range))
        evaluated_matrix.append(evaluated_row)
    return evaluated_matrix


def create_edge_dic(graph):
    dic = {}
    for edge in graph.edges():
        dic[edge] = 0

    return dic


def all_paths_to_travel(graph, matrix):
    to_travel = []
    for x in range(len(matrix[0])):
        for y in range(len(matrix[0])):
            path = []
            if matrix[x][y] != 0:
                path.append((x, y, matrix[x][y]))
                path.append(nx.shortest_path(graph, x, y))
                to_travel.append(path)
    return to_travel


def a(to_travel, edges):
    for guidance in to_travel:
        cost = guidance[0][2]
        for x in range(len(guidance[1]) - 1):
            first = guidance[1][x]
            second = guidance[1][x + 1]
            if first < second:
                edges[(first, second)] += cost
            else:
                edges[(second, first)] += cost


def c(capacity_edges, parameter):
    for key in capacity_edges:
        capacity_edges[key] = parameter


def delay(graph, matrix, m, edge_dic, capacity_edge_dic):
    G = sum(reduce(lambda x, y: x + y, matrix))
    sumus_maximus = 0
    for edge in graph.edges():
        try:
            sumus_maximus += edge_dic[edge] / (capacity_edge_dic[edge] / m - edge_dic[edge])
        except ZeroDivisionError:
            return -1
    return 1 / G * sumus_maximus


def delay_reliability(start_graph, capacity_edge_dic, matrix, t_max, p, intervals=10, repetitions=1000):
    positive = 0
    for _ in range(repetitions):
        graph = start_graph.copy()

        for _ in range(intervals):
            for edge in list(graph.edges()):
                if random.random() > p:
                    graph.remove_edge(*edge)
            if not nx.is_connected(graph):
                break
            all_paths = all_paths_to_travel(graph, matrix)
            edge_dic = create_edge_dic(graph)
            a(all_paths, edge_dic)
            # print(edge_dic)
            d = delay(graph, matrix, 8, edge_dic, capacity_edge_dic)
            if 0 < d < t_max:
                positive += 1

    return positive / (repetitions * intervals)


def improve(graph, how_many):
    added = 0
    while added < how_many:
        first = random.randint(0, graph.number_of_nodes())
        second = random.randint(0, graph.number_of_nodes())
        if first != second and not graph.has_edge(first, second):
            graph.add_edge(first, second)
            added += 1


def main():
    # size = 20
    # capacity = 10000
    # improved = nx.cycle_graph(size)
    # improve(improved, 1000)
    #
    # full = nx.complete_graph(20)
    #
    # shuriken = nx.cycle_graph(size)
    # shuriken.add_edge(0,10)
    # shuriken.add_edge(5,15)
    #
    # cycle = nx.cycle_graph(size)
    #
    # kolowy = nx.cycle_graph(size-1)
    # kolowy.add_node(size - 1)
    # for node in kolowy.nodes():
    #     if node != size - 1:
    #         kolowy.add_edge(size - 1, node)
    # #
    # nx.draw_spectral(full, with_labels=True)
    # plt.show()
    #
    # N = createMatrix(size)
    # N = evaluate(N, 20)
    # cycle_cap = create_edge_dic(improved)
    # c(cycle_cap, capacity)
    #
    # improved_cap = create_edge_dic(improved)
    # c(improved_cap, capacity)
    #
    # print(delay_reliability(improved, improved_cap, N, 0.1, 0.95))
    #
    #
    # print(delay_reliability(cycle, cycle_cap, N, 0.1, 0.95))
    #
    # shuriken_cap = create_edge_dic(shuriken)
    # c(shuriken_cap, capacity)
    #
    # print(delay_reliability(shuriken, shuriken_cap, N, 0.1, 0.95))
    #
    # kolowy_cap = create_edge_dic(kolowy)
    # c(kolowy_cap, capacity)
    #
    # print(delay_reliability(kolowy, kolowy_cap, N, 0.1, 0.95))


if __name__ == "__main__":
    random.seed()
    main()
