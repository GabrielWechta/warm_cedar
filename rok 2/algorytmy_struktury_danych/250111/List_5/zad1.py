import math
import sys


class Element:
    def __init__(self, key, priority=math.inf):
        self.key = key
        self.priority = priority

    def __lt__(self, other):
        return self.priority < other.priority

    def __le__(self, other):
        return self.priority <= other.priority

    def __gt__(self, other):
        return self.priority > other.priority

    def __ge__(self, other):
        return self.priority >= other.priority


class HeapQueue:
    def __init__(self):
        self.heapList = [Element(0, 0)]
        self.currentSize = 0

    def go_up(self, i):
        while i // 2 > 0:
            if self.heapList[i] < self.heapList[i // 2]:
                tmp = self.heapList[i // 2]
                self.heapList[i // 2] = self.heapList[i]
                self.heapList[i] = tmp
            i = i // 2

    def insert(self, x, p):
        self.heapList.append(Element(x, p))
        self.currentSize = self.currentSize + 1
        self.go_up(self.currentSize)

    def go_down(self, i):
        while (i * 2) <= self.currentSize:
            mc = self.min_child(i)
            if self.heapList[i] > self.heapList[mc]:
                tmp = self.heapList[i]
                self.heapList[i] = self.heapList[mc]
                self.heapList[mc] = tmp
            i = mc

    def min_child(self, i):
        if i * 2 + 1 > self.currentSize:
            return i * 2
        else:
            if self.heapList[i * 2] < self.heapList[i * 2 + 1]:
                return i * 2
            else:
                return i * 2 + 1

    def pop(self):
        first = self.heapList[1]
        self.heapList[1] = self.heapList[self.currentSize]
        self.currentSize = self.currentSize - 1
        self.heapList.pop()
        self.go_down(1)
        print(first.key)

    def top(self):
        print(self.heapList[1].key)

    def empty(self):
        print(1 if self.currentSize == 0 else 0)

    def print(self):
        for element in self.heapList[1:]:
            print("({}, {})".format(element.key, element.priority), sep="", end=" ")
        print()

    def priority(self, key, new_priority):
        for element in self.heapList:
            if element.key == key and element.priority < new_priority:
                element.priority = new_priority
        self.heapify(self.heapList)

    def heapify(self, list_to_heap):
        i = len(list_to_heap) // 2
        self.heapList = list_to_heap
        while i > 0:
            self.go_down(i)
            i = i - 1


if __name__ == "__main__":
    queue = HeapQueue()

    m = int(sys.stdin.readline())
    for operation_count in range(m):
        try:
            task = sys.stdin.readline()
            if len(task.split()) == 3:
                fun, x, p = task.split()
                # print(fun, x, p)
                method = getattr(queue, fun)
                method(x, p)
            if len(task.split()) == 1:
                method = getattr(queue, task.split()[0])
                method()
        except AttributeError:
            print("I believe you have used incorrect operation name.")
