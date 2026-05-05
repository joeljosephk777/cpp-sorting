# Program 4 — Sorting Algorithm Analyzer

Implements and benchmarks 6 sorting algorithms on randomly generated integer arrays, measuring execution time to compare real-world performance.

## Algorithms

| Algorithm | Time Complexity | Notes |
|---|---|---|
| BubbleSort | O(n²) | Basic comparison sort |
| InsertionSort | O(n²) | Efficient for small/nearly-sorted arrays |
| ShellSort | O(n^1.5) | Gap-based incremental sort |
| MergeSort | O(n log n) | Recursive divide-and-conquer |
| IterativeMergeSort | O(n log n) | Non-recursive, single extra vector |
| QuickSort | O(n log n) avg | Median-of-3 pivot, InsertionSort cutoff for small subarrays |

## Files

| File | Description |
|---|---|
| `sorter.cpp` | Main driver — benchmarks one algorithm per run |
| `sorts.h` | All 6 sorting algorithm implementations (template) |
| `collect_data.sh` | Shell script — runs all algorithms across multiple sizes, writes `results.csv` |
| `analyze_sorts.R` | R script — generates performance graphs from `results.csv` |
| `results.csv` | Benchmark data |
| `graph*.png` | Performance graphs |

## Compile & Run

```bash
g++ -std=c++17 -O2 -o sorter sorter.cpp
./sorter <Algorithm> <Size> [Print]
```

**Examples:**
```bash
./sorter BubbleSort 1000
./sorter QuickSort 50000
./sorter MergeSort 10000 Print    # also prints sorted array
```

**Run full benchmark:**
```bash
bash collect_data.sh              # generates results.csv
Rscript analyze_sorts.R           # generates PNG graphs
```

## Concepts Covered

- Sorting algorithms and their trade-offs
- Empirical algorithm analysis
- Template functions
- Time measurement (`chrono`)
- Data collection and visualization (R)
