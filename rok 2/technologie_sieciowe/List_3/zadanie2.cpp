#include <iostream>
#include <cstring>

using namespace std;

class Feeder {
private:
    int location = 0;
    int signal_value = 0;
    int signal_location = 0;


public:
    static int canal[10];

    explicit Feeder(int location, int id) {
        this->location = location;
        this->signal_value = id;
        this->signal_location = location;
    }

    static void showCanal() {
        cout << "{ ";
        for (int i : Feeder::canal) {
            cout << i << ", ";
        }
        cout << "}" << endl;
    }

    bool propagateRight(Feeder target) {
        if (this->signal_location == target.getLocation()) {
            cout << "Right target reached. ";
            if (Feeder::canal[target.getLocation()] == 3) {
                cout << "Jam detected. ";
            } else cout << "Everything good. ";
            cout << endl;
            return true;
        }
        this->signal_location++;
        if (Feeder::canal[this->signal_location] != 0) {
            Feeder::canal[this->signal_location - 1] = 3;
            Feeder::canal[this->signal_location] = Feeder::canal[this->signal_location - 1];
            return false;
        }
        if (Feeder::canal[this->signal_location - 1] == 0) {
            Feeder::canal[this->signal_location - 1] = this->signal_value;
        }
        Feeder::canal[this->signal_location] = Feeder::canal[this->signal_location - 1];
        Feeder::canal[this->signal_location - 1] = 0;
        return false;
    }

    bool propagateLeft(Feeder target) {
        if (this->signal_location == target.getLocation()) {
            cout << "Left target reached. ";
            if (Feeder::canal[target.getLocation()] == 3) {
                cout << "Jam detected. ";
            } else cout << "Everything good. ";
            cout << endl;
            return true;
        }
        this->signal_location--;
        if (Feeder::canal[this->signal_location] != 0) {
            Feeder::canal[this->signal_location + 1] = 3;
            Feeder::canal[this->signal_location] = Feeder::canal[this->signal_location + 1];
            return false;
        }
        if (Feeder::canal[this->signal_location + 1] == 0) {
            Feeder::canal[this->signal_location + 1] = this->signal_value;
        }
        Feeder::canal[this->signal_location] = Feeder::canal[this->signal_location + 1];
        Feeder::canal[this->signal_location + 1] = 0;
        return false;
    }

    int getLocation() {
        return this->location;
    }

    void signalJam() {
        int l, r;
        int canal_size = sizeof(Feeder::canal) / sizeof(int);
        for (l = this->location, r = this->location;; l--, r++) {
            if (l < 0 && r > canal_size) break;
            if (l < 0) {
                l++;
                Feeder::canal[l] = 0;
            } else {
                Feeder::canal[l] = 4;
                Feeder::canal[l + 1] = 0;
            }

            if (r > canal_size) {
                r--;
                Feeder::canal[r] = 0;
            } else {
                Feeder::canal[r] = 4;
                Feeder::canal[r - 1] = 0;
            }
            Feeder::showCanal();
        }
        cout << "Jam signal was populated. ";
    }
};

int Feeder::canal[] = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

int main() {
    Feeder comp1(1, 1);
    Feeder comp2(8, 2);

//    /* one-way signal scenario */
//    while (!comp2.propagateLeft(comp1)) {
//        Feeder::showCanal();
//    }

    /* simultaneous signal scenario */
    while (!comp1.propagateRight(comp2) && !comp2.propagateLeft(comp1)) {
        Feeder::showCanal();
    }
    comp2.signalJam();

}
