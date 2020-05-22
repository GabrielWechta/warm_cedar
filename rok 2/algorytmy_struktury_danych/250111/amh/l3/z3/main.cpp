#include <iostream>
#include <vector>
#include <limits>
#include <set>
#include <chrono>
#include <cmath>

using namespace std;

void input(int &t, int &n, int &m, int &s, int &p, vector<vector<char>> &maze, vector<string> &base) {
    char in;
    string base_line;

    cin >> t >> n >> m >> s >> p;
    vector<char> maze_line;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            cin >> in;
            maze_line.push_back(in);
        }
        maze.push_back(maze_line);
        maze_line.clear();
    }
    for (int i = 0; i < s; i++) {
        cin >> base_line;
        base.push_back(base_line);
    }
}

void fakeInput(int &t, int &n, int &m, int &s, int &p, vector<vector<char>> &maze, vector<string> &base) {

    t = 2;
    n = 8;
    m = 5;
    s = 2;
    p = 10;
    vector<char> maze_line;

    maze_line.push_back('1');
    maze_line.push_back('1');
    maze_line.push_back('1');
    maze_line.push_back('1');
    maze_line.push_back('1');
    maze.push_back(maze_line);
    maze_line.clear();
    maze_line.push_back('1');
    maze_line.push_back('0');
    maze_line.push_back('0');
    maze_line.push_back('1');
    maze_line.push_back('1');
    maze.push_back(maze_line);
    maze_line.clear();
    maze_line.push_back('1');
    maze_line.push_back('0');
    maze_line.push_back('0');
    maze_line.push_back('0');
    maze_line.push_back('8');
    maze.push_back(maze_line);
    maze_line.clear();
    maze_line.push_back('1');
    maze_line.push_back('0');
    maze_line.push_back('5');
    maze_line.push_back('1');
    maze_line.push_back('1');
    maze.push_back(maze_line);
    maze_line.clear();
    maze_line.push_back('1');
    maze_line.push_back('8');
    maze_line.push_back('1');
    maze_line.push_back('1');
    maze_line.push_back('1');
    maze.push_back(maze_line);
    maze_line.clear();
    maze_line.push_back('1');
    maze_line.push_back('1');
    maze_line.push_back('0');
    maze_line.push_back('0');
    maze_line.push_back('1');
    maze.push_back(maze_line);
    maze_line.clear();
    maze_line.push_back('1');
    maze_line.push_back('0');
    maze_line.push_back('0');
    maze_line.push_back('0');
    maze_line.push_back('1');
    maze.push_back(maze_line);
    maze_line.clear();
    maze_line.push_back('1');
    maze_line.push_back('1');
    maze_line.push_back('8');
    maze_line.push_back('1');
    maze_line.push_back('1');
    maze.push_back(maze_line);
    maze_line.clear();

    base.push_back("ULURDRR");
    base.push_back("ULDD");
}

void showMaze(const vector<vector<char>> &maze) {
    for (int i = 0; i < maze.size(); i++) {
        for (int j = 0; j < maze[i].size(); j++) {
            cout << maze[i][j];
        }
        cout << endl;
    }
}

void showPopulation(const vector<string> &population) {
    for (int i = 0; i < population.size(); i++) {
        cout << population[i] << endl;
    }
}

void agentLocation(int &x, int &y, const vector<vector<char>> &maze) {
    bool found = false;

    for (y = 1; y < maze.size() && !found; y++) {
        for (x = 1; x < maze[y].size() && !found; x++) {
            if (maze[y][x] == '5') {
                found = true;
                x--;
                y--;
            }
        }
    }
}

bool reached(int x, int y, const vector<vector<char>> &maze) {
    return maze[y - 1][x] == '8' || maze[y][x + 1] == '8' || maze[y + 1][x] == '8' || maze[y][x - 1] == '8';
}

int pathLength(string path, const vector<vector<char>> &maze) {
    int x, y;
    int length = 0;
    agentLocation(x, y, maze);

    while (path[length] != '\0') {
        if (path[length] == 'U') y--;
        if (path[length] == 'D') y++;
        if (path[length] == 'R') x++;
        if (path[length] == 'L') x--;
        length++;
        if (maze[y][x] == '1') return numeric_limits<int>::max();
        if (reached(x, y, maze)) {
            return length;
        }
    }
    return numeric_limits<int>::max();
}

string randomIndividual(int n, int m) { //completely random path with fixed length
    string random_path = "";
    int direction;
    int diagonal_length = (int) pow(n * n + m * m, 0.5);

    for (int i = 0; i < rand() % diagonal_length + 1; i++) {
        direction = rand() % 4;
        switch (direction) {
            case 0:
                random_path += "U";
                break;
            case 1:
                random_path += "R";
                break;
            case 2:
                random_path += "D";
                break;
            case 3:
                random_path += "L";
                break;
            default:
                cerr << "Something bad happened in randomIndividual.";
                break;
        }
    }
    return random_path;
}

void twoPointCrossover(string parent_a, string parent_b, string &child_a, string &child_b) { //TODO really two point
    int i = rand() % parent_a.length();
    int j = rand() % parent_b.length();

    string a_end = parent_a.substr(i, parent_a.length());
    string b_end = parent_b.substr(j, parent_b.length());
    child_a = parent_a;
    child_b = parent_b;

    child_a.replace(i, -1, b_end);
    child_b.replace(j, -1, a_end);

}

string tongueMutate(string child) {
    char tongue;
    double p = 0.125; // For adding ends. It's like licking nearest surroundings.

    while (((double) rand() / (RAND_MAX)) < p) {
        p = p / 2.0;
        tongue = rand() % 4;
        switch (tongue) {
            case 0:
                child += "U";
                break;
            case 1:
                child += "R";
                break;
            case 2:
                child += "D";
                break;
            case 3:
                child += "L";
                break;
            default:
                cerr << "Something bad happened in tongueMutate.";
                break;
        }
    }
    return child;
}

string mutate(string child) {
//    cout << child << endl;
    for (auto &i : child) {
        if (((double) rand() / (RAND_MAX) < 0.5)) {
            int letter_ind = rand() % 4;
            switch (letter_ind) {
                case 0:
                    i = 'D';
                    break;
                case 1:
                    i = 'L';
                    break;
                case 2:
                    i = 'U';
                    break;
                case 3:
                    i = 'R';
                    break;
                default:
                    cerr << i << endl << "Something bad happened in mutate.";
                    break;
            }
        }
    }
    return child;
}

string geneticAlgorithm(int t, int pop_size, vector<vector<char>> &maze, vector<string> &base) {
    auto start = chrono::system_clock::now();
    auto end = chrono::system_clock::now();
    vector<string> P; //population
    string individual, parent_a, parent_b, child_a, child_b;
    string best;

    if (pop_size % 2 == 1) {
        pop_size++; //-- from necessity?
    }

    P.reserve(base.size());
    for (int i = 0; i < base.size() && i < pop_size; i++) {
        P.push_back(base[i]);
    }
    for (int i = P.size(); i < pop_size; i++) {
        P.push_back(randomIndividual(maze.size(), maze[0].size()));
    }

//    showPopulation(P);
    int iterator = 0;
    do {
        iterator++;
        for (auto &i : P) {
            individual = i;
            if (best.empty() || pathLength(individual, maze) < pathLength(best, maze)) {
                int length = pathLength(individual, maze);
                individual = individual.substr(0, length);
                best = individual;
            }
        }
        vector<string> Q;
        for (int j = 0; j < pop_size / 2; j++) {
            int a = rand() % pop_size;
            int b = rand() % pop_size;

            while (a == b) {
                b = rand() % pop_size;
            }

            parent_a = P[a];
            parent_b = P[b];
            twoPointCrossover(parent_a, parent_b, child_a, child_b);
//            cout << "child_a: " << child_a << " ";

            child_a = tongueMutate(mutate(child_a));
//            cout << "mutated: " << child_a << endl;
            child_b = tongueMutate(mutate(child_b));
            Q.push_back(child_a);
            Q.push_back(child_b);
        }
        P = Q;
        end = chrono::system_clock::now();
        if (chrono::duration_cast<chrono::seconds>(end - start).count() >= t) break;
    } while (true);

    return best;
}

int main() {
    int t, n, m, s, p;
    srand(time(NULL));
    vector<vector<char>> maze;
    vector<string> base;
    input(t, n, m, s, p, maze, base);
    string best = geneticAlgorithm(t, p, maze, base);

    cout << pathLength(best, maze);
    cerr << best;

    return 0;
}
