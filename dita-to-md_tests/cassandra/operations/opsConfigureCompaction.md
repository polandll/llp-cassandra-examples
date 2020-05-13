# Configuring compaction {#opsConfigureCompaction .task}

Steps for configuring compaction. The compaction process merges keys, combines columns, evicts tombstones, consolidates SSTables, and creates a new index in the merged SSTable.

As discussed in the [Compaction](../dml/dmlHowDataMaintain.md#dml-compaction) topic, the compaction process merges keys, combines columns, evicts tombstones, consolidates SSTables, and creates a new index in the merged SSTable.

In the cassandra.yamlfile, you configure these global compaction parameters:

-   [snapshot\_before\_compaction](../configuration/configCassandra_yaml.md#snapshot_before_compaction)
-   [concurrent\_compactors](../configuration/configCassandra_yaml.md#concurrent_compactors)
-   [compaction\_throughput\_mb\_per\_sec](../configuration/configCassandra_yaml.md#compaction_throughput_mb_per_sec)

The `compaction_throughput_mb_per_sec` parameter is designed for use with large partitions. Cassandra throttles compaction to this rate across the entire system.

Cassandra provides a start-up option for [testing compaction strategies](opsTestCompactCompress.md) without affecting the production workload.

Cassandra supports the following compaction strategies, which you can configure using CQL:

-   `LeveledCompactionStrategy (LCS)`: The leveled compaction strategy creates SSTables of a fixed, relatively small size \(160 MB by default\) that are grouped into levels. Within each level, SSTables are guaranteed to be non-overlapping. Each level \(L0, L1, L2 and so on\) is 10 times as large as the previous. Disk I/O is more uniform and predictable on higher than on lower levels as SSTables are continuously being compacted into progressively larger levels. At each level, row keys are merged into non-overlapping SSTables in the next level. This process can improve performance for reads, because Cassandra can determine which SSTables in each level to check for the existence of row key data. This compaction strategy is modeled after Google's LevelDB implementation. Also see [LCS compaction subproperties](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#compactSubprop__compactionSubpropertiesLCS).
-   `SizeTieredCompactionStrategy (STCS)`: The default compaction strategy. This strategy triggers a minor compaction when there are a number of similar sized SSTables on disk as configured by the table subproperty, `min_threshold`. A minor compaction does not involve all the tables in a keyspace. Also see [STCS compaction subproperties](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#compactSubprop__compactionSubpropertiesSTCS).
-   `TimeWindowCompactionStrategy (TWCS)` This strategy is an alternative for time series data. TWCS compacts SSTables using a series of *time windows*. While with a time window, TWCS compacts all SSTables flushed from memory into larger SSTables using STCS. At the end of the time window, all of these SSTables are compacted into a single SSTable. Then the next time window starts and the process repeats. The duration of the time window is the only setting required. See [TWCS compaction subproperties](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#compactSubprop__compactionSubpropertiesTWCS). For more information about TWCS, see [How is data maintained?](../dml/dmlHowDataMaintain.md). 
-   `DateTieredCompactionStrategy (DTCS)`: This strategy is an alternative for time series data. It is deprecated in Cassandra 3.0.8/3.8 and later. DTCS stores data written within a certain period of time in the same SSTable. For example, Cassandra stores the last hour of data in one SSTable *time window*, and the next 4 hours of data in another time window, and so on. Compactions are triggered when the `min_threshold` \(4 by default\) for SSTables in those windows is reached. The most common queries for time series workloads retrieve the last hour/day/month of data. Cassandra can limit SSTables returned to those having the relevant data. Also, Cassandra can store data that has been set to expire using TTL in an SSTable with other data scheduled to expire at approximately the same time. Cassandra can then drop the SSTable without doing any compaction. Also see [DTCS compaction subproperties](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#compactSubprop__compactionSubproperties).

To configure the compaction strategy property and [CQL compaction subproperties](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#refClstrOrdr__cql-compact-storage), such as the maximum number of SSTables to compact and minimum SSTable size, use [CREATE TABLE](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html) or [ALTER TABLE](/en/cql-oss/3.3/cql/cql_reference/cqlAlterTable.html).

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

1.  Update a table to set the compaction strategy using the ALTER TABLE statement.

    ```
    ALTER TABLE users WITH
      compaction = { 'class' :  'LeveledCompactionStrategy'  }
    ```

2.  Change the [compaction strategy property](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#tabProp__moreCompaction) to SizeTieredCompactionStrategy and specify the minimum number of SSTables to trigger a compaction using the CQL min\_threshold attribute.

    ```
    ALTER TABLE users
      WITH compaction =
      {'class' : 'SizeTieredCompactionStrategy', 'min_threshold' : 6 }
    ```


You can monitor the results of your configuration using compaction metrics, see [Compaction metrics](opsCompactionMetrics.md).

Cassandra 3.0 and later support extended logging for Compaction. This utility must be configured as part of the table configuration. The extended compaction logs are stored in a separate file. For details, see [Enabling extended compaction logging](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#compactSubprop__enabling-extended-compaction-logging).

**Parent topic:** [Operations](../../cassandra/operations/operationsTOC.md)

