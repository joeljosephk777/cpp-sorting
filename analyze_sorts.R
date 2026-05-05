# Sorting Algorithm Analysis - R Script
# Make sure results.csv is in the same folder as this script

# Install packages if you don't have them (run once)
# install.packages("ggplot2")
# install.packages("reshape2")

library(ggplot2)
library(reshape2)

# Read the data
data <- read.csv("results.csv")

# Convert time to milliseconds for better readability
data$Time_ms <- data$Time_microsecs / 1000

# Print summary to verify data loaded correctly
print("Data loaded successfully!")
print(paste("Total rows:", nrow(data)))
print(head(data))

# ===== GRAPH 1: All Sorts Together =====
# This shows the dramatic difference between O(n^2) and O(n log n)
p1 <- ggplot(data, aes(x=Size, y=Time_ms, color=Sort, group=Sort)) +
  geom_line(linewidth=1.2) +
  geom_point(size=3) +
  labs(title="Sorting Algorithm Performance Comparison",
       subtitle="All algorithms showing O(n²) vs O(n log n) complexity",
       x="Input Size (n)",
       y="Time (milliseconds)",
       color="Algorithm") +
  theme_minimal(base_size=14) +
  theme(legend.position="right",
        plot.title = element_text(face="bold", size=16),
        axis.title = element_text(face="bold"))

ggsave("graph1_all_sorts.png", plot=p1, width=12, height=7, dpi=300)
print("✓ Saved graph1_all_sorts.png")

# ===== GRAPH 2: O(n log n) Sorts Only =====
# This clearly shows which O(n log n) sort is fastest
fast_sorts <- subset(data, Sort %in% c("MergeSort", "IterativeMergeSort", "QuickSort", "ShellSort"))

p2 <- ggplot(fast_sorts, aes(x=Size, y=Time_ms, color=Sort, group=Sort)) +
  geom_line(linewidth=1.2) +
  geom_point(size=3) +
  labs(title="Efficient Sorting Algorithms: O(n log n) Comparison",
       subtitle="IterativeMergeSort vs MergeSort vs QuickSort vs ShellSort",
       x="Input Size (n)",
       y="Time (milliseconds)",
       color="Algorithm") +
  theme_minimal(base_size=14) +
  theme(legend.position="right",
        plot.title = element_text(face="bold", size=16),
        axis.title = element_text(face="bold"))

ggsave("graph2_fast_sorts.png", plot=p2, width=12, height=7, dpi=300)
print("✓ Saved graph2_fast_sorts.png")

# ===== GRAPH 3: O(n²) Sorts Only =====
# This compares BubbleSort vs InsertionSort
slow_sorts <- subset(data, Sort %in% c("BubbleSort", "InsertionSort"))

p3 <- ggplot(slow_sorts, aes(x=Size, y=Time_ms, color=Sort, group=Sort)) +
  geom_line(linewidth=1.2) +
  geom_point(size=3) +
  labs(title="O(n²) Sorting Algorithms Comparison",
       subtitle="BubbleSort vs InsertionSort",
       x="Input Size (n)",
       y="Time (milliseconds)",
       color="Algorithm") +
  theme_minimal(base_size=14) +
  theme(legend.position="right",
        plot.title = element_text(face="bold", size=16),
        axis.title = element_text(face="bold"))

ggsave("graph3_slow_sorts.png", plot=p3, width=12, height=7, dpi=300)
print("✓ Saved graph3_slow_sorts.png")

# ===== GRAPH 4: Fast Sorts at Large Sizes (Zoomed In) =====
# This zooms in on the fast algorithms to see clear differences
fast_sorts_large <- subset(data, Sort %in% c("MergeSort", "IterativeMergeSort", "QuickSort", "ShellSort") & Size >= 5000)

p4 <- ggplot(fast_sorts_large, aes(x=Size, y=Time_ms, color=Sort, group=Sort)) +
  geom_line(linewidth=1.2) +
  geom_point(size=3) +
  labs(title="O(n log n) Algorithms Performance - Large Datasets",
       subtitle="Zoomed comparison at sizes 5,000 - 100,000",
       x="Input Size (n)",
       y="Time (milliseconds)",
       color="Algorithm") +
  theme_minimal(base_size=14) +
  theme(legend.position="right",
        plot.title = element_text(face="bold", size=16),
        axis.title = element_text(face="bold"))

ggsave("graph4_fast_large.png", plot=p4, width=12, height=7, dpi=300)
print("✓ Saved graph4_fast_large.png")

# ===== GRAPH 5: Slow Sorts at Small Sizes (Usable Range) =====
# This shows where O(n²) sorts are actually usable
slow_sorts_small <- subset(data, Sort %in% c("BubbleSort", "InsertionSort") & Size <= 5000)

p5 <- ggplot(slow_sorts_small, aes(x=Size, y=Time_ms, color=Sort, group=Sort)) +
  geom_line(linewidth=1.2) +
  geom_point(size=3) +
  labs(title="O(n²) Algorithms Performance - Small to Medium Datasets",
       subtitle="Practical range where quadratic sorts remain usable (n ≤ 5,000)",
       x="Input Size (n)",
       y="Time (milliseconds)",
       color="Algorithm") +
  theme_minimal(base_size=14) +
  theme(legend.position="right",
        plot.title = element_text(face="bold", size=16),
        axis.title = element_text(face="bold"))

ggsave("graph5_slow_small.png", plot=p5, width=12, height=7, dpi=300)
print("✓ Saved graph5_slow_small.png")

# ===== GRAPH 6: All Algorithms - Medium Sizes =====
# This shows the transition point where O(n²) becomes impractical
data_medium <- subset(data, Size >= 100 & Size <= 10000)

p6 <- ggplot(data_medium, aes(x=Size, y=Time_ms, color=Sort, group=Sort)) +
  geom_line(linewidth=1.2) +
  geom_point(size=3) +
  labs(title="Performance Comparison at Medium Sizes",
       subtitle="Critical range showing where O(n²) algorithms become impractical",
       x="Input Size (n)",
       y="Time (milliseconds)",
       color="Algorithm") +
  theme_minimal(base_size=14) +
  theme(legend.position="right",
        plot.title = element_text(face="bold", size=16),
        axis.title = element_text(face="bold"))

ggsave("graph6_medium_range.png", plot=p6, width=12, height=7, dpi=300)
print("✓ Saved graph6_medium_range.png")

# ===== GRAPH 7: IterativeMergeSort vs MergeSort Direct Comparison =====
# This highlights the exact improvement from using one temp vector
merge_comparison <- subset(data, Sort %in% c("MergeSort", "IterativeMergeSort"))

p7 <- ggplot(merge_comparison, aes(x=Size, y=Time_ms, color=Sort, group=Sort)) +
  geom_line(linewidth=1.2) +
  geom_point(size=4) +
  labs(title="MergeSort Implementation Comparison",
       subtitle="Iterative (single temp array) vs Recursive (multiple temp arrays)",
       x="Input Size (n)",
       y="Time (milliseconds)",
       color="Implementation") +
  theme_minimal(base_size=14) +
  theme(legend.position="right",
        plot.title = element_text(face="bold", size=16),
        axis.title = element_text(face="bold"))

ggsave("graph7_mergesort_comparison.png", plot=p7, width=12, height=7, dpi=300)
print("✓ Saved graph7_mergesort_comparison.png")

# ===== GRAPH 8: Performance Ratio at Different Sizes =====
# Calculate how much faster IterativeMergeSort is than each algorithm
# First, reshape data to have one row per size with all algorithms
data_wide <- dcast(data, Size ~ Sort, value.var = "Time_ms")

# Calculate ratios compared to IterativeMergeSort
ratios <- data.frame(
  Size = data_wide$Size,
  BubbleSort = data_wide$BubbleSort / data_wide$IterativeMergeSort,
  InsertionSort = data_wide$InsertionSort / data_wide$IterativeMergeSort,
  MergeSort = data_wide$MergeSort / data_wide$IterativeMergeSort,
  QuickSort = data_wide$QuickSort / data_wide$IterativeMergeSort,
  ShellSort = data_wide$ShellSort / data_wide$IterativeMergeSort
)

# Reshape back to long format for plotting
ratios_long <- melt(ratios, id.vars = "Size", variable.name = "Algorithm", value.name = "Ratio")

p8 <- ggplot(ratios_long, aes(x=Size, y=Ratio, color=Algorithm, group=Algorithm)) +
  geom_line(linewidth=1.2) +
  geom_point(size=3) +
  scale_y_log10() +
  geom_hline(yintercept=1, linetype="dashed", color="black") +
  labs(title="Performance Relative to IterativeMergeSort",
       subtitle="How many times slower each algorithm is (log scale, baseline = 1.0)",
       x="Input Size (n)",
       y="Ratio (times slower than IterativeMergeSort)",
       color="Algorithm") +
  theme_minimal(base_size=14) +
  theme(legend.position="right",
        plot.title = element_text(face="bold", size=16),
        axis.title = element_text(face="bold"))

ggsave("graph8_performance_ratios.png", plot=p8, width=12, height=7, dpi=300)
print("✓ Saved graph8_performance_ratios.png")

# ===== Performance Summary Table =====
print("\n===== PERFORMANCE SUMMARY =====")
print("Fastest to Slowest at size 10000:")
size_10000 <- subset(data, Size == 10000)
size_10000_sorted <- size_10000[order(size_10000$Time_ms),]
print(size_10000_sorted[,c("Sort", "Time_ms")])

print("\n✓ All graphs generated successfully!")
print("Generated files:")
print("  - graph1_all_sorts.png (All 6 algorithms)")
print("  - graph2_fast_sorts.png (O(n log n) algorithms only)")
print("  - graph3_slow_sorts.png (O(n²) algorithms only)")
print("  - graph4_fast_large.png (Fast algorithms zoomed at large sizes)")
print("  - graph5_slow_small.png (Slow algorithms at usable range)")
print("  - graph6_medium_range.png (Critical transition point)")
print("  - graph7_mergesort_comparison.png (Iterative vs Recursive MergeSort)")
print("  - graph8_performance_ratios.png (Relative performance comparison)")