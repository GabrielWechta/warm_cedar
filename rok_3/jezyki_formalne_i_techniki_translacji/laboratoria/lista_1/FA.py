import sys


def generate_transition_dic(pattern, alphabet):
    m = len(pattern)
    trans = [{c: 0 for c in alphabet} for i in range(m)]
    for s in range(m):
        for c in alphabet:
            k = min(m, s + 1)
            while (pattern[:s] + c)[-k:] != pattern[:k]:
                k -= 1
            if k < 0:
                trans[s][c] = 0 # if it's not a "substate".
            else:
                trans[s][c] = k # if it's a "substate".

    return trans


def search(text, trans, m):
    answer = []
    s = 0
    i = 0
    while i < len(text):
        c = text[i]
        s = trans[s][c] # getting state
        if s == m:
            answer.append(i - m + 1)
            s = 0
            i = i - m + 1 # in order to get also patterns insight diffrent patterns we have to go back with index i.
        i += 1

    return answer


if __name__ == '__main__':
    file = open(sys.argv[2], "r")
    text = file.read()
    alphabet = "".join(set(text)) # we need only one occurrence of every character, set() is solution
    pattern = sys.argv[1] # we need it as string

    finite_automaton = generate_transition_dic(pattern, alphabet)
    # print(finite_automaton)
    print(search(text, finite_automaton, len(pattern)))
