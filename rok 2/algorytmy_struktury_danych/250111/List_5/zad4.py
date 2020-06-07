import random
import sys
import time
from collections import defaultdict


class Graph:
    def __init__(self, n, edges):
        self.graph = defaultdict(list)
        self.visited_graph = set()
        self.size = n
        self.random_source = random.randint(0, self.size - 1)

        for left, right, cost in edges:
            self.graph[left].append((cost, right))
            self.graph[right].append((cost, left))

    def forget(self):
        self.visited_graph.clear()

    def random_search(self):
        steps, total_cost, start_time = 0, 0, time.time()
        path = []
        self.forget()
        node = self.random_source
        path.append(node)
        self.visited_graph.add(node)

        while len(self.visited_graph) != self.size:
            possibilities = self.graph[node]
            cost, node = possibilities[random.randint(0, self.size - 2)]
            self.visited_graph.add(node)
            path.append(node)

            steps += 1
            total_cost += cost

        # print("----RANDOM_SEARCH----:")
        print(steps, total_cost, sys.getsizeof(self.visited_graph) + sys.getsizeof(self.graph),
              time.time() - start_time, "s")
        print(path, file=sys.stderr)

    def greedy(self):
        steps, total_cost, start_time = 0, 0, time.time()
        path = []
        self.forget()
        node = self.random_source
        path.append(node)
        self.visited_graph.add(node)

        while len(self.visited_graph) != self.size:
            possibilities = self.graph[node]
            for cost, node in sorted(possibilities, key=lambda x: x[0]):
                if node not in self.visited_graph:
                    self.visited_graph.add(node)
                    path.append(node)

                    steps += 1
                    total_cost += cost

        # print("----GREEDY----:")
        print(steps, total_cost, sys.getsizeof(self.visited_graph) + sys.getsizeof(self.graph),
              time.time() - start_time, "s")
        print(path, file=sys.stderr)

    def euler(self):  # TODO
       # print("----EULER----:")
        print("To be implemented.")


if __name__ == "__main__":
    # start = time.time()
    n = int(sys.stdin.readline())
    edges = []

    for _ in range(int(n * (n - 1) / 2)):
        task = sys.stdin.readline()
        edge = task.split()
        edge_formatted = (int(edge[0]), int(edge[1]), float(edge[2]))
        edges.append(edge_formatted)

    graph = Graph(n, edges)
    graph.random_search()
    graph.greedy()
    graph.euler()
