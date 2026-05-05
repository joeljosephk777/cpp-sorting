#ifndef SORTS_H
#define SORTS_H

#include <vector>
using namespace std;

// BubbleSort - O(n^2)
void BubbleSort(vector<int>& items, int first, int last) {
    for (int i = first; i < last; i++) {
        for (int j = last; j > i; j--) {
            if (items[j] < items[j - 1]) {
                swap(items[j], items[j - 1]);
            }
        }
    }
}

// InsertionSort - O(n^2)
void InsertionSort(vector<int>& items, int first, int last) {
    for (int i = first + 1; i <= last; i++) {
        int key = items[i];
        int j = i - 1;
        
        while (j >= first && items[j] > key) {
            items[j + 1] = items[j];
            j--;
        }
        items[j + 1] = key;
    }
}

// MergeSort - O(n log n)
// Merge is a helper function for MergeSort
void Merge(vector<int>& items, int first, int mid, int last) {
    vector<int> temp(last - first + 1);
    int i = first;
    int j = mid + 1;
    int k = 0;
    
    while (i <= mid && j <= last) {
        if (items[i] <= items[j]) {
            temp[k++] = items[i++];
        } else {
            temp[k++] = items[j++];
        }
    }
    
    while (i <= mid) {
        temp[k++] = items[i++];
    }
    
    while (j <= last) {
        temp[k++] = items[j++];
    }
    
    for (k = 0; k < (int)temp.size(); k++) {
        items[first + k] = temp[k];
    }
}

void MergeSort(vector<int>& items, int first, int last) {
    if (first < last) {
        int mid = first + (last - first) / 2;
        MergeSort(items, first, mid);
        MergeSort(items, mid + 1, last);
        Merge(items, first, mid, last);
    }
}

// IterativeMergeSort - O(n log n)
// Non-recursive version with ONE extra vector, alternates back and forth
void IterativeMergeSort(vector<int>& items, int first, int last) {
    int n = last - first + 1;
    vector<int> temp(n);
    
    for (int i = 0; i < n; i++) {
        temp[i] = items[first + i];
    }
    
    bool sourceInTemp = true;
    
    for (int width = 1; width < n; width *= 2) {
        for (int i = 0; i < n; i += 2 * width) {
            int left = i;
            int mid = min(i + width, n);
            int right = min(i + 2 * width, n);
            
            int l = left;
            int r = mid;
            int k = left;
            
            if (sourceInTemp) {
                while (l < mid && r < right) {
                    if (temp[l] <= temp[r]) {
                        items[first + k++] = temp[l++];
                    } else {
                        items[first + k++] = temp[r++];
                    }
                }
                while (l < mid) {
                    items[first + k++] = temp[l++];
                }
                while (r < right) {
                    items[first + k++] = temp[r++];
                }
            } else {
                while (l < mid && r < right) {
                    if (items[first + l] <= items[first + r]) {
                        temp[k++] = items[first + l++];
                    } else {
                        temp[k++] = items[first + r++];
                    }
                }
                while (l < mid) {
                    temp[k++] = items[first + l++];
                }
                while (r < right) {
                    temp[k++] = items[first + r++];
                }
            }
        }
        sourceInTemp = !sourceInTemp;
    }
    
    if (sourceInTemp) {
        for (int i = 0; i < n; i++) {
            items[first + i] = temp[i];
        }
    }
}

// QuickSort - O(n log n) average
// Median-of-three pivot selection with cutoff to InsertionSort for small subarrays
void QuickSort(vector<int>& items, int first, int last) {
    if (last - first < 10) {
        InsertionSort(items, first, last);
        return;
    }

    int mid = (first + last) / 2;

    if (items[first] > items[last]) {
        swap(items[first], items[last]);
    }
    if (items[first] > items[mid]) {
        swap(items[first], items[mid]);
    }
    if (items[mid] > items[last]) {
        swap(items[mid], items[last]);
    }

    int pivot = items[mid];
    swap(items[mid], items[last - 1]);

    int left = first + 1;
    int right = last - 2;

    bool done = false;
    while (!done) {
        while (items[left] < pivot) {
            left++;
        }
        while (items[right] > pivot) {
            right--;
        }

        if (left < right) {
            swap(items[left], items[right]);
            left++;
            right--;
        } else {
            done = true;
        }
    }

    swap(items[last - 1], items[left]);

    QuickSort(items, first, left - 1);
    QuickSort(items, left + 1, last);
}

// ShellSort - O(n^1.5)
void ShellSort(vector<int>& items, int first, int last) {
    int n = last - first + 1;
    
    for (int gap = n / 2; gap > 0; gap /= 2) {
        for (int i = first + gap; i <= last; i++) {
            int temp = items[i];
            int j = i;
            
            while (j >= first + gap && items[j - gap] > temp) {
                items[j] = items[j - gap];
                j -= gap;
            }
            items[j] = temp;
        }
    }
}

#endif