def quickSort(array):
    less = []
    equal = []
    greater = []

    if len(array) > 1:
        pivot = array[0]
        less = list(filter(lambda x: x < pivot, array))
        greater = list(filter(lambda x: x > pivot, array))
        equal = [item for item in array if item not in less and item not in greater]

        return quickSort(less) + equal + quickSort(greater)
    else:
        return array


tab = [4, 6, 12, 4, 5, 6, 7, 3, 1, 15]

tab = quickSort(tab)

print(tab)
