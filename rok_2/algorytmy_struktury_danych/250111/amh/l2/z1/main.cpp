#include <iostream>
#include <cstdio>
#include <iostream>
#include <cmath>
#include <random>
#include <chrono>

#define WISHFUL_RANGE_S 100
using namespace std;

class myVector {
public:
    double x1 = 0, x2 = 0, x3 = 0, x4 = 0;

    myVector() = default;

    myVector(double i, double j, double k, double l) {
        x1 = i;
        x2 = j;
        x3 = k;
        x4 = l;
    }

    double getSize() {
        return sqrt(pow(x1, 2.0) + pow(x2, 2.0) + pow(x3, 2.0) + pow(x4, 2.0));
    }

    void show() {
        cout << x1 << " " << x2 << " " << x3 << " " << x4 << " ";
    }

};

double salomon(myVector x) {
    return 1 - cos(2 * M_PI * x.getSize()) + 0.1 * x.getSize();
}

/**Bounded Uniform Convolution (with p = 1)*/
myVector tweak(myVector x, double range) {
    double min = -range;
    double max = range;
    double i = x.x1 + (max - min) * ((double) rand() / (double) RAND_MAX) + min;
    double j = x.x2 + (max - min) * ((double) rand() / (double) RAND_MAX) + min;
    double k = x.x3 + (max - min) * ((double) rand() / (double) RAND_MAX) + min;
    double l = x.x4 + (max - min) * ((double) rand() / (double) RAND_MAX) + min;

    myVector y(i, j, k, l);

    return y;
}


myVector minimumS(int total_time, myVector s) {
    double temperature = 100;
    double const_temperature = 100;
    myVector best = s;
    myVector r;
    auto start = chrono::steady_clock::now();
    auto end = chrono::steady_clock::now();
    double r_quality, s_quality;
    double iteration = 0;
    do {
        iteration++;
        r = tweak(s, 1);
        r_quality = salomon(r);
        s_quality = salomon(s);
        if (r_quality < s_quality || ((double) rand() / (RAND_MAX)) < pow(M_E, (s_quality - r_quality) / temperature)) {
            s = r;
        }
//        if (const_temperature / (1 + iteration / (total_time * 5)) > 0) {
//            temperature = const_temperature / (1 + iteration / (total_time * 5));
//            cout<<temperature<<endl;
//        }
        if (temperature - 0.01 > 0.0) {
            temperature = temperature - 0.01;
        }
//        if (temperature * 0.99 > 0.1) {
//            temperature = temperature * 0.99;
//        }
        if (salomon(s) < salomon(best)) {
            best = s;
        }
        end = chrono::steady_clock::now();
        if (chrono::duration_cast<chrono::seconds>(end - start).count() >=
            total_time) {
//            cout << temperature << endl;
            break;
        }
    } while (salomon(best) >= 0.000001);
    return best;
}

int main() {
    srand(time(NULL));
    int time, x1, x2, x3, x4;
    cin >> time >> x1 >> x2 >> x3 >> x4;
    myVector vec(x1, x2, x3, x4);
    myVector best = minimumS(time, vec);
    best.show();
    cout << salomon(best);

    return 0;
}
