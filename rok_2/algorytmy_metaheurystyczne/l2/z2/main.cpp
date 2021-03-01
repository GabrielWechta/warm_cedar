#include <iostream>
#include <vector>
#include <cmath>
#include <chrono>

using namespace std;

void test(vector<vector<int>> &test) /** used for test */{
    vector<int> row;
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            row.push_back(10 * (i * (j + 1)));
        }
        test.push_back(row);
        row.clear();
    }
}

void input(vector<vector<int>> &matrix, int n, int m) {
    vector<int> row;
    int tmp;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            cin >> tmp;
            row.push_back(tmp);
        }
        matrix.push_back(row);
        row.clear();
    }
}

void showMatrix(vector<vector<int>> matrix) {
    for (int i = 0; i < matrix.size(); i++) {
        for (int j = 0; j < matrix[i].size(); j++) {
            cout << matrix[i][j] << "\t";
        }
        cout << endl;
    }
}

void showMatrixInError(vector<vector<int>> matrix) {
    for (int i = 0; i < matrix.size(); i++) {
        for (int j = 0; j < matrix[i].size(); j++) {
            cerr << matrix[i][j] << " ";
        }
        cerr << endl;
    }
}

double distance(vector<vector<int>> &matrix, vector<vector<int>> &primed) {
    long long int sum = 0;
    int n = matrix.size(), m = matrix[0].size();
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            sum += pow(matrix[i][j] - primed[i][j], 2);
        }
    }
    return (double) ((double) 1 / (n * m)) * (double) sum;
}

int closestValue(double avg) {
    int min = INT32_MAX;
    int mem;
    int tab[] = {0, 32, 64, 128, 160, 192, 223, 255};
    for (int i = 0; i < 8; i++) {
        if (pow(avg - tab[i], 2) < min) {
            min = pow(avg - tab[i], 2);
            mem = tab[i];
        }
    }
    return mem;
}

double avg_summation(vector<vector<int>> matrix, int offsetx, int offsety, int m, int n) {
    int sum = 0;
    int pieces = 0;
    for (int x = offsetx; x < offsetx + m && x < matrix.size(); x++) {
        for (int y = offsety; y < offsety + n && y < matrix[0].size(); y++) {
            pieces++;
            sum += matrix[x][y];
        }
    }
    return (double) sum / pieces;
}

int population(vector<vector<int>> &answer, int offsetx, int offsety, int m, int n, int closest) {
    for (int x = offsetx; x < offsetx + m && x < answer.size(); x++) {
        for (int y = offsety; y < offsety + n && y < answer[0].size(); y++) {
            answer[x][y] = closest;
        }
    }
}

vector<vector<int>> initialCandidate(vector<vector<int>> &matrix, int k) {
    int closest;
    double avg;

    vector<vector<int>> answer = matrix;
    for (int x = 0; x < matrix.size(); x += k) {
        for (int y = 0; y < matrix[0].size(); y += k) {
            avg = avg_summation(matrix, x, y, k, k);
            closest = closestValue(avg);
            population(answer, x, y, k, k, closest);
//            showMatrix(answer);
//            cout << endl;
        }
    }

    return answer;
}

vector<vector<int>> tweak(vector<vector<int>> &matrix, int k_x, int k_y) {
    int closest;
    double avg;
//    cout << "k_x: " << k_x;
//    cout << " k_y: " << k_y << endl;
    vector<vector<int>> answer = matrix;
    for (int x = 0; x < matrix.size(); x += k_x) {
        for (int y = 0; y < matrix[0].size(); y += k_y) {
            avg = avg_summation(matrix, x, y, k_x, k_y);
            closest = closestValue(avg);
            population(answer, x, y, k_x, k_y, closest);
        }
    }
//    showMatrix(answer);
    return answer;
}

vector<vector<int>> minimum(int time, vector<vector<int>> matrix, int min_k) {
    double temperature = 100;
    vector<vector<int>> s = initialCandidate(matrix, min_k);
    vector<vector<int>> best = s;
    vector<vector<int>> r;
    auto start = chrono::steady_clock::now();
    auto end = chrono::steady_clock::now();
    double r_quality, s_quality;
    int k_x = min_k, k_y = min_k;
    do {
        do {
            k_x = k_x + (rand() % 3 - 1);
            if (k_x > matrix.size()) {
                k_x = min_k;
            }
        } while (k_x < min_k);
        do {
            k_y = k_y + (rand() % 3 - 1);
            if (k_y > matrix[0].size()) {
                k_y = min_k;
            }
        } while (k_y < min_k);

        r = tweak(matrix, k_x, k_y);
        r_quality = distance(matrix, r);
        s_quality = distance(matrix, s);
        if (r_quality < s_quality || ((double) rand() / (RAND_MAX)) < pow(M_E, (s_quality - r_quality) / temperature)) {
            s = r;
//            cout << "changed" << endl;
        }
        if (temperature * 0.95 > 0.1) {
            temperature = temperature * 0.95;
//            cout << temperature << endl;
        }
        end = chrono::steady_clock::now();
        if (chrono::duration_cast<chrono::seconds>(end - start).count() >=
            time) {
//            cout << temperature << endl;
            break;
        }

    } while (distance(matrix, best) >= 100);
    return best;
}

int main() {
    srand(time(NULL));
    int time, n, m, k;
    cin >> time >> n >> m >> k;
    vector<vector<int>> matrix, test_m;
    input(matrix, n, m);

    vector<vector<int>> best = minimum(time, matrix, k);
    cout << distance(matrix, best) << endl;
    showMatrixInError(best);


    return 0;
}
