#include <iostream>
#include <chrono>

using namespace std;

void printArray(int array[], int size) {
    for (int i = 0; i < size; i++) {
        cout << array[i] << " ";
    }
    cout << endl;
}

bool checkIfSorted(const int array[], int size, int order) {
    if (order == 1) {
        for (int i = 0; i < size - 1; i++) {
            if (array[i] > array[i + 1]) return false;
        }
        return true;
    } /* <= */
    else if (order == -1) {
        for (int i = 0; i < size - 1; i++) {
            if (array[i] < array[i + 1]) return false;
        }
        return true;
    } /* >= */
    else cout << "Wrong order!!" << endl;

    return false;
}

void swap(int *a, int *b) {
    int t = *a;
    *a = *b;
    *b = t;
}

void insertionSort(int array[], int size, int order, int &compare_count, int &swap_count) {
    if (order == 1) {
        for (int step = 1; step < size; step++) {
            int key = array[step];
            int j = step - 1;

            /* */ cerr << "Com(" << key << " , " << array[j] << ")" << endl;
            /* */ compare_count++;
            while (key < array[j] && j >= 0) {
                array[j + 1] = array[j];
                /* */ cerr << "Swa(" << key << " , " << array[j] << ")" << endl;
                /* */ swap_count++;
                --j;
                /* */ if (j >= 0) cerr << "Com(" << key << " , " << array[j] << ")" << endl;
                /* */ compare_count++;

            }
            array[j + 1] = key;
        }
    } else {
        for (int step = 1; step < size; step++) {
            int key = array[step];
            int j = step - 1;

            /* */ cerr << "Com(" << key << " , " << array[j] << ")" << endl;
            /* */ compare_count++;
            while (key > array[j] && j >= 0) {
                array[j + 1] = array[j];
                /* */ cerr << "Swa(" << key << " , " << array[j] << ")" << endl;
                /* */ swap_count++;
                --j;
                /* */ if (j >= 0) cerr << "Com(" << key << " , " << array[j] << ")" << endl;
                /* */ compare_count++;

            }
            array[j + 1] = key;
        }
    }
}

void merge(int *arr, int low, int high, int mid, int order, int &compare_count, int &swap_count) {
    int i, j, k, c[10001];
    i = low;
    k = low;
    j = mid + 1;
    if (order == 1) {
        while (i <= mid && j <= high) {
            cerr << "Comp(" << arr[i] << ", " << arr[j] << ")" << endl;
            compare_count++;
            if (arr[i] < arr[j]) {
                c[k] = arr[i];
                k++;
                i++;
            } else {
                c[k] = arr[j];
                k++;
                j++;
            }
        }
    } else {
        while (i <= mid && j <= high) {
            cerr << "Comp(" << arr[i] << ", " << arr[j] << ")" << endl;
            compare_count++;
            if (arr[i] > arr[j]) {
                c[k] = arr[i];
                k++;
                i++;
            } else {
                c[k] = arr[j];
                k++;
                j++;
            }
        }
    }

    while (i <= mid) {
        c[k] = arr[i];
        k++;
        i++;
    }
    while (j <= high) {
        c[k] = arr[j];
        k++;
        j++;
    }
    for (i = low; i < k; i++) {
        cerr << "Swa(" << arr[i] << ", " << c[i] << ")" << endl;
        swap_count++;
        arr[i] = c[i];
    }
}

void mergeSort(int *arr, int low, int high, int order, int &compare_count, int &swap_count) {
    int mid;
    if (low < high) {
        //divide the array at mid and sort independently using merge sort
        mid = (low + high) / 2;
        mergeSort(arr, low, mid, order, compare_count, swap_count);
        mergeSort(arr, mid + 1, high, order, compare_count, swap_count);

        merge(arr, low, high, mid, order, compare_count, swap_count);
    }
}

int partition(int arr[], int low, int high, int order, int &compare_count, int &swap_count) {
    int pivot = arr[high];    // pivot
    int i = (low - 1);

    if (order == 1) {
        for (int j = low; j <= high - 1; j++) {
            cerr << "Comp(" << arr[j] << ", " << pivot << ")" << endl;
            compare_count++;
            if (arr[j] <= pivot) {
                i++;
                cerr << "Swa(" << arr[i] << ", " << arr[j] << ")" << endl;
                swap_count++;
                swap(&arr[i], &arr[j]);
            }
        }
    } else {
        for (int j = low; j <= high - 1; j++) {
            cerr << "Comp(" << arr[j] << ", " << pivot << ")" << endl;
            compare_count++;
            if (arr[j] >= pivot) {
                i++;
                cerr << "Swa(" << arr[i] << ", " << arr[j] << ")" << endl;
                swap_count++;
                swap(&arr[i], &arr[j]);
            }
        }
    }

    cerr << "Swa(" << arr[i + 1] << ", " << arr[high] << ")" << endl;
    swap_count++;
    swap(&arr[i + 1], &arr[high]);
    return (i + 1);
}

void quickSort(int arr[], int low, int high, int order, int &compare_count, int &swap_count) {
    if (low < high) {
        int pivot = partition(arr, low, high, order, compare_count, swap_count);

        //sort the sub arrays independently
        quickSort(arr, low, pivot - 1, order, compare_count, swap_count);
        quickSort(arr, pivot + 1, high, order, compare_count, swap_count);
    }
}

void insertionSortElegantWrapper(int array[], int size, int order) {
    int compare_count = 0, swap_count = 0;
    auto t1 = std::chrono::high_resolution_clock::now();

    insertionSort(array, size, order, compare_count, swap_count);

    auto t2 = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count();
    cerr << "InsertionSort took " << compare_count << " compares, " << swap_count << " swaps, " << duration << " us."
         << endl;
    cout << "Array size: " << size << endl;
    printArray(array, size);
}

void mergeSortElegantWrapper(int *arr, int arr_size, int order) {

    int compare_count = 0, swap_count = 0;
    auto t1 = std::chrono::high_resolution_clock::now();

    mergeSort(arr, 0, arr_size - 1, order, compare_count, swap_count);

    auto t2 = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count();
    cerr << "MergeSort took " << compare_count << " compares, " << swap_count << " swaps, " << duration << " us."
         << endl;

    cout << "Array size: " << arr_size << endl;
    printArray(arr, arr_size);
}

void quickSortElegantWrapper(int *arr, int arr_size, int order) {

    int compare_count = 0, swap_count = 0;
    auto t1 = std::chrono::high_resolution_clock::now();

    quickSort(arr, 0, arr_size - 1, order, compare_count, swap_count);

    auto t2 = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count();
    cerr << "QuickSort took " << compare_count << " compares, " << swap_count << " swaps, " << duration << " us."
         << endl;

    cout << "Array size: " << arr_size << endl;
    printArray(arr, arr_size);
}

int main(int argc, char *argv[]) {
    int tab_size, key;
    int order = 1; /* it's 1 when <= and -1 when >= */
    string type_s, comp_s;

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
    } /* Parsing command line arguments */

    cin >> tab_size; /* first input with size of table */
    int tab[tab_size];

    for (int i = 0; i < tab_size; i++) {
        cin >> key;
        tab[i] = key;
    } /* saving input in a table */

    if (type_s == "insert") {
        insertionSortElegantWrapper(tab, tab_size, order);
    } else if (type_s == "merge") {
        mergeSortElegantWrapper(tab, tab_size, order);
    } else if (type_s == "quick") {
        quickSortElegantWrapper(tab, tab_size, order);
    } else cout << "What are wa talking about?";

    return 0;
}

