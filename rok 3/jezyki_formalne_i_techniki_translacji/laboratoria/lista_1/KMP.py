import sys


def get_prefix_array(pattern):
    prefix_array = [0] * len(pattern)
    i = 1
    m = 0

    while i < len(pattern):
        if pattern[i] == pattern[m]:
            m += 1
            prefix_array[i] = m
            i += 1
        elif pattern[i] != pattern[m] and m != 0:
            m = prefix_array[m - 1]
        else:
            prefix_array[i] = 0
            i += 1
    return prefix_array


def get_occurrences(file_name, pattern, prefix_array):
    occurrences = []
    file = open(file_name, "r")
    text = file.read()

    p = 0
    t = 0
    text_length = len(text)

    while t < text_length:
        if pattern[p] != text[t]:
            if p == 0:
                t += 1
            else:
                p = prefix_array[p - 1]
        else:
            p += 1
            t += 1
            if p == len(pattern):
                occurrences.append(t - p)
                p = prefix_array[p - 1]

    file.close()
    return occurrences



if __name__ == '__main__':
    pattern = sys.argv[1]
    prefix_array = get_prefix_array(pattern)
    print(get_occurrences(sys.argv[2], pattern, prefix_array))