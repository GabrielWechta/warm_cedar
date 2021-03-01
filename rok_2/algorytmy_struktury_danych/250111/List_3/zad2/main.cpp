#include <iostream>
#include <random>
#include <algorithm>
#include <climits>
#include <fstream>

using namespace std;

int global_arr_size;

void swap(int &left, int &right) {
    int tmp = left;
    left = right;
    right = tmp;
}

void printArray(int arr[], int arr_size) {
    for (int i = 0; i < arr_size; i++) {
        cout << arr[i] << " ";
    }
    cout << endl;
}

void printArrayErr(int arr[]) {
    cerr << "Table: ";
    int arr_size = global_arr_size;
    for (int i = 0; i < arr_size; i++) {
        cerr << arr[i] << " ";
    }
    cerr << endl;
}

void generateRandomTab(int *arr, int arr_size) {
    random_device rd;
    mt19937 mt(rd());
    uniform_int_distribution<int> dis;

    for (int i = 0; i < arr_size; i++) {
        arr[i] = dis(mt);
    }
}

void generatePermutationTab(int *arr, int arr_size) {
    for (int i = 0; i < arr_size; i++) {
        arr[i] = i + 1;
    }
    shuffle(arr, arr + arr_size, std::mt19937(std::random_device()()));
}

void copy(int *arr, int *coppiedArr, int size) {
    for (int i = 0; i < size; i++) {
        coppiedArr[i] = arr[i];
    }
}

/**RANDOM SELECT**/
int randomPartition(int *arr, int start, int end, int &c_c, int &s_c) {
    srand(time(NULL));
    int pivotIdx = start + rand() % (end - start + 1);
    int pivot = arr[pivotIdx];
    cerr << "pivot: " << pivot << endl;
    swap(arr[pivotIdx], arr[end]); // move pivot element to the end
    cerr << "swap(" << arr[pivotIdx] << " ; " << arr[end] << ")" << endl;
    s_c++;
    pivotIdx = end;
    int i = start - 1;

    for (int j = start; j <= end - 1; j++) {
        cerr << "comp(" << arr[j] << " ; " << pivot << ")" << endl;
        c_c++;
        if (arr[j] <= pivot) {
            i = i + 1;
            swap(arr[i], arr[j]);
            cerr << "swap(" << arr[i] << " ; " << arr[j] << ")" << endl;
            s_c++;
        }
    }

    swap(arr[i + 1], arr[pivotIdx]);
    cerr << "swap(" << arr[i + 1] << " ; " << arr[pivotIdx] << ")" << endl;
    s_c++;
    printArrayErr(arr);
    return i + 1;
}

int randomSelect(int *arr, int start, int end, int k, int &c_c, int &s_c) {
    if (start == end)
        return arr[start];

    if (k == 0) return -1;

    if (start < end) {

        int mid = randomPartition(arr, start, end, c_c, s_c);
        int i = mid - start + 1;
        if (i == k)
            return arr[mid];
        else if (k < i)
            return randomSelect(arr, start, mid - 1, k, c_c, s_c);
        else
            return randomSelect(arr, mid + 1, end, k - i, c_c, s_c);
    }
}

/**SELECT**/
int findMedian(int arr[], int n) {
    sort(arr, arr + n);
    return arr[n / 2];
}

int partition(int arr[], int start, int end, int x, int &c_c, int &s_c) {
    int i;
    for (i = start; i < end; i++)
        if (arr[i] == x)
            break;
    swap(arr[i], arr[end]);
    cerr << "swap(" << arr[i] << " ; " << arr[end] << ")" << endl;
    s_c++;

    i = start;
    for (int j = start; j <= end - 1; j++) {
        cerr << "comp(" << arr[j] << " ; " << x << ")" << endl;
        c_c++;
        if (arr[j] <= x) {
            swap(arr[i], arr[j]);
            cerr << "swap(" << arr[i] << " ; " << arr[j] << ")" << endl;
            s_c++;
            i++;
        }
    }
    swap(arr[i], arr[end]);
    cerr << "swap(" << arr[i] << " ; " << arr[end] << ")" << endl;
    return i;
}

int select(int arr[], int start, int end, int k, int &c_c, int &s_c) {
    if (k > 0 && k <= end - start + 1) {
        int n = end - start + 1;

        int i, median[(n + 4) / 5];
        for (i = 0; i < n / 5; i++)
            median[i] = findMedian(arr + start + i * 5, 5);
        if (i * 5 < n) //For last group with less than 5 elements
        {
            median[i] = findMedian(arr + start + i * 5, n % 5);
            i++;
        }

        int medOfMed = (i == 1) ? median[i - 1] :
                       select(median, 0, i - 1, i / 2, c_c, s_c);
        cerr << "pivot: " << medOfMed << endl;

        int pos = partition(arr, start, end, medOfMed, c_c, s_c);

        if (pos - start == k - 1)
            return arr[pos];
        if (pos - start > k - 1)
            return select(arr, start, pos - 1, k, c_c, s_c);

        return select(arr, pos + 1, end, k - pos + start - 1, c_c, s_c);
    }

    return INT_MAX;
}

/**WRAPPERS**/
void randomSelectWrapper(int arr[], int start, int end, int k) {
    int c_c = 0, s_c = 0;
    cerr << "RANDOM SELECT STARTS" << endl << endl;
    int kth = randomSelect(arr, start, end, k, c_c, s_c);
    cerr << "Comp Count: " << c_c << endl;
    cerr << "Swap Count: " << s_c << endl;
    cerr << "RANDOM SELECT ENDED" << endl;

//    // it's in case of duplicated values
//    for (int i = 0; i <= end; i++) {
//        if (arr[i] == kth) {
//            cout << "[" << kth << "] ";
//        } else cout << arr[i] << " ";
//    }
//    cout << endl;
}

void selectWrapper(int arr[], int start, int end, int k) {
    int c_c = 0, s_c = 0;
    cerr << "SELECT STARTS" << endl << endl;
    int kth = select(arr, start, end, k, c_c, s_c);
    cerr << "Comp Count: " << c_c << endl;
    cerr << "Swap Count: " << s_c << endl;
    cerr << "SELECT ENDED" << endl;

    for (int i = 0; i <= end; i++) {
        if (i == k - 1) {
            cout << "[" << kth << "] ";
        } else cout << arr[i] << " ";
    }
    cout << endl;
}

/**STATISTICCS**/

void statisticProcedure() {
    ofstream rrs, prs, rs, ps;
    int c_c = 0, s_c = 0;
    rrs.open("randomRandomSelect.txt");
    prs.open("permutationRandomSelect.txt");
    rs.open("randomSelect.txt");
    ps.open("permutationSelect.txt");

    for (int i = 0; i < 100; i++) {
        for (int n = 1000; n <= 10000; n += 1000) {
            int arr[n], arr2[n];
            generateRandomTab(arr, n);
            copy(arr, arr2, n);

            c_c = 0;
            s_c = 0;
            randomSelect(arr, 0, n - 1, n / 3, c_c, s_c);
            rrs << n << ";" << c_c << ";" << s_c << endl;

            c_c = 0;
            s_c = 0;
            select(arr2, 0, n - 1, n / 3, c_c, s_c);
            rs << n << ";" << c_c << ";" << s_c << endl;


            generatePermutationTab(arr, n);
            copy(arr, arr2, n);

            c_c = 0;
            s_c = 0;
            randomSelect(arr, 0, n - 1, n / 3, c_c, s_c);
            prs << n << ";" << c_c << ";" << s_c << endl;

            c_c = 0;
            s_c = 0;
            select(arr2, 0, n - 1, n / 3, c_c, s_c);
            ps << n << ";" << c_c << ";" << s_c << endl;
        }
    }

    rrs.close();
    prs.close();
    rs.close();
    ps.close();
}

int main(int argc, char *argv[]) {
    int n, k;
    string current = argv[1];
    if (current == "-r") {
        cin >> n;
        global_arr_size = n; //for printing table to std::err inside another recursive functions which don't have original arr_size.
        cin >> k;
        int arr[n], arr2[n];
        generateRandomTab(arr, n);
        copy(arr, arr2, n);

        randomSelectWrapper(arr, 0, n - 1, k);
        selectWrapper(arr2, 0, n - 1, k);

    } else if (current == "-p") {
        cin >> n;
        global_arr_size = n; //for printing table to std::err inside another recursive functions which don't have original arr_size.
        cin >> k;
        int arr[n], arr2[n];
        generatePermutationTab(arr, n);
        copy(arr, arr2, n);

        randomSelectWrapper(arr, 0, n - 1, k);
        selectWrapper(arr2, 0, n - 1, k);

    } else if (current == "-s") {
        statisticProcedure();
    } else {
        cout << "You should only use -r or -p flags (or -s but it is for pro users only)." << endl;
    }
}
