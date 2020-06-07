import sys
from math import inf


def parent(i):
    return i - 1 >> 1


def left(i):
    return i + i + 1


def right(i):
    return i + i + 2


class QueueElement:
    def __init__(self, key, priority=inf):
        self.key = key
        self.priority = priority

    def __repr__(self):
        return "({}, {})".format(self.key, int(self.priority))

    def __str__(self):
        return repr(self)

    def __lt__(self, other):
        return self.priority < other.priority


class PriorityQueue:
    def __init__(self):
        self.elements = []
        self.size = 0

    def __str__(self):
        return ", ".join(str(el) for el in self.elements)

    def __len__(self):
        return self.size

    def __contains__(self, el):
        return el in self.elements

    def _heapify(self, i):
        l = left(i)
        r = right(i)
        first = i
        if l < self.size and self.elements[l] < self.elements[i]:
            first = l
        if r < self.size and self.elements[r] < self.elements[first]:
            first = r
        if first != i:
            self.elements[first], self.elements[i] = self.elements[i], self.elements[first]
            self._heapify(first)

    def empty(self):
        print(0 if self.size else 1)

    def top(self):
        print(self.elements[0].key if self.elements else "")

    def pop(self):
        popped = self._pop()
        print(popped.key if popped else "")

    def _pop(self):
        if self.size:
            popped = self.elements.pop()
            self.size -= 1
            if self.size:
                self.elements[0], popped = popped, self.elements[0]
                self._heapify(0)
            return popped

    def print(self):
        print(self)

    def insert(self, key, priority):
        self.elements.append(QueueElement(key))
        self._increase_priority(self.size, float(priority))
        self.size += 1

    def priority(self, key, new_priority):
        new_priority = float(new_priority)
        affected = [
            ind
            for ind, el in enumerate(self.elements)
            if el.key == key and el.priority > new_priority
        ]
        for i in affected:
            self._increase_priority(i, new_priority)

    def _increase_priority(self, i, new_priority):
        element = self.elements[i]
        element.priority = new_priority
        while i > 0:
            p = parent(i)
            if element < self.elements[p]:
                self.elements[i], self.elements[p] = self.elements[p], self.elements[i]
                i = p
            else:
                break


if __name__ == "__main__":
    queue = PriorityQueue()
    while True:
        try:
            m = int(input())
            break
        except ValueError:
            print("Please enter the number of lines (an integer)")
            continue

    for _ in range(m):
        task = sys.stdin.readline()
        if len(task.split()) == 3:
            fun, x, p = task.split()
            # print(fun, x, p)
            method = getattr(queue, fun)
            method(x, p)
        if len(task.split()) == 1:
            method = getattr(queue, task.split()[0])
            method()
