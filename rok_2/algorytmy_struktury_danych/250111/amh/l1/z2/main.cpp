#include <iostream>
#include <vector>
#include <set>
#include <chrono>

using namespace std;

void input(int &t, int &n, vector<vector<int>> &graph) {
    vector<int> graphLine;
    int tmp;
    cin >> t >> n;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cin >> tmp;
            graphLine.push_back(tmp);
        }
        graph.push_back(graphLine);
        graphLine.clear();
    }
}

void showGraph(vector<vector<int>> graph) {
    for (int i = 0; i < graph.size(); i++) {
        for (int j = 0; j < graph[i].size(); j++) {
            cout << graph[i][j] << " ";
        }
        cout << endl;
    }
}

void showPath(vector<int> path) {
    for (int i = 0; i < path.size(); i++) {
        cerr << path[i] << " ";
    }
}

int calculatePathWeight(vector<int> path, vector<vector<int>> graph) {
    int weight = 0;
    for (int i = 0; i < path.size() - 1; i++) {
        int current_city = path[i];
        int next_city = path[i + 1];

        weight += graph[current_city - 1][next_city - 1];
    }

    return weight;
}

vector<int> someInitialCandidate(int n) {
    vector<int> candidate;
    for (int i = 1; i < n; i++) {
        candidate.push_back(i);
    }
    candidate.push_back(1);
    return candidate;
}

vector<int>
tweak(vector<int> s) { //tweak generująca mały szum, dający bliskich sąsiadów. Działa znacznie lepiej niż dwie inwersje.
    int i = rand() % (s.size() - 2) + 1;
    int j = rand() % (s.size() - 2) + 1;

    int tmp = s[i];
    s[i] = s[j];
    s[j] = tmp;

    return s;
}

vector<int> tweakAmbitious(vector<int> s) { //skamielina funkcji robiąca do dwóch inwersji
    int i = rand() % (s.size() - 2) + 1;
    int j = rand() % (s.size() - 2) + 1;

    int tmp = s[i];
    s[i] = s[j];
    s[j] = tmp;

    i = rand() % (s.size() - 2) + 1;
    j = rand() % (s.size() - 2) + 1;

    tmp = s[i];
    s[i] = s[j];
    s[j] = tmp;

    return s;
}

/**Tabu Search (from S. Luke, Essentials of Metaheuristics)*/
vector<int> minimumTsp(int t, int n, const vector<vector<int>> &graph) {
    auto start = chrono::system_clock::now();
    auto end = chrono::system_clock::now();
    int set_length = n;     //dobieranie tych stałych przeprowadziłęm na drugim pliku input z treści zadania. Zmniejszenie set_length okzajonalnie dawało lepsze wyniki, ale rozrzucało pozostałe co srednio kończyło się gorszym wynikiem.
    int tweaks_number = n; //przyjąłem taką stałą jako, że wydaje się rozsądna i daje dobre wyniki.
    vector<int> r, w;
    vector<int> s = someInitialCandidate(n);
    vector<int> best = s;
    set<vector<int>> tabu_set;
    tabu_set.insert(s);
    while (1) {
        if (tabu_set.size() > set_length) {
            tabu_set.erase(tabu_set.begin());
        }

        r = tweak(s);
        for (int i = 0; i < tweaks_number; i++) {
            w = tweak(s);
            if (tabu_set.count(w) == 0 &&
                (calculatePathWeight(w, graph) < calculatePathWeight(r, graph) || tabu_set.count(r) != 0)) {
                r = w;
            }
        }
        if (tabu_set.count(r) == 0) {
            s = r;
            tabu_set.insert(r);
        }
        if (calculatePathWeight(s, graph) < calculatePathWeight(best, graph)) {
            best = s;
        }
        auto end = chrono::system_clock::now();
        if (chrono::duration_cast<chrono::seconds>(end - start).count() >= t) break;
    }
    return best;
}

int main() {
    int t, n;
    srand(time(NULL));
    vector<vector<int>> graph;
    input(t, n, graph);

    vector<int> best = minimumTsp(t, n + 1, graph);
    cout << calculatePathWeight(best, graph);
    showPath(best);

    return 0;
}
