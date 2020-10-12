import sys


def generate_transition_table(pattern, alphabet):
    m = len(pattern)
    trans = [{c: 0 for c in alphabet} for i in range(m)]
    for s in range(m):
        for c in alphabet:
            k = min(m, s + 1)
            while (pattern[:s] + c)[-k:] != pattern[:k]:
                k -= 1
            if k < 0:
                trans[s][c] = 0
            else:
                trans[s][c] = k

    return trans


def search(text, trans, m):
    answer = []
    s = 0
    i = 0
    while i < len(text):
        c = text[i]
        s = trans[s][c]
        if s == m:
            answer.append(i - m + 1)
            s = 0
            i = i - m + 1
        i += 1

    return answer


if __name__ == '__main__':
    file = open(sys.argv[2], "r")
    text = file.read()
    alphabet = "".join(set(text))
    pattern = sys.argv[1]

    finite_automaton = generate_transition_table(pattern, alphabet)
    # print(finite_automaton)
    print(search(text, finite_automaton, len(pattern)))
