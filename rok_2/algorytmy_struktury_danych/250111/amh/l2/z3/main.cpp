#include <iostream>
#include <vector>
#include <limits>
#include <set>
#include <chrono>
#include <queue>
#include <cstring>
#include <math.h>

using namespace std;

const int rowNum[] = {-1, 0, 0, 1};
const int colNum[] = {0, -1, 1, 0};

struct Location {
    int x;
    int y;
    string way;
};

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

}

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

    for (x = 1; x < maze.size() && !found; x++) {
        for (y = 1; y < maze[0].size() && !found; y++) {
            if (maze[x][y] == '5') {
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
            return length + 1;
        }
    }
    return numeric_limits<int>::max();
}

string bfsPath(const vector<vector<char>> &maze) {
    int x, y;
    agentLocation(x, y, maze);

    bool visited[maze.size()][maze[0].size()];
    memset(visited, false, sizeof visited);
    visited[x][y] = true;

    Location agentLoc = {x, y, ""};

    queue<Location> q;
    q.push(agentLoc);

    while (!q.empty()) {
        Location curr = q.front();
        //cout << curr.x << " " << curr.y << " " << curr.way << endl;
        q.pop();

        if (maze[curr.x][curr.y] == '8') {
            return curr.way;
        }

        Location neighbour;

        if (maze[curr.x - 1][curr.y] != '1' && !visited[curr.x - 1][curr.y]) {
            neighbour = {curr.x - 1, curr.y, curr.way + "U"};
            visited[curr.x - 1][curr.y] = true;
            q.push(neighbour);
        }
        if (maze[curr.x][curr.y - 1] != '1' && !visited[curr.x][curr.y - 1]) {
            neighbour = {curr.x, curr.y - 1, curr.way + "L"};
            visited[curr.x][curr.y - 1] = true;
            q.push(neighbour);
        }
        if (maze[curr.x + 1][curr.y] != '1' && !visited[curr.x + 1][curr.y]) {
            neighbour = {curr.x + 1, curr.y, curr.way + "D"};
            visited[curr.x + 1][curr.y] = true;
            q.push(neighbour);
        }
        if (maze[curr.x][curr.y + 1] != '1' && !visited[curr.x][curr.y + 1]) {
            neighbour = {curr.x, curr.y + 1, curr.way + "R"};
            visited[curr.x][curr.y + 1] = true;
            q.push(neighbour);
        }
    }

    cerr << "didn't find path." << endl;
    return "Error, didn't find path.";
}

string tweak(string s) {
    int i = rand() % s.length();
    int j = rand() % s.length();

    char tmp = s[i];
    s[i] = s[j];
    s[j] = tmp;
    return s;
}

string minimumPath(int time, const vector<vector<char>> &maze) {
    auto start = chrono::system_clock::now();
    auto end = chrono::system_clock::now();

    double temperature = 10;
    string s = bfsPath(maze);
    string best = s;
    string r;
    int r_quality, s_quality;
    double coolness = 0.0;

    do {
        r = tweak(s);
        r_quality = pathLength(r, maze);
        s_quality = pathLength(s, maze);
        if (r_quality < s_quality || ((double) rand() / (RAND_MAX)) < pow(M_E, (s_quality - r_quality) / temperature)) {
            s = r.substr(0, r_quality);
        }

        if (temperature - coolness > 0.1) {
            temperature -= coolness;
        }
//        cout << temperature << "; " << coolness << endl;

        if (pathLength(s, maze) < pathLength(best, maze)) {
            best = s;
        }

        end = chrono::system_clock::now();
        if (coolness == 0.0) {
            coolness = temperature * chrono::duration_cast<chrono::milliseconds>(end - start).count() / (time * 1000);
        }
        if (chrono::duration_cast<chrono::seconds>(end - start).count() >= time) break;

    } while (pathLength(best, maze) > 2 &&
             temperature > 0.0); //2 cause it's the best distance we can be sure there is no better.

    return best;
}


int main() {
    int t, n, m;
    srand(time(NULL));
    vector<vector<char>> maze;
    input(t, n, m, maze);
//      fakeInput(t, n, m, maze);
//    showMaze(maze);
    string best = minimumPath(t, maze);


    cout << best.length() << endl;
    cerr << best << endl;


    return 0;
}