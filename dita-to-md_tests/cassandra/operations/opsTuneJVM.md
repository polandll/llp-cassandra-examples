# Tuning Java resources {#opsTuneJVM .concept}

Tuning the Java Virtual Machine \(JVM\) can improve performance or reduce high memory consumption.

Tuning the Java Virtual Machine \(JVM\) can improve performance or reduce high memory consumption.

Topics in this page:

-   [About garbage collection](opsTuneJVM.md#about-gc)
-   [Choosing a Java garbage collector](opsTuneJVM.md#choose-gc)
-   [Setting G1 as the Java garbage collector](opsTuneJVM.md#setting-g1-gc)
-   [Determining the heap size](opsTuneJVM.md#tuning-the-java-heap)
-   [How Cassandra uses memory](opsTuneJVM.md#how-cassandra-uses-memory) - Read first for a better understanding of the settings and recommendations in this topic.
-   [Adjusting JVM parameters for other Cassandra services](opsTuneJVM.md#adjusting_params_for_other_Cassandra_services)
-   [Other JMX options](opsTuneJVM.md#jmx-options)

## About garbage collection {#about-gc .section}

Garbage collection is the process by which Java removes data that is no longer needed from memory. To achieve the best performance, it is important to select the right garbage collector and heap size settings.

One situation that you definitely want to minimize is a garbage collection pause, also known as a stop-the-world event. A pause occurs when a region of memory is full and the JVM needs to make space to continue. During a pause all operations are suspended. Because a pause affects networking, the node can appear as down to other nodes in the cluster. Additionally, any Select and Insert statements will wait, which increases read and write latencies. Any pause of more than a second, or multiple pauses within a second that add to a large fraction of that second, should be avoided. The basic cause of the problem is the rate of data stored in memory outpaces the rate at which data can be removed. For specific symptoms and causes, see [Garbage collection pauses](/en/dse-trblshoot/doc/troubleshooting/gcPauses.html).

## Choosing a Java garbage collector {#choose-gc .section}

For Cassandra 3.0 and later, using the Concurrent-Mark-Sweep \(CMS\) or G1 garbage collector depends on these factors:

G1 is recommended in the following circumstances and reasons:

-   Heap sizes from 14 GB to 64 GB.

    G1 performs better than CMS for larger heaps because it scans the regions of the heap containing the most garbage objects first, and compacts the heap on-the-go, while CMS stops the application when performing garbage collection.

-   The workload is variable, that is, the cluster is performing the different processes all the time.
-   For future proofing, as CMS will be deprecated in Java 9.
-   G1 is easier to configure.
-   G1 is self tuning.

CMS is recommended in the following circumstances:

-   You have the time and expertise to manually tune and test garbage collection.

    Be aware that allocating more memory to the heap, can result in diminishing performance as the garbage collection facility increases the amount of Cassandra metadata in heap memory.

-   Heap sizes no larger than 14 GB.
-   The workload is fixed, that is, the cluster performs the same processes all the time.
-   The environment requires the lowest latency possible. G1 incurs some latency due to profiling.

**Note:** For help configuring CMS, contact the [DataStax Services team](https://www.datastax.com/products/services).

## Setting G1 as the Java garbage collector {#setting-g1-gc .section}

1.  Open jvm.options.
2.  Comment out the `-Xmn800M` line.
3.  Comment out all lines in the `### CMS Settings` section.
4.  Uncomment the relevant G1 settings in the `### G1 Settings` section:

    ```
    ## Use the Hotspot garbage-first collector.
    -XX:+UseG1GC
    #
    ## Have the JVM do less remembered set work during STW, instead
    ## preferring concurrent GC. Reduces p99.9 latency.
    #-XX:G1RSetUpdatingPauseTimePercent=5
    ```


**Note:** When using G1, you only need to set MAX\_HEAP\_SIZE.

## Determining the heap size {#tuning-the-java-heap .section}

You might be tempted to set the Java heap to consume the majority of the computer's RAM. However, this can interfere with the operation of the OS page cache. Recent operating systems maintain the OS page cache for frequently accessed data and are very good at keeping this data in memory. Properly tuning the OS page cache usually results in better performance than increasing the Cassandra row cache.

Cassandra automatically calculates the maximum heap size \(MAX\_HEAP\_SIZE\) based on this formula:

```
max(min(1/2 ram, 1024MB), min(1/4 ram, 8GB)
```

For production use, you may wish to adjust heap size for your environment using the following guidelines:

-   Heap size is usually between ¼ and ½ of system memory.
-   Do not devote all memory to heap because it is also used for offheap cache and file system cache.
-   Always enable GC logging when adjusting GC.
-   Adjust settings gradually and test each incremental change.
-   Enable parallel processing for GC.
-   Cassandra's GCInspector class logs information about any garbage collection that takes longer than 200 ms. Garbage collections that occur frequently and take a moderate length of time \(seconds\) to complete, indicate excessive garbage collection pressure on the JVM. In addition to adjusting the garbage collection options, other remedies include adding nodes, and lowering cache sizes.
-   For a node using G1, the Cassandra community recommends a MAX\_HEAP\_SIZE as large as possible, up to 64 GB.

**Note:** For more tuning tips, see [Secret HotSpot option improving GC pauses on large heaps](http://blog.ragozin.info/2012/03/secret-hotspot-option-improving-gc.html).

**MAX\_HEAP\_SIZE**

The recommended maximum heap size depends on which GC is used:

|Hardware setup|Recommended MAX\_HEAP\_SIZE|
|--------------|---------------------------|
|Older computers|Typically 8 GB.|
|CMS for newer computers \(8+ cores\) with up to 256 GB RAM|No more 14 GB.|
|G1 for newer computers \(8+ cores\) with up to 256 GB RAM|14 GB to 64 GB.|

The easiest way to determine the optimum heap size for your environment is:

1.  Set the maximum heap size in the jvm.options file to a high arbitrary value on a single node. For example, when using G1:

    ```
    -Xms48G
    -Xmx48G
    ```

    Set the min \(-Xms\) and max \(-Xmx\) heap sizes to the same value to avoid stop-the-world GC pauses during resize, and to lock the heap in memory on startup which prevents any of it from being swapped out.

2.  Enable GC logging.
3.  Check the logs to view the heap used by that node and use that value for setting the heap size in the cluster:

**Note:** This method decreases performance for the test node, but generally does not significantly reduce cluster performance.

If you don't see improved performance, contact the [DataStax Services team](https://www.datastax.com/products/services) for additional help.

**HEAP\_NEWSIZE**

For CMS, you may also need to adjust HEAP\_NEWSIZE. This setting determines the amount of heap memory allocated to newer objects or *young generation*. Cassandra calculates the default value for this property \(in MB\) as the lesser of:

-   100 times the number of cores
-   ¼ of MAX\_HEAP\_SIZE

As a starting point, set HEAP\_NEWSIZE to 100 MB per physical CPU core. For example, for a modern 8-core+ machine:

```
-Xmn800M
```

A larger HEAP\_NEWSIZE leads to longer GC pause times. For a smaller HEAP\_NEWSIZE, GC pauses are shorter but usually more expensive.

## How Cassandra uses memory {#how-cassandra-uses-memory .section}

Cassandra performs the following major operations within JVM heap:

-   To perform reads, Cassandra maintains the following components in heap memory:

    -   Bloom filters
    -   Partition summary
    -   Partition key cache
    -   Compression offsets
    -   SSTable index summary
    This metadata resides in memory and is proportional to total data. Some of the components [grow proportionally to the size of total memory](../dml/dmlAboutReads.md).

-   Cassandra gathers replicas for a read or for anti-entropy repair and compares the replicas in heap memory.
-   Data written to Cassandra is first stored in memtables in heap memory. Memtables are flushed to SSTables on disk.

To improve performance, Cassandra also uses off-heap memory as follows:

-   Page cache. Cassandra uses additional memory as page cache when reading files on disk.
-   The Bloom filter and compression offset maps reside off-heap.
-   Cassandra can store cached rows in native memory, outside the Java heap. This reduces JVM heap requirements, which helps keep the heap size in the sweet spot for JVM garbage collection performance.

## Adjusting JVM parameters for other Cassandra services {#adjusting_params_for_other_Cassandra_services .section}

-   **Solr**: Some Solr users have reported that increasing the stack size improves performance under Tomcat.

    To increase the stack size, uncomment and modify the default setting in the cassandra-env.sh file.

    ```
    # Per-thread stack size.
    JVM_OPTS="$JVM_OPTS -Xss256k"
    ```

    Also, decreasing the memtable space to make room for Solr caches can improve performance. Modify the memtable space by changing the [memtable\_heap\_space\_in\_mb](../configuration/configCassandra_yaml.md#memtable_heap_space_in_mb) and [memtable\_offheap\_space\_in\_mb](../configuration/configCassandra_yaml.md#memtable_offheap_space_in_mb) properties in the cassandra.yaml file.

-   **MapReduce**: Because MapReduce runs outside the JVM, changes to the JVM do not affect Analytics/Hadoop operations directly.


## Other JMX options {#jmx-options .section}

Cassandra exposes other statistics and management operations via Java Management Extensions \(JMX\). [JConsole](opsMonitoring.md#opsMonitoringJconsole) and the [nodetool](../tools/toolsNodetool.md) utility are JMX-compliant management tools.

Configure Cassandra for JMX management by editing these properties in cassandra-env.sh.

-   com.sun.management.jmxremote.port: sets the port on which Cassandra listens from JMX connections.
-   com.sun.management.jmxremote.ssl: enables or disables SSL for JMX.
-   com.sun.management.jmxremote.authenticate: enables or disables remote authentication for JMX.
-   -Djava.rmi.server.hostname: sets the interface hostname or IP that JMX should use to connect. Uncomment and set if you are having trouble connecting.

**Note:** By default, you can interact with Cassandra using JMX on port 7199 without authentication.

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

The location of the cassandra-env.sh file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-env.sh|
|Tarball installations|install\_location/conf/cassandra-env.sh|

The location of the jvm.options file depends on the type of installation:

|Package installations|/etc/cassandra/jvm.options|
|Tarball installations|install\_location/conf/jvm.options|

**Parent topic:** [Operations](../../cassandra/operations/operationsTOC.md)

