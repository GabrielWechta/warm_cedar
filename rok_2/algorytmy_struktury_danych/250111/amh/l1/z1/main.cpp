#include <cstdio>
#include <iostream>
#include <cmath>
#include <random>
#include <chrono>

#define WISHFUL_RANGE_HC 2
#define WISHFUL_RANGE_G 2

using namespace std;

class myVector {
public:
    double x1{}, x2{}, x3{}, x4{};

    void setCordinates(double, double, double, double);

    void setEqual(myVector);

    double getSize();

    double getSum();

    double getSumOfPower4000();

    double getProductOfCos();

    void show();

};

void myVector::setCordinates(double i, double j, double k, double l) {
    x1 = i;
    x2 = j;
    x3 = k;
    x4 = l;
}

void myVector::setEqual(myVector old) {
    x1 = old.x1;
    x2 = old.x2;
    x3 = old.x3;
    x4 = old.x4;
}

double myVector::getSize() {
    return sqrt(pow(x1, 2.0) + pow(x2, 2.0) + pow(x3, 2.0) + pow(x4, 2.0));
}

double myVector::getSum() {
    return x1 + x2 + x3 + x4;
}

double myVector::getSumOfPower4000() {
    return (x1 * x1 + x2 * x2 + x3 * x3 + x4 * x4) / 4000;
}

double myVector::getProductOfCos() {
    return cos(x1 / 1) * cos(x2 / sqrt(2)) * cos(x3 / sqrt(3)) * cos(x4 / 2);
}

void myVector::show() {
    cout << x1 << " " << x2 << " " << x3 << " " << x4 << endl;
}

myVector randomCandidate(double min, double max) {
    myVector x;
    srand(time(NULL));
    double i = (max - min) * ((double) rand() / (double) RAND_MAX) + min;
    double j = (max - min) * ((double) rand() / (double) RAND_MAX) + min;
    double k = (max - min) * ((double) rand() / (double) RAND_MAX) + min;
    double l = (max - min) * ((double) rand() / (double) RAND_MAX) + min;
    x.setCordinates(i, j, k, l);
    return x;
}

double happyCat(myVector x) {
    return pow(pow(pow(x.getSize(), 2.0) - 4, 2), 0.125) + 0.25 * (0.5 * pow(x.getSize(), 2.0) + x.getSum()) + 0.5;
}

double griewank(myVector x) {
    return 1 + x.getSumOfPower4000() - x.getProductOfCos();
}

/**Bounded Uniform Convolution (with p = 1)*/
myVector tweak(myVector x, double range) {
    double min = -range;
    double max = range;
    double i = x.x1 + (max - min) * ((double) rand() / (double) RAND_MAX) + min;
    double j = x.x2 + (max - min) * ((double) rand() / (double) RAND_MAX) + min;
    double k = x.x3 + (max - min) * ((double) rand() / (double) RAND_MAX) + min;
    double l = x.x4 + (max - min) * ((double) rand() / (double) RAND_MAX) + min;

    x.setCordinates(i, j, k, l);

    return x;
}

/**Hill-Climbing with Random Restarts (with 3 intervals)*/
myVector minimumHc(int total_time) {
    int time_interval = total_time / 3;
    if (time_interval == 0) time_interval = total_time;

    myVector s = randomCandidate(-WISHFUL_RANGE_HC, 0);
    myVector best = s;
    myVector r;
    auto start = chrono::steady_clock::now();
    auto end = chrono::steady_clock::now();
    do {
        auto interval_start = chrono::steady_clock::now();
        do {
            r = tweak(s, 0.1);
            if (happyCat(r) < happyCat(s)) { //:3
                s.setEqual(r);
            }
            end = chrono::steady_clock::now();
            if (chrono::duration_cast<chrono::seconds>(end - interval_start).count() >=
                time_interval)
                break;
            if (chrono::duration_cast<chrono::seconds>(end - start).count() >=
                total_time)
                break;
        } while (happyCat(s) >= 0.01); //:3
        if (happyCat(s) < happyCat(best)) //:3
            best = s;
        s = randomCandidate(-WISHFUL_RANGE_HC, 0);
        end = chrono::steady_clock::now();
        if (chrono::duration_cast<chrono::seconds>(end - start).count() >=
            total_time)
            break;
    } while (happyCat(best) >= 0.01);

    return best;
}

myVector minimumG(int total_time) {
    int time_interval = total_time / 3;
    if (time_interval == 0) time_interval = total_time;

    myVector s = randomCandidate(-WISHFUL_RANGE_G, WISHFUL_RANGE_G);
    myVector best = s;
    myVector r;
    auto start = chrono::steady_clock::now();
    auto end = chrono::steady_clock::now();
    do {
        auto interval_start = chrono::steady_clock::now();
        do {
            r = tweak(s, 0.1);
            if (griewank(r) < griewank(s)) { //:3
                s.setEqual(r);
            }

            end = chrono::steady_clock::now();
            if (chrono::duration_cast<chrono::seconds>(end - interval_start).count() >=
                time_interval)
                break;
            if (chrono::duration_cast<chrono::seconds>(end - start).count() >=
                total_time)
                break;

        } while (griewank(s) >= 0.0000001); //let's say ideal case
        if (griewank(s) < griewank(best))
            best = s;
        s = randomCandidate(-WISHFUL_RANGE_G, WISHFUL_RANGE_G);
        end = chrono::steady_clock::now();
        if (chrono::duration_cast<chrono::seconds>(end - start).count() >=
            total_time)
            break;
    } while (griewank(best) >= 0.0000001);

    return best;
}

int main() {
    int time, b;
    cin >> time >> b;
    myVector best;
    if (b == 0) {
        best = minimumHc(time);
        cout << best.x1 << " " << best.x2 << " " << best.x3 << " " << best.x4 << " " << happyCat(best);
    } else {
        best = minimumG(time);
        cout << best.x1 << " " << best.x2 << " " << best.x3 << " " << best.x4 << " " << griewank(best);
    }
}