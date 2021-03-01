#include <iostream>
#include <cstring>
#include <random>
#include <chrono>
#include <fstream>

using namespace std;

void generateTab(int arr[], int arr_size) {
    for (int i = 0; i < arr_size; i++) {
        arr[i] = i + 1;
    }
}

int binarySearch(int arr[], int start, int end, int searched, int &c_c) {
    int mid = (start + end) / 2;
    int value = arr[mid];
    c_c++;
    if (value == searched) {
        return 1;
    }
    c_c++;
    if (start > end) {
        return 0;
    }
    c_c++;
    if (searched < value) {
        return binarySearch(arr, start, mid - 1, searched, c_c);
    }
    c_c++;
    if (searched > value) {
        return binarySearch(arr, mid + 1, end, searched, c_c);
    }
}

int main(int argc, char *argv[]) {

    if (argc > 1) {
        string str = argv[1];
        if (str == "-s") {
            ofstream file;
            file.open("binarySearch1000.txt");

            int c_c;
            for (int k = 0; k < 1000; k++) {
                for (int n = 1000; n <= 100000; n += 1000) {
                    c_c = 0;
                    int arr[n];
                    generateTab(arr, n);
                    int v = 1 + rand() % n;
                    auto t1 = std::chrono::high_resolution_clock::now();

                    int check = binarySearch(arr, 0, n - 1, v, c_c);

                    auto t2 = std::chrono::high_resolution_clock::now();
                    auto duration = std::chrono::duration_cast<std::chrono::nanoseconds>(t2 - t1).count();
                    if (check == 0) {
                        cout << "WHAT HAPPENED?" << endl;
                    }
                    file << n << ";" << c_c << ";" << duration << endl;
                }
            }

        } else cout << "Wrong flag, use -s." << endl << "It's only flag. It's pretty flag less program." << endl;
    } else {
        int n, v;
        cin >> n;
        int arr[n];
        for (int i = 0; i < n; i++) {
            cin >> arr[i];
        }
        cin >> v;
        int dummy = 0;
        cout << binarySearch(arr, 0, n - 1, v, dummy);
    }
    return 0;
}
