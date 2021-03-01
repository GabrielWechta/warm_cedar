import collections
import heapq
import random
import sys


class Kruskal_graph:
    def __init__(self, number_of_vertices):
        self.number_of_vertices = number_of_vertices
        self.queue = []
        self.result = []

    def add_edge(self, u, v, w):
        heapq.heappush(self.queue, [w, u, v])

    def find(self, parent, i):
        if parent[i] == i:
            return i
        return self.find(parent, parent[i])

    def apply_union(self, parent, rank, x, y):
        x_root = self.find(parent, x)
        y_root = self.find(parent, y)
        if rank[x_root] < rank[y_root]:
            parent[x_root] = y_root
        elif rank[x_root] > rank[y_root]:
            parent[y_root] = x_root
        else:
            parent[y_root] = x_root
            rank[x_root] += 1

    def kruskal(self):
        self.result = []
        i, e = 0, 0
        parent = []
        rank = []
        for node in range(self.number_of_vertices):
            parent.append(node)
            rank.append(0)
        while e < self.number_of_vertices - 1:
            w, u, v = heapq.heappop(self.queue)
            i = i + 1
            x = self.find(parent, u)
            y = self.find(parent, v)
            if x != y:
                e = e + 1
                self.result.append([u, v, w])
                self.apply_union(parent, rank, x, y)

    def print_results(self):
        sumus = 0
        if len(self.result) == 0:
            return

        for u, v, w in self.result:
            sumus += w
            print("{}, {} : {}".format(u, v, w)) if u < v else print("{}, {} : {}".format(v, u, w))
        print("total weight:", sumus)


class Prim_graph:
    def __init__(self, number_of_vertices, edges, source=0):

        self.edges_of_vertex = collections.defaultdict(list)
        for l, r, c in edges:
            self.edges_of_vertex[l].append((c, int(r)))
            self.edges_of_vertex[r].append((c, int(l)))

        self.graph = [[float("inf"), i, None] for i in range(number_of_vertices)]
        self.graph[source][0] = 0
        self.queue = [(0, source, None)]
        heapq.heapify(self.queue)

    def prim(self):
        visited = set()

        while self.queue:
            (key, node, prev) = heapq.heappop(self.queue)

            if node not in visited:
                visited.add(node)

                for weight, neighbour in self.edges_of_vertex[str(node)]:
                    if neighbour not in visited and weight < self.graph[neighbour][0]:
                        heapq.heappush(self.queue, [weight, neighbour, node])
                        self.graph[neighbour] = [weight, neighbour, node]

    def print_result(self):
        sumus = 0
        for w, u, v in self.graph:
            if v is None:
                pass
            else:
                sumus += w
                print("{}, {} : {}".format(u, v, w)) if u < v else print("{}, {} : {}".format(v, u, w))
        print("total weight:", sumus)


if __name__ == "__main__":
    n = int(sys.stdin.readline())
    m = int(sys.stdin.readline())

    if sys.argv[1] == "-k":
        kruskal_graph = Kruskal_graph(n)
        for _ in range(m):
            task = sys.stdin.readline()
            edge = task.split()
            kruskal_graph.add_edge(int(edge[0]), int(edge[1]), float(edge[2]))

        kruskal_graph.kruskal()
        kruskal_graph.print_results()
    elif sys.argv[1] == "-p":
        edges = []

        for _ in range(m):
            task = sys.stdin.readline()
            edge = task.split()
            edge_formatted = (str(edge[0]), str(edge[1]), float(edge[2]))
            edges.append(edge_formatted)

        prim_graph = Prim_graph(n, edges)
        prim_graph.prim()
        prim_graph.print_result()
    else:
        print("I am sorry, I only accept '-k' and '-p' flags.")
