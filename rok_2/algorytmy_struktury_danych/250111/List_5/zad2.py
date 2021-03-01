import collections
import heapq
import sys
import time


def dijkstra(edges, source):
    graph = collections.defaultdict(list)
    traversed = {}
    for l, r, c in edges:
        graph[l].append((c, r))
        # graph[r].append((c, l))
        traversed[l] = [float("inf"), []]
        traversed[r] = [float("inf"), []]

    traversed[source] = [0.0, []]

    queue = [(0, source, [])]
    visited = set()
    heapq.heapify(queue)

    while queue:
        (cost, node, path) = heapq.heappop(queue)

        if node not in visited:
            visited.add(node)
            path = path + [node]

            for c, neighbour in graph[str(node)]:
                if neighbour not in visited:
                    heapq.heappush(queue, (cost + c, neighbour, path + [c]))
                    if traversed[neighbour][0] > cost + c:
                        traversed[neighbour][0] = cost + c
                        traversed[neighbour][1] = path + [c]

    for id_node in traversed:
        path_cost, way_of_path = traversed[id_node]
        print(id_node, round(path_cost, 8))
        print(way_of_path + [id_node], file=sys.stderr)


if __name__ == "__main__":
    start = time.time()
    _ = sys.stdin.readline()
    m = int(sys.stdin.readline())
    edges = []

    for _ in range(m):
        task = sys.stdin.readline()
        edge = task.split()
        edge_formatted = (str(edge[0]), str(edge[1]), float(edge[2]))
        edges.append(edge_formatted)

    s = int(sys.stdin.readline())
    dijkstra(edges, s)
    print(int(round((time.time() - start) * 1000)), "ms")
