// Radix Sort in C++ Programming

#include <iostream>
#include <fstream>
#include <random>
#include <sys/sysinfo.h>
#include <chrono>

using namespace std;

int getMax(int array[], int n) {
    int max = array[0];
    for (int i = 1; i < n; i++) {
        if (array[i] > max)
            max = array[i];
    }

//    cout << "max: " << max << endl;
    return max;
}

void printArray(int array[], int size) {
    for (int i = 0; i < size; i++)
        cout << array[i] << " ";
    cout << endl;
}

void countingSort(int array[], int size, int place, int order) {
    const int base = 10;
    int output[size];
    int count[base];

    for (int i = 0; i < base; i++) {
        count[i] = 0;
    }

    for (int i = 0; i < size; i++) {
        count[(array[i] / place) % 10]++;
    }

    if (order == 1) {
        for (int i = 1; i < base; i++) {
            count[i] += count[i - 1];
        }
    } else {
        for (int i = base - 1; i > 0; i--) {
            count[i - 1] += count[i];
        }
    }

    for (int i = size - 1; i >= 0; i--) {
        output[count[(array[i] / place) % 10] - 1] = array[i];
        count[(array[i] / place) % 10]--;
    }

    for (int i = 0; i < size; i++) {
        array[i] = output[i];
    }
}

void countingSort(int array[], int size, int place, int order, int &o_c, unsigned long &ram_used,
                  bool &ram_usage_saved_flag) {
    const int base = 10;
    int output[size];
    int count[base];

    if (ram_usage_saved_flag == false) {
        ram_usage_saved_flag = true;
//        struct sysinfo si2{};
//        sysinfo (&si2);
        ram_used = size * 4 + sizeof(output) + sizeof(count);

    }

    for (int i = 0; i < base; i++) {
        count[i] = 0;
        o_c += 1;
    }

    for (int i = 0; i < size; i++) {
        count[(array[i] / place) % 10]++;
        o_c += 4;
    }

    if (order == 1) {
        for (int i = 1; i < base; i++) {
            count[i] += count[i - 1];
            o_c += 3;
        }
    } else {
        for (int i = base - 1; i > 0; i--) {
            count[i - 1] += count[i];
            o_c += 3;
        }
    }

    for (int i = size - 1; i >= 0; i--) {
        output[count[(array[i] / place) % 10] - 1] = array[i];
        count[(array[i] / place) % 10]--;
        o_c += 8;
        o_c += 5;
    }

    for (int i = 0; i < size; i++) {
        array[i] = output[i];
        o_c += 3;
    }
}

void radixSort(int array[], int size, int order) {
    int max = getMax(array, size);

    for (int place = 1; max / place > 0; place *= 10)
        countingSort(array, size, place, order);
}

void radixSort(int array[], int size, int order, int &o_c, unsigned long &ram_used, bool &ram_usage_saved_flag) {
    int max = getMax(array, size);

    for (int place = 1; max / place > 0; place *= 10)
        countingSort(array, size, place, order, o_c, ram_used, ram_usage_saved_flag);
}

void
radixSortCleanWrapper(int array[], int size, int order, int &operation_count, unsigned long &ram_used, int &duration) {
    bool ram_usage_saved_flag = false;
    auto t1 = std::chrono::high_resolution_clock::now();

    radixSort(array, size, order, operation_count, ram_used, ram_usage_saved_flag);

    auto t2 = std::chrono::high_resolution_clock::now();
    duration = std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count();
}

bool checkIfSorted(const int array[], int size, int order) {
    if (order == 1) {
        for (int i = 0; i < size - 1; i++) {
            if (array[i] > array[i + 1]) return false;
        }
        return true;
    } /* <= */
    else {
        for (int i = 0; i < size - 1; i++) {
            if (array[i] < array[i + 1]) return false;
        }
        return true;
    } /* >= */
}

/********************STATISTICS********************/
void generate_tab(int *arr, int arr_size, int digits) {
    random_device rd;
    mt19937 mt(rd());
    uniform_int_distribution<int> dis;

    for (int i = 0; i < arr_size; i++) {
        arr[i] = dis(mt) % digits;
    }
} /*incredible good random generator */

void statistic_procedure(const string &type_s, const string &comp_s, const string stat_filename, int k) {
    int order;
    ofstream stat_file;
    stat_file.open(stat_filename);

    if (comp_s == ">=") order = -1;
    else order = 1;


    if (type_s == "radix") {
        for (int i = 0; i < k; i++) {
            int o_c = 0, duration = 0;
            unsigned long ram_used = 0l;
            for (int n = 5, even = 0; n < 100000; even++) {
                if (even % 2 == 1) {
                    n *= 5;
                } else {
                    n *= 2;
                }
                int tab[n];
                generate_tab(tab, n, 100);
//                struct sysinfo si{};
//                sysinfo (&si);
                o_c = 0;
                radixSortCleanWrapper(tab, n, order, o_c, ram_used, duration);
//                cout << n << ";" << o_c << ";" << ram_used << ";" << duration << endl;
                stat_file << n << ";" << o_c << ";" << ram_used << ";" << duration << endl;
                if (!checkIfSorted(tab, n, order)) cout << "This one is corrupted." << endl;

            }
        }
    } else cout << "Incorrect type parameter." << endl;

    stat_file.close();
}

int main(int argc, char *argv[]) {
    int tab_size, key, k_iterations = 1;
    int order = 1; /* it's 1 when <= and -1 when >= */
    string type_s, comp_s, stat_filename;
    bool stat_flag = false;

    for (int i = 0; i < argc - 1; i++) {
        string current = argv[i];

        if (current == "--type") {
            i++;
            type_s = argv[i];
        }

        if (current == "--comp") {
            i++;
            comp_s = argv[i];
            if (comp_s == ">=") order = -1;
            else order = 1;
        }

        if (current == "--stat") {
            stat_flag = true; /* is raised when we are doing statistics */
            i++;
            stat_filename = argv[i];
            i++;
            k_iterations = stoi(argv[i]);
        }

        if (current == "--test") {
            int tab[] = {1, 20, 19, 18, 17, 16, 165, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 1};
            int i, j, k;
//            hybridMergeInsertionSortCleanWrapper(tab, 22, DEFAULT_ORDER, i, j, k);
            printArray(tab, 22);

        }
    } /* Parsing command line arguments */

    if (stat_flag) {
        statistic_procedure(type_s, comp_s, stat_filename, k_iterations);

    } else {
        cin >> tab_size; /* first input with size of table */
        int tab[tab_size];

        for (int i = 0; i < tab_size; i++) {
            cin >> key;
            tab[i] = key;
        } /* saving input in a table */

        if (type_s == "radix") {
            radixSort(tab, tab_size, order);
            printArray(tab, tab_size);
        } else cout << "To be honest I accept only \"radix\" flag. " << endl;
    }

    return 0;
}
