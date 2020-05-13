# Interpreting the output of cassandra-stress {#toolsCStressOutput .concept}

About the output from the running tests.

Each line reports data for the interval between the last elapsed time and current elapsed time.

```
Created keyspaces. Sleeping 1s for propagation.
   Sleeping 2s...
   Warming up WRITE with 50000 iterations...
   Running WRITE with 200 threads for 1000000 iteration
   type       total ops,    op/s,    pk/s,   row/s,    mean,     med,     .95,     .99,    .999,     max,   time,   stderr, errors,  gc: #,  max ms,  sum ms,  sdv ms,      mb
   total,         43148,   42991,   42991,   42991,     4.6,     1.5,    10.9,   106.1,   239.3,   255.4,    1.0,  0.00000,      0,      1,      49,      49,       0,     612
   total,         98715,   43857,   43857,   43857,     4.6,     1.7,     8.5,    98.6,   204.6,   264.5,    2.3,  0.00705,      0,      1,      45,      45,       0,     619
   total,        157777,   47283,   47283,   47283,     4.1,     1.4,     8.3,    70.6,   251.7,   286.3,    3.5,  0.02393,      0,      1,      59,      59,       0,     611
   
   Results:
   op rate                   : 46751 [WRITE:46751]
   partition rate            : 46751 [WRITE:46751]
   row rate                  : 46751 [WRITE:46751]
   latency mean              : 4.3 [WRITE:4.3]
   latency median            : 1.3 [WRITE:1.3]
   latency 95th percentile   : 7.2 [WRITE:7.2]
   latency 99th percentile   : 60.5 [WRITE:60.5]
   latency 99.9th percentile : 223.2 [WRITE:223.2]
   latency max               : 503.1 [WRITE:503.1]
   Total partitions          : 1000000 [WRITE:1000000]
   Total errors              : 0 [WRITE:0]
   total gc count            : 18
   total gc mb               : 10742
   total gc time (s)         : 1
   avg gc time(ms)           : 73
   stdev gc time(ms)         : 16
   Total operation time      : 00:00:21
   
   END
  
```

|Data|Description|
|----|-----------|
|total ops|Running total number of operations during the run.|
|op/s|Number of operations per second performed during the run.|
|pk/s|Number of partition operations per second performed during the run.|
|row/s|Number of row operations per second performed during the run.|
|mean|Average latency in milliseconds for each operation during that run.|
|med|Median latency in milliseconds for each operation during that run.|
|.95|95% of the time the latency was less than the number displayed in the column.|
|.99|99% of the time the latency was less than the number displayed in the column.|
|.999|99.9% of the time the latency was less than the number displayed in the column.|
|max|Maximum latency in milliseconds.|
|time|Total operation time.|
|stderr|Standard error of the mean. It is a measure of confidence in the average throughput number; the smaller the number, the more accurate the measure of the cluster's performance.|
|gc: \#|Number of garbage collections.|
|max ms|Longest garbage collection in milliseconds.|
|sum ms|Total of garbage collection in milliseconds.|
|sdv ms|Standard deviation in milliseconds.|
|mb|Size of the garbage collection in megabytes.|

**Parent topic:** [The cassandra-stress tool](../../cassandra/tools/toolsCStress.md)

