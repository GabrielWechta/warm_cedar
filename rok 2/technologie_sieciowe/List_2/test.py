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
                evaluated_row.append(random.randint(1, up_range))
        evaluated_matrix.append(evaluated_row)
    return evaluated_matrix


def create_edge_dic(graph):
    dic = {}
    for edge in graph.edges():
        dic[edge] = 0

    return dic


def all_paths_to_travel(matrix, graph):
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


size = 20
# # Creating graph G
# G = nx.Graph()
# for v in range(size - 1):
#     G.add_node(v)
#
# # Creating circular topology
# for e in range(size - 1):
#     G.add_edge(e, e + 1)
# G.add_edge(0, size - 1)

G = nx.cycle_graph(19)
G.add_node(19)
for node in G.nodes():
    G.add_edge(19, node)

nx.draw(G, with_labels=True)
plt.show()

N = createMatrix(size)
N = evaluate(N, 20)

for row in N:
    print(row)

edge_dic = create_edge_dic(G)
capacity_edge_dic = create_edge_dic(G)

all_paths = all_paths_to_travel(N, G)
print(all_paths)
a(all_paths, edge_dic)
c(capacity_edge_dic, 10000)
print(edge_dic)
print(capacity_edge_dic)


def delay(graph, matrix, m):
    G = sum(reduce(lambda x, y: x + y, matrix))
    sumus_maximus = 0
    for edge in graph.edges():
        sumus_maximus += edge_dic[edge] / (capacity_edge_dic[edge] / m - edge_dic[edge])
    return 1 / G * sumus_maximus


def delay_reliability(start_graph, matrix, t_max, p, intervals=10, repetitions=1000):
    positive = 0
    for _ in range(repetitions):
        graph = start_graph.copy()

        for _ in range(intervals):
            for edge in list(graph.edges()):
                print(edge)
                if random.random() > p:
                    graph.remove_edge(*edge)
            if not nx.is_connected(graph):
                break
            d = delay(graph, matrix, 8)
            if 0 < d < t_max:
                positive += 1

    return positive / (repetitions * intervals)


print(delay_reliability(G, N, 0.1, 0.95))
