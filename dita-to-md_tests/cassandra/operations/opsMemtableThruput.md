# Configuring memtable thresholds {#opsMemtableThruput .concept}

Configuring memtable thresholds to improve write performance.

Configuring memtable thresholds can improve write performance. Cassandra flushes memtables to disk, creating SSTables when the [commit log space threshold](../configuration/configCassandra_yaml.md#commitlog_total_space_in_mb) or the [memtable cleanup threshold](../configuration/configCassandra_yaml.md#memtable_cleanup_threshold) has been exceeded. Configure the commit log space threshold per node in the cassandra.yaml. How you tune memtable thresholds depends on your data and write load. Increase memtable thresholds under either of these conditions:

-   The write load includes a high volume of updates on a smaller set of data.
-   A steady stream of continuous writes occurs. This action leads to more efficient compaction.

Allocating memory for memtables reduces the memory available for caching and other internal Cassandra structures, so tune carefully and in small increments.

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

**Parent topic:** [Operations](../../cassandra/operations/operationsTOC.md)

