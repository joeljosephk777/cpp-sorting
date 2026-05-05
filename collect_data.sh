#!/bin/bash

# Sizes to test
sizes=(10 100 1000 5000 10000 25000 50000 100000)

# Output file
echo "Sort,Size,Time_microsecs" > results.csv

# For each sort algorithm
for sort in BubbleSort InsertionSort MergeSort IterativeMergeSort QuickSort ShellSort
do
    for size in "${sizes[@]}"
    do
        # Run 3 times and take average for better accuracy
        total=0
        for run in {1..3}
        do
            time=$(./sorter $sort $size | grep "Time" | awk '{print $3}')
            total=$((total + time))
        done
        avg=$((total / 3))
        echo "$sort,$size,$avg" >> results.csv
        echo "  $sort size $size: $avg microsecs"
    done
    echo "✓ Completed $sort"
    echo ""
done

echo "Data collection complete! Results saved to results.csv"