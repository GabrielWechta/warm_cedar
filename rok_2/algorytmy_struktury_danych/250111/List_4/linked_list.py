import sys


class LinkedList:
    def __init__(self):
        self.head = None
        self.compares = 0

    def __iter__(self):
        node = self.head
        while node is not None:
            yield node.data
            node = node.next

    def insert(self, k):
        if self.head is None:
            self.head = Node(k)
            return
        current = self.head
        # if current.data == k:
        #     return
        while current.next is not None:
            if current.data == k:
                return
            current = current.next
        current.next = Node(k)

    def delete(self, k):
        if self.head is None:
            return

        if self.head.data == k:
            self.head = self.head.next
            return

        previous = self.head
        node = previous.next
        while node is not None:
            if node.data == k:
                previous.next = node.next
                return
            previous = node

    def find(self, k):
        self.compares = 0
        node = self.head
        while node is not None:
            x = node.data
            self.compares += 1
            if node.data == k:
                return 1
            node = node.next
        return 0

    def show(self):
        current = self.head

        while current is not None:
            sys.stdout.write(str(current.data) + " ")
            current = current.next

    def number_of_items(self):
        if self.head is None:
            return 0
        number = 0
        node = self.head
        while node is not None:
            node = node.next
            number += 1
        return number


class Node:
    def __init__(self, data):
        self.data = data
        self.next = None

# ll = LinkedList()
# ll.insert(1)
# ll.insert(7)
# ll.insert(9)
# for x in ll:
#     print(x)
