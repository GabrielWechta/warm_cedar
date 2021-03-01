import random
import sys
import time

num_dimensions = 5


def yang(x):
    total = 0
    for i in range(len(x)):
        total += e_vec[i] * (abs(x[i]) ** (i + 1))
    return total


class Particle:
    def __init__(self, x_0):
        self.position_i = []
        self.velocity_i = []
        self.pos_best_i = []
        self.fit_best_i = -1
        self.fit_i = -1

        for i in range(0, num_dimensions):
            self.velocity_i.append(random.uniform(-1, 1))
            self.position_i.append(x_0[i])

    def evaluate(self, costFunc):
        self.fit_i = costFunc(self.position_i)

        if self.fit_i < self.fit_best_i or self.fit_best_i == -1:
            self.pos_best_i = self.position_i
            self.fit_best_i = self.fit_i

    def update_velocity(self, pos_best_g):
        w = 0.5
        c1 = 1
        c2 = 2

        for i in range(0, num_dimensions):
            r1 = random.random()
            r2 = random.random()

            vel_cognitive = c1 * r1 * (self.pos_best_i[i] - self.position_i[i])
            vel_social = c2 * r2 * (pos_best_g[i] - self.position_i[i])
            self.velocity_i[i] = w * self.velocity_i[i] + vel_cognitive + vel_social

    def update_position(self, bounds):
        for i in range(0, num_dimensions):
            self.position_i[i] = self.position_i[i] + self.velocity_i[i]

            if self.position_i[i] > bounds[i][1]:
                self.position_i[i] = bounds[i][1]

            if self.position_i[i] < bounds[i][0]:
                self.position_i[i] = bounds[i][0]


class PSO:
    def __init__(self, max_time, costFunc, x_0, bounds, num_particles):
        start = time.time()
        fit_best_g = -1
        pos_best_g = []

        swarm = []
        for i in range(0, num_particles):
            swarm.append(Particle([random.uniform(0.6, 1.0) * x_i for x_i in x_0]))

        i = 0
        while time.time() - start < max_time:
            for j in range(0, num_particles):
                swarm[j].evaluate(costFunc)

                if swarm[j].fit_i < fit_best_g or fit_best_g == -1:
                    pos_best_g = list(swarm[j].position_i)
                    fit_best_g = float(swarm[j].fit_i)

            for j in range(0, num_particles):
                swarm[j].update_velocity(pos_best_g)
                swarm[j].update_position(bounds)
            i += 1

        for x_i in pos_best_g:
            print(x_i, end=" ")
        print(yang(pos_best_g))


if __name__ == "__main__":
    data = sys.stdin.readline().split()
    t = int(data[0])
    x_vec, e_vec = [], []
    for i in range(1, 6):
        x_vec.append(float(data[i]))
    for i in range(6, 11):
        e_vec.append(float(data[i]))

    bounds = [(-5, 5), (-5, 5), (-5, 5), (-5, 5), (-5, 5)]
    PSO(t, yang, x_vec, bounds, num_particles=200)
