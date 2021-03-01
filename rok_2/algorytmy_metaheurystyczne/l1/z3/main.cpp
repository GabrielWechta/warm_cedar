#include <iostream>
#include <vector>
#include <limits>
#include <set>
#include <chrono>

using namespace std;

void input(int &t, int &n, int &m, vector<vector<char>> &maze) {
    char in;
    cin >> t >> n >> m;
    vector<char> maze_line;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            cin >> in;
            maze_line.push_back(in);
        }
        maze.push_back(maze_line);
        maze_line.clear();
    }
}

void fakeInput(int &t, int &n, int &m, vector<vector<char>> &maze) {

    t = 2;
    n = 5;
    m = 4;
    vector<char> maze_line;

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
    maze.push_back(maze_line);
    maze_line.clear();
    maze_line.push_back('1');
    maze_line.push_back('0');
    maze_line.push_back('5');
    maze_line.push_back('1');
    maze.push_back(maze_line);
    maze_line.clear();
    maze_line.push_back('1');
    maze_line.push_back('0');
    maze_line.push_back('0');
    maze_line.push_back('1');
    maze.push_back(maze_line);
    maze_line.clear();
    maze_line.push_back('1');
    maze_line.push_back('8');
    maze_line.push_back('1');
    maze_line.push_back('1');
    maze.push_back(maze_line);
    maze_line.clear();

} //CLion has problems..

void showMaze(const vector<vector<char>> &maze) {
    for (int i = 0; i < maze.size(); i++) {
        for (int j = 0; j < maze[i].size(); j++) {
            cout << maze[i][j];
        }
        cout << endl;
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

string drunkPath(const vector<vector<char>> &maze) {
    int x, y;
    agentLocation(x, y, maze);

    string path;
    while (maze[y - 1][x] != '1') {
        y--;
        path += "U";
        if (reached(x, y, maze)) return path;
    }
    while (maze[y][x + 1] != '1') {
        x++;
        path += "R";
        if (reached(x, y, maze)) return path;
    }
    while (maze[y + 1][x] != '1') {
        y++;
        path += "D";
        if (reached(x, y, maze)) return path;
    }
    while (maze[y][x - 1] != '1') {
        x--;
        path += "L";
        if (reached(x, y, maze)) return path;
    }
    while (maze[y - 1][x] != '1') {
        y--;
        path += "U";
        if (reached(x, y, maze)) return path;
    }
    while (maze[y][x + 1] != '1') {
        x++;
        path += "R";
        if (reached(x, y, maze)) return path;
    }
    return "Agent is lost.";
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

string tweak(string s) {
    int i = rand() % s.length();
    int j = rand() % s.length();

    char tmp = s[i];
    s[i] = s[j];
    s[j] = tmp;
    return s;
}

string minimumPath(int t, const vector<vector<char>> &maze) {
    auto start = chrono::system_clock::now();
    auto end = chrono::system_clock::now();
    int set_size = 1000;
    int tweaks_number = 10; //with this const algorithm managed to find best solution for 2nd input in < 1s. Every time it discarded all 'D' moves. I guess it's ok, explanation in documentation.

    string s = drunkPath(maze);
    string best = s;
    set<string> my_set;
    my_set.insert(s);
    while (true) {
        if (my_set.size() > set_size) {
            my_set.erase(my_set.begin());
        }
        string r = tweak(s);
        for (int i = 0; i < tweaks_number; i++) {
            string w = tweak(s);
//            cout << w << endl;
            if (my_set.count(w) == 0 && (pathLength(w, maze) < pathLength(r, maze) || my_set.count(r) != 0)) {
                int length = pathLength(w, maze);
                r = w.substr(0, length);
                my_set.clear();
            }
        }
        if (my_set.count(r) == 0) {
            s = r;
            my_set.insert(r);
        }
        if (pathLength(s, maze) < pathLength(best, maze)) {
            best = s;
        }
        auto end = chrono::system_clock::now();
        if (chrono::duration_cast<chrono::seconds>(end - start).count() >= t) break;
    }
    return best;
}

int main() {
    int t, n, m;
    srand(time(NULL));
    vector<vector<char>> maze;
    input(t, n, m, maze);

    string best = minimumPath(t, maze);

    cout << best.length();
    cerr << best;

    return 0;
}

