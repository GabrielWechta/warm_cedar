import random
from time import time
from sys import stderr
import sys


class GeneticAlgorithm:
    def __init__(self, alphabet, dictionary, samples, pop_size=20, mutation_chance=0.25, extension_chance=0.75,
                 extension_factor=0.5):
        self.alphabet = alphabet
        self.dictionary = dictionary
        letter_pool = []  # allowed letters.
        for ch in alphabet:
            letter_pool += alphabet[ch][1] * [ch]

        self.start_population = samples
        for _ in range(pop_size - len(samples)):  # adding random allowed words to start_population.
            random.shuffle(letter_pool)
            while True:
                new_word = "".join(letter_pool[:random.randint(1, len(letter_pool))])
                if new_word not in self.start_population: break
            self.start_population.append(new_word)
        self.pop_size = pop_size

        self.mutation_chance = mutation_chance
        self.extension_chance = extension_chance
        self.extension_factor = extension_factor

    def fitness(self, word):
        try:
            return self.dictionary[word]
        except KeyError:
            return 0

    def select_parent(self, population):
        picks = random.sample(population,
                              k=2)  # pick 2 random candidates and choose one of them. Idea from Essentials.
        return max(picks, key=lambda w: self.fitness(w))

    def battle_royal(self, population):
        random.shuffle(population)
        groups = [population[i::self.pop_size] for i in
                  range(self.pop_size)]  # fixing population size by selecting best individuals in groups.
        survivors = [max(g, key=lambda w: self.fitness(w)) for g in groups]
        return survivors

    def crossover(self, p1, p2):  # crossover by phd Syga. Mixing suffixes with random pivot.
        limit = min(len(p1), len(p2))
        i = random.randrange(0, len(p1))
        j = random.randrange(0, len(p2))

        c1 = list(p1)
        c2 = list(p2)
        c1[i:], c2[j:] = c2[j:], c1[i:]

        return "".join(c1), "".join(c2)

    def mutate(self, c):  # mutate with two stages.
        chars = list(c)
        available = [ch for ch in self.alphabet.keys() if chars.count(ch) < self.alphabet[ch][1]]
        if available:
            for i in range(len(c)):  # changing random letter in word, with probability self.mutation chance.
                if self.mutation_chance >= random.random():
                    cur_char = chars[i]
                    chars[i] = random.choice(available)
                    available.remove(chars[i])
                    available.append(cur_char)

            extension_probability = self.extension_chance
            while available:  # extending word with probability self.extension_probability.
                if extension_probability >= random.random():
                    new_char = random.choice(available)
                    chars.append(new_char)
                    available.remove(new_char)
                    extension_probability *= self.extension_factor
                else:
                    break
        else:
            random.shuffle(chars)

        return "".join(chars)

    def run(self, max_time):
        population = self.start_population.copy()
        best = population[0]  # any can be best.

        while time() < max_time:  # until we run out of time.
            for p in population:
                if self.fitness(p) > self.fitness(best):
                    best = p
            next_gen = population.copy()
            for _ in range(self.pop_size):  # standard genetic procedure.
                p1 = self.select_parent(population)
                p2 = self.select_parent(population)
                c1, c2 = self.crossover(p1, p2)
                next_gen.extend([self.mutate(c1), self.mutate(c2)])
            population = self.battle_royal(next_gen)

        return best


def main():
    start_time = time()
    data = sys.stdin.readline().split()
    t, n, s = int(data[0]), int(data[1]), int(data[2])  # reading first 3 vars.
    alphabet = [(line[0], int(line[1])) for _ in range(n) if (line := input().split())]  # parsing alphabet to list.
    alphabet = {
        ch: (pt, alphabet.count((ch, pt))) for ch, pt in alphabet
    }  # parsing alphabet to dic.
    start_population = [input().lower().strip() for _ in range(s)]  # first in population are words in input.
    with open("dict.txt") as f:  # we consider only words from dict.txt which are constructed from allowed letters.
        dictionary = {
            word: fitness
            for line in f.readlines()
            if (word := line.strip().lower())
               and all(
                [
                    char in alphabet and word.count(char) <= alphabet[char][1]
                    for char in word
                ]
            )
               and (fitness := sum(alphabet[char][0] for char in word))
        }
    model = GeneticAlgorithm(alphabet, dictionary, start_population)  # initialing model
    word = model.run(t + start_time)  # starting genetic algorithm with given time.
    print(model.fitness(word))
    print(word, file=stderr)


if __name__ == "__main__":
    main()
