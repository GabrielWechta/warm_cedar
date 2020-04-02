#include <iostream>
#include <chrono>
#include <fstream>
#include <random>

using namespace std;

/********************UTILITIES********************/

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
    else {
        for (int i = 0; i < size - 1; i++) {
            if (array[i] < array[i + 1]) return false;
        }
        return true;
    } /* >= */
}

void swap(int *a, int *b) {
    int t = *a;
    *a = *b;
    *b = t;
}

/********************SORTS********************/

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

    if (checkIfSorted(array, size, order)) {
        cerr << "InsertionSort took " << compare_count << " compares, " << swap_count << " swaps, " << duration
             << " us."
             << endl;
        cout << "Array size: " << size << endl;
        printArray(array, size);
    } else cout << "Something went wrong in insertionSort" << endl;

}

void mergeSortElegantWrapper(int *arr, int arr_size, int order) {

    int compare_count = 0, swap_count = 0;
    auto t1 = std::chrono::high_resolution_clock::now();

    mergeSort(arr, 0, arr_size - 1, order, compare_count, swap_count);

    auto t2 = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count();
    if (checkIfSorted(arr, arr_size, order)) {
        cerr << "MergeSort took " << compare_count << " compares, " << swap_count << " swaps, " << duration << " us."
             << endl;

        cout << "Array size: " << arr_size << endl;
        printArray(arr, arr_size);
    } else cout << "Something went wrong in mergeSort" << endl;

}

void quickSortElegantWrapper(int *arr, int arr_size, int order) {

    int compare_count = 0, swap_count = 0;
    auto t1 = std::chrono::high_resolution_clock::now();

    quickSort(arr, 0, arr_size - 1, order, compare_count, swap_count);

    auto t2 = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count();
    if (checkIfSorted(arr, arr_size, order)) {
        cerr << "QuickSort took " << compare_count << " compares, " << swap_count << " swaps, " << duration << " us."
             << endl;

        cout << "Array size: " << arr_size << endl;
        printArray(arr, arr_size);
    } else cout << "Something went wrong in quickSort" << endl;
}

/*******************DUALPIVOT***************/

int dualPivotPartition(int *arr, int low, int high, int *lp, int order, int &compare_count, int &swap_count) {
    int p = low, q = high - 1;
    int d = 0;
    int i = p + 1, j = i, k = q - 1;

    if (order == 1) {
        if (arr[p] > arr[q]) {
            swap(&arr[p], &arr[q]);
            cerr << "Swa(" << arr[p] << ", " << arr[q] << ")" << endl;
            swap_count++;
        }

        while (j <= k) {
            if (d > 0) {
                compare_count++;
                cerr << "Comp(" << arr[j] << ", " << arr[p] << ")" << endl;
                if (arr[j] <= arr[p]) {
                    swap(&arr[i], &arr[j]);
                    cerr << "Swa(" << arr[i] << ", " << arr[j] << ")" << endl;
                    swap_count++;
                    i++;
                    j++;
                    d++;
                } //?>
                else {
                    compare_count++;
                    cerr << "Comp(" << arr[j] << ", " << arr[q] << ")" << endl;
                    if (arr[j] <= arr[q]) j++;
                    else {
                        swap(&arr[k], &arr[j]);
                        cerr << "Swa(" << arr[k] << ", " << arr[j] << ")" << endl;
                        swap_count++;
                        k--;
                        d--;
                    }
                }
            } else {
                while (arr[k] > arr[q]) {
                    compare_count++;
                    cerr << "Comp(" << arr[k] << ", " << arr[q] << ")" << endl;
                    k--;
                    d--;
                }
                if (j <= k) {
                    compare_count++;
                    cerr << "Comp(" << arr[k] << ", " << arr[p] << ")" << endl;
                    if (arr[k] <= arr[p]) {
                        swap(&arr[k], &arr[j]);
                        swap(&arr[j], &arr[i]);
                        cerr << "Swa(" << arr[k] << ", " << arr[j] << ")" << endl;
                        cerr << "Swa(" << arr[j] << ", " << arr[i] << ")" << endl;
                        swap_count += 2;
                        i++;
                        d++;
                    } else {
                        swap(&arr[j], &arr[k]);
                        cerr << "Swa(" << arr[j] << ", " << arr[k] << ")" << endl;
                        swap_count++;
                    }
                    j++;
                }
            }
        }
    } else {
        if (arr[p] < arr[q]) {
            swap(&arr[p], &arr[q]);
            cerr << "Swa(" << arr[p] << ", " << arr[q] << ")" << endl;
            swap_count++;
        }

        while (j <= k) {
            if (d > 0) {
                compare_count++;
                cerr << "Comp(" << arr[j] << ", " << arr[p] << ")" << endl;
                if (arr[j] >= arr[p]) {
                    swap(&arr[i], &arr[j]);
                    cerr << "Swa(" << arr[i] << ", " << arr[j] << ")" << endl;
                    swap_count++;
                    i++;
                    j++;
                    d++;
                } //?>
                else {
                    compare_count++;
                    cerr << "Comp(" << arr[j] << ", " << arr[q] << ")" << endl;
                    if (arr[j] >= arr[q]) j++;
                    else {
                        swap(&arr[k], &arr[j]);
                        cerr << "Swa(" << arr[k] << ", " << arr[j] << ")" << endl;
                        swap_count++;
                        k--;
                        d--;
                    }
                }
            } else {
                while (arr[k] < arr[q]) {
                    compare_count++;
                    cerr << "Comp(" << arr[k] << ", " << arr[q] << ")" << endl;
                    k--;
                    d--;
                }
                if (j <= k) {
                    compare_count++;
                    cerr << "Comp(" << arr[k] << ", " << arr[p] << ")" << endl;
                    if (arr[k] >= arr[p]) {
                        swap(&arr[k], &arr[j]);
                        swap(&arr[j], &arr[i]);
                        cerr << "Swa(" << arr[k] << ", " << arr[j] << ")" << endl;
                        cerr << "Swa(" << arr[j] << ", " << arr[i] << ")" << endl;
                        swap_count += 2;
                        i++;
                        d++;
                    } else {
                        swap(&arr[j], &arr[k]);
                        cerr << "Swa(" << arr[j] << ", " << arr[k] << ")" << endl;
                        swap_count++;
                    }
                    j++;
                }
            }
        }
    }

    swap(&arr[p], &arr[i - 1]);
    cerr << "Swa(" << arr[p] << ", " << arr[i - 1] << ")" << endl;
    swap_count++;

    if (k + 1 != p) {
        swap(&arr[q], &arr[k + 1]);
        cerr << "Swa(" << arr[q] << ", " << arr[k + 1] << ")" << endl;
        swap_count++;
    }
    *lp = i - 1;
    return k + 1;

}

void dualPivotQuickSort(int *arr, int low, int high, int order, int &compare_count, int &swap_count) {
    if (low < high) {
        int lp, rp;
        rp = dualPivotPartition(arr, low, high, &lp, order, compare_count, swap_count);
        dualPivotQuickSort(arr, low, lp, order, compare_count, swap_count);
        dualPivotQuickSort(arr, lp + 1, rp, order, compare_count, swap_count);
        dualPivotQuickSort(arr, rp + 1, high, order, compare_count, swap_count);
    }
}

int dualPivotPartitionClean(int *arr, int low, int high, int *lp, int order, int &compare_count, int &swap_count) {
    int p = low, q = high - 1;
    int d = 0;
    int i = p + 1, j = i, k = q - 1;

    if (order == 1) {
        if (arr[p] > arr[q]) {
            swap(&arr[p], &arr[q]);
            swap_count++;
        }

        while (j <= k) {
            if (d > 0) {
                compare_count++;
                if (arr[j] <= arr[p]) {
                    swap(&arr[i], &arr[j]);
                    swap_count++;
                    i++;
                    j++;
                    d++;
                } //?>
                else {
                    compare_count++;
                    if (arr[j] <= arr[q]) j++;
                    else {
                        swap(&arr[k], &arr[j]);
                        swap_count++;
                        k--;
                        d--;
                    }
                }
            } else {
                while (arr[k] > arr[q]) {
                    compare_count++;
                    k--;
                    d--;
                }
                if (j <= k) {
                    compare_count++;
                    if (arr[k] <= arr[p]) {
                        swap(&arr[k], &arr[j]);
                        swap(&arr[j], &arr[i]);
                        swap_count += 2;
                        i++;
                        d++;
                    } else {
                        swap(&arr[j], &arr[k]);
                        swap_count++;
                    }
                    j++;
                }
            }
        }
    } else {
        if (arr[p] < arr[q]) {
            swap(&arr[p], &arr[q]);
            swap_count++;
        }

        while (j <= k) {
            if (d > 0) {
                compare_count++;
                if (arr[j] >= arr[p]) {
                    swap(&arr[i], &arr[j]);
                    swap_count++;
                    i++;
                    j++;
                    d++;
                } //?>
                else {
                    compare_count++;
                    if (arr[j] >= arr[q]) j++;
                    else {
                        swap(&arr[k], &arr[j]);
                        swap_count++;
                        k--;
                        d--;
                    }
                }
            } else {
                while (arr[k] < arr[q]) {
                    compare_count++;
                    k--;
                    d--;
                }
                if (j <= k) {
                    compare_count++;
                    if (arr[k] >= arr[p]) {
                        swap(&arr[k], &arr[j]);
                        swap(&arr[j], &arr[i]);
                        swap_count += 2;
                        i++;
                        d++;
                    } else {
                        swap(&arr[j], &arr[k]);
                        swap_count++;
                    }
                    j++;
                }
            }
        }
    }

    swap(&arr[p], &arr[i - 1]);
    swap_count++;

    if (k + 1 != p) {
        swap(&arr[q], &arr[k + 1]);
        swap_count++;
    }
    *lp = i - 1;
    return k + 1;

}

void dualPivotQuickSortClean(int *arr, int low, int high, int order, int &compare_count, int &swap_count) {
    if (low < high) {
        int lp, rp;
        rp = dualPivotPartitionClean(arr, low, high, &lp, order, compare_count, swap_count);
        dualPivotQuickSortClean(arr, low, lp, order, compare_count, swap_count);
        dualPivotQuickSortClean(arr, lp + 1, rp, order, compare_count, swap_count);
        dualPivotQuickSortClean(arr, rp + 1, high, order, compare_count, swap_count);
    }
}

void dualPivotQuickSortElegantWrapper(int *arr, int arr_size, int order) {

    int compare_count = 0, swap_count = 0;
    auto t1 = std::chrono::high_resolution_clock::now();

    dualPivotQuickSort(arr, 0, arr_size, order, compare_count, swap_count);

    auto t2 = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count();
    if (checkIfSorted(arr, arr_size, order)) {
        cerr << "DualPivotSort took " << compare_count << " compares, " << swap_count << " swaps, " << duration
             << " us."
             << endl;

        cout << "Array size: " << arr_size << endl;
        printArray(arr, arr_size);
    } else cout << "Something went wrong in dualPivotSort" << endl;

}

/********************CLEAN********************/

void insertionSortClean(int array[], int size, int order, int &compare_count, int &swap_count) {
    if (order == 1) {
        for (int step = 1; step < size; step++) {
            int key = array[step];
            int j = step - 1;
            /* */ compare_count++;
            while (key < array[j] && j >= 0) {
                array[j + 1] = array[j];
                /* */ swap_count++;
                --j;
                /* */ compare_count++;

            }
            array[j + 1] = key;
        }
    } else {
        for (int step = 1; step < size; step++) {
            int key = array[step];
            int j = step - 1;
            /* */ compare_count++;
            while (key > array[j] && j >= 0) {
                array[j + 1] = array[j];
                /* */ swap_count++;
                --j;
                /* */ compare_count++;

            }
            array[j + 1] = key;
        }
    }
}

void mergeClean(int *arr, int low, int high, int mid, int order, int &compare_count, int &swap_count) {
    int i, j, k, c[10001];
    i = low;
    k = low;
    j = mid + 1;
    if (order == 1) {
        while (i <= mid && j <= high) {
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
        swap_count++;
        arr[i] = c[i];
    }
}

void mergeSortClean(int *arr, int low, int high, int order, int &compare_count, int &swap_count) {
    int mid;
    if (low < high) {
        //divide the array at mid and sort independently using merge sort
        mid = (low + high) / 2;
        mergeSortClean(arr, low, mid, order, compare_count, swap_count);
        mergeSortClean(arr, mid + 1, high, order, compare_count, swap_count);

        mergeClean(arr, low, high, mid, order, compare_count, swap_count);
    }
}

int partitionClean(int arr[], int low, int high, int order, int &compare_count, int &swap_count) {
    int pivot = arr[high];    // pivot
    int i = (low - 1);

    if (order == 1) {
        for (int j = low; j <= high - 1; j++) {
            compare_count++;
            if (arr[j] <= pivot) {
                i++;
                swap_count++;
                swap(&arr[i], &arr[j]);
            }
        }
    } else {
        for (int j = low; j <= high - 1; j++) {
            compare_count++;
            if (arr[j] >= pivot) {
                i++;
                swap_count++;
                swap(&arr[i], &arr[j]);
            }
        }
    }

    swap_count++;
    swap(&arr[i + 1], &arr[high]);
    return (i + 1);
}

void quickSortClean(int arr[], int low, int high, int order, int &compare_count, int &swap_count) {
    if (low < high) {
        int pivot = partitionClean(arr, low, high, order, compare_count, swap_count);

        //sort the sub arrays independently
        quickSortClean(arr, low, pivot - 1, order, compare_count, swap_count);
        quickSortClean(arr, pivot + 1, high, order, compare_count, swap_count);
    }
}

void insertionSortCleanWrapper(int array[], int size, int order, int &compare_count, int &swap_count, int &duration) {
    auto t1 = std::chrono::high_resolution_clock::now();

    insertionSortClean(array, size, order, compare_count, swap_count);

    auto t2 = std::chrono::high_resolution_clock::now();
    duration = std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count();
}

void mergeSortCleanWrapper(int *arr, int arr_size, int order, int &compare_count, int &swap_count, int &duration) {
    auto t1 = std::chrono::high_resolution_clock::now();

    mergeSortClean(arr, 0, arr_size - 1, order, compare_count, swap_count);

    auto t2 = std::chrono::high_resolution_clock::now();
    duration = std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count();
}

void quickSortCleanWrapper(int *arr, int arr_size, int order, int &compare_count, int &swap_count, int &duration) {
    auto t1 = std::chrono::high_resolution_clock::now();

    quickSortClean(arr, 0, arr_size - 1, order, compare_count, swap_count);

    auto t2 = std::chrono::high_resolution_clock::now();
    duration = std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count();
}

void
dualPivotQuickSortCleanWrapper(int *arr, int arr_size, int order, int &compare_count, int &swap_count, int &duration) {
    auto t1 = std::chrono::high_resolution_clock::now();

    dualPivotQuickSortClean(arr, 0, arr_size, order, compare_count, swap_count);

    auto t2 = std::chrono::high_resolution_clock::now();
    duration = std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count();
}

void generate_tab(int *arr, int arr_size) {
    random_device rd;
    mt19937 mt(rd());
    uniform_int_distribution<int> dis;

    for (int i = 0; i < arr_size; i++) {
        arr[i] = dis(mt);
    }
} /*incredible good random generator */

/********************HYBRID AND ORDER********************/
// W zadaniu 4 jest zadane aby pozmieniać wszystkie funckje, w tym momencie polegałoby to tylko na tym aby pozmieniać argument (int) order na (my_order) opts i pozmieniać ify.

typedef struct {
    bool (*compare)(int, int);
} my_order;

bool is_less_equal(int a, int b) {
    return a <= b;
}

bool is_greater_equal(int a, int b) {
    return a >= b;
}

my_order DEFAULT_ORDER = {is_less_equal};

void insertionSortClean(int arr[], int size, my_order opts, int &compare_count, int &swap_count) {
    for (int step = 1; step < size; step++) {
        int key = arr[step];
        int j = step - 1;

        /* */ compare_count++;
        while (opts.compare(key, arr[j]) && j >= 0) {
            arr[j + 1] = arr[j];
            /* */ swap_count++;
            --j;
            /* */ compare_count++;

        }
        arr[j + 1] = key;
    }

}

void mergeClean(int *arr, int low, int high, int mid, my_order opts, int &compare_count, int &swap_count) {
    int i = 0, j = 0, k, c[10001];
    i = low;
    k = low;
    j = mid;
    while (i < mid && j < high) {
        compare_count++;
        if (opts.compare(arr[i], arr[j])) {
            c[k] = arr[i];
            k++;
            i++;
        } else {
            c[k] = arr[j];
            k++;
            j++;

        }
    }

    while (i < mid) {
        c[k] = arr[i];
        k++;
        i++;
    }
    while (j < high) {
        c[k] = arr[j];
        k++;
        j++;
    }
    for (i = low; i < k; i++) {
        swap_count++;
        arr[i] = c[i];
    }
}

void hybridMergeInsertionSortClean(int A[], int left, int right, my_order opts, int &compare_count, int &swap_count) {
    if (left < right) {
        if (right - left <= 10) {
            insertionSortClean(A + left, right - left, opts, compare_count, swap_count);
//            cout << "insertion: ";
//             printArray(A + left, right - left);
            return;
        }
        int half = left + (right - left) / 2;
        hybridMergeInsertionSortClean(A, left, half, opts, compare_count, swap_count);
        hybridMergeInsertionSortClean(A, half, right, opts, compare_count, swap_count);
        mergeClean(A, left, right, half, opts, compare_count, swap_count);
//        cout << "after merge: ";
//        printArray(A + left, right - left);
    }
}

void hybridMergeInsertionSortCleanWrapper(int arr[], int size, my_order opts, int &compare_count,
                                          int &swap_count, int &duration) {
    auto t1 = std::chrono::high_resolution_clock::now();

    hybridMergeInsertionSortClean(arr, 0, size, opts, compare_count, swap_count);

    auto t2 = std::chrono::high_resolution_clock::now();
    duration = std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count();
}

void insertionSort(int arr[], int size, my_order opts, int &compare_count, int &swap_count) {
    for (int step = 1; step < size; step++) {
        int key = arr[step];
        int j = step - 1;

        /* */ compare_count++;
        cerr << "Comp(" << key << ", " << arr[j] << ")" << endl;
        while (opts.compare(key, arr[j]) && j >= 0) {
            arr[j + 1] = arr[j];
            /* */ swap_count++;
            cerr << "Swa(" << arr[j+1] << ", " << arr[j] << ")" << endl;
            --j;
            /* */ compare_count++;
            cerr << "Comp(" << key << ", " << arr[j] << ")" << endl;

        }
        arr[j + 1] = key;
    }

}

void merge(int *arr, int low, int high, int mid, my_order opts, int &compare_count, int &swap_count) {
    int i = 0, j = 0, k, c[10001];
    i = low;
    k = low;
    j = mid;
    while (i < mid && j < high) {
        compare_count++;
        cerr << "Comp(" << arr[i] << ", " << arr[j] << ")" << endl;
        if (opts.compare(arr[i], arr[j])) {
            c[k] = arr[i];
            k++;
            i++;
        } else {
            c[k] = arr[j];
            k++;
            j++;

        }
    }

    while (i < mid) {
        c[k] = arr[i];
        k++;
        i++;
    }
    while (j < high) {
        c[k] = arr[j];
        k++;
        j++;
    }
    for (i = low; i < k; i++) {
        swap_count++;
        cerr << "Swa(" << arr[i] << ", " << c[i] << ")" << endl;
        arr[i] = c[i];
    }
}

void hybridMergeInsertionSort(int A[], int left, int right, my_order opts, int &compare_count, int &swap_count) {
    if (left < right) {
        if (right - left <= 10) {
            insertionSort(A + left, right - left, opts, compare_count, swap_count);
//            cout << "insertion: ";
            // printArray(A + left, right - left);
            return;
        }
        int half = left + (right - left) / 2;
        hybridMergeInsertionSort(A, left, half, opts, compare_count, swap_count);
        hybridMergeInsertionSort(A, half, right, opts, compare_count, swap_count);
        merge(A, left, right, half, opts, compare_count, swap_count);
//        cout << "after merge: ";
        //printArray(A + left, right - left);
    }
}

void hybridMergeInsertionSortElegantWrapper(int arr[], int size, my_order opts) {
    int compare_count = 0, swap_count = 0;
    auto t1 = std::chrono::high_resolution_clock::now();

    hybridMergeInsertionSort(arr, 0, size, opts, compare_count, swap_count);

    auto t2 = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count();
    cerr << "HybridSort took " << compare_count << " compares, " << swap_count << " swaps, " << duration
         << " us."
         << endl;
    cout << "Array size: " << size << endl;
    printArray(arr, size);

}

/********************STATISTICS********************/

void statistic_procedure(const string &type_s, const string &comp_s, const string stat_filename, int k) {
    int order;
    ofstream stat_file;
    stat_file.open(stat_filename);

    if (comp_s == ">=") order = -1;
    else order = 1;


    if (type_s == "insert") {
        for (int i = 0; i < k; i++) {
            int c_c = 0, s_c = 0, duration = 0;
            for (int n = 100; n <= 10000; n += 100) {
                int tab[n];
                generate_tab(tab, n);
                insertionSortCleanWrapper(tab, n, order, c_c, s_c, duration);
//                cout << n << ";" << c_c << ";" << s_c << ";" << duration << endl;
                stat_file << n << ";" << c_c << ";" << s_c << ";" << duration << endl;
                if (!checkIfSorted(tab, n, order)) cout << "This one is corrupted." << endl;
            }
        }
    } else if (type_s == "merge") {
        for (int i = 0; i < k; i++) {
            int c_c = 0, s_c = 0, duration = 0;
            for (int n = 100; n <= 10000; n += 100) {
                int tab[n];
                generate_tab(tab, n);
                mergeSortCleanWrapper(tab, n, order, c_c, s_c, duration);
//                cout << n << ";" << c_c << ";" << s_c << ";" << duration << endl;
                stat_file << n << ";" << c_c << ";" << s_c << ";" << duration << endl;
                if (!checkIfSorted(tab, n, order)) cout << "This one is corrupted." << endl;
            }
        }
    } else if (type_s == "quick") {
        for (int i = 0; i < k; i++) {
            int c_c = 0, s_c = 0, duration = 0;
            for (int n = 100; n <= 10000; n += 100) {
                int tab[n];
                generate_tab(tab, n);
                quickSortCleanWrapper(tab, n, order, c_c, s_c, duration);
//                cout << n << ";" << c_c << ";" << s_c << ";" << duration << endl;
                stat_file << n << ";" << c_c << ";" << s_c << ";" << duration << endl;
                if (!checkIfSorted(tab, n, order)) cout << "This one is corrupted." << endl;
            }
        }
    } else if (type_s == "dual") {
        for (int i = 0; i < k; i++) {
            int c_c = 0, s_c = 0, duration = 0;
            for (int n = 100; n <= 10000; n += 100) {
                int tab[n];
                generate_tab(tab, n);
                dualPivotQuickSortCleanWrapper(tab, n, order, c_c, s_c, duration);
//                cout << n << ";" << c_c << ";" << s_c << ";" << duration << endl;
                stat_file << n << ";" << c_c << ";" << s_c << ";" << duration << endl;
                if (!checkIfSorted(tab, n, order)) cout << "This one is corrupted." << endl;
            }
        }
    } else if (type_s == "hybrid") {
        my_order opts;
        if (order == -1) {
            opts = {is_greater_equal};
        } else {
            opts = {is_less_equal};
        }
        for (int i = 0; i < k; i++) {
            int c_c = 0, s_c = 0, duration = 0;
            for (int n = 100; n <= 10000; n += 100) {
                int tab[n];
                generate_tab(tab, n);

                hybridMergeInsertionSortCleanWrapper(tab, n, opts, c_c, s_c, duration);
//                cout << n << ";" << c_c << ";" << s_c << ";" << duration << endl;
                stat_file << n << ";" << c_c << ";" << s_c << ";" << duration << endl;
//                printArray(tab, n);
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
            hybridMergeInsertionSortCleanWrapper(tab, 22, DEFAULT_ORDER, i, j, k);
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

        if (type_s == "insert") {
            insertionSortElegantWrapper(tab, tab_size, order);
        } else if (type_s == "merge") {
            mergeSortElegantWrapper(tab, tab_size, order);
        } else if (type_s == "quick") {
            quickSortElegantWrapper(tab, tab_size, order);
        } else if (type_s == "dual") {
            dualPivotQuickSortElegantWrapper(tab, tab_size, order);
        } else if (type_s == "hybrid") {
            my_order opts;
            if (order == -1) {
                opts = {is_greater_equal};
            } else {
                opts = {is_less_equal};
            }
            hybridMergeInsertionSortElegantWrapper(tab, tab_size, opts);
        } else cout << "What are wa talking about?";
    }

    return 0;
}
