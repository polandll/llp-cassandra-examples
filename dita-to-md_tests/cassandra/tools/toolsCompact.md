# nodetool compact {#toolsCompact .reference}

Forces a major compaction on one or more tables.

Forces a major [compaction](/en/glossary/doc/glossary/gloss_compaction.html) on one or more tables.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> compact <*keyspace*> ( <*table*>* ...* )
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Remote JMX agent port number.|
|`-pw`|`--password`|Password.|
|`-pwf`|`--password-file`|Password file path.|
|`-s`|--split-output|Split output of STCS files to 50%-25%-12.5% and so on of the total size.|
|`-u`|`--username`|Remote JMX agent user name.|
|--user-defined|Submit listed files for user-defined compaction. For Cassandra 3.4 and later.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

**Note:** 

-   For tarball installations, execute the command from the install\_location/bin directory.
-   If a username and password for RMI authentication are set explicitly in the cassandra-env.sh file for the host, then you must specify credentials.
-   No `-s` will create one large SSTable for STCS.
-   `-s` will not affect DTCS; it will create one large SSTable.

## Description {#description .section}

This command starts the [compaction process](../dml/dmlHowDataMaintain.md#dml-compaction) on tables using SizeTieredCompactionStrategy \(STCS\), DateTieredCompactionStrategy \(DTCS\), or Leveled compaction \(LCS\):

-   If you do not specify a keyspace or table, a major compaction is run on all keyspaces and tables.
-   If you specify only a keyspace, a major compaction is run on all tables in that keyspace.
-   If you specify one or more tables, a major compaction is run on those tables.

Major compactions may behave differently depending which compaction strategy is used for the affected tables:

-   `SizeTieredCompactionStrategy (STCS)`: The default compaction strategy. This strategy triggers a minor compaction when there are a number of similar sized SSTables on disk as configured by the table subproperty, `min_threshold`. A minor compaction does not involve all the tables in a keyspace. Also see [STCS compaction subproperties](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#compactSubprop__compactionSubpropertiesSTCS).
-   `DateTieredCompactionStrategy (DTCS)`: This strategy is an alternative for time series data. It is deprecated in Cassandra 3.0.8/3.8 and later. DTCS stores data written within a certain period of time in the same SSTable. For example, Cassandra stores the last hour of data in one SSTable *time window*, and the next 4 hours of data in another time window, and so on. Compactions are triggered when the `min_threshold` \(4 by default\) for SSTables in those windows is reached. The most common queries for time series workloads retrieve the last hour/day/month of data. Cassandra can limit SSTables returned to those having the relevant data. Also, Cassandra can store data that has been set to expire using TTL in an SSTable with other data scheduled to expire at approximately the same time. Cassandra can then drop the SSTable without doing any compaction. Also see [DTCS compaction subproperties](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#compactSubprop__compactionSubproperties).
-   TimwWindowCompactionStrategy \(TWCS\) This strategy is another alternative for time series data. TWCS compacts SSTables using a series of *time windows* or *buckets*. TWCS creates a new time window within each successive time period. During the active time window, TWCS compacts all SSTables flushed from memory into larger SSTables using STCS. At the end of the time period, all of these SSTables are compacted into a single SSTable. Then the next time window starts and the process repeats. You can configure the duration of the time window. For more information about TWCS, including an example, see [How is data maintained?](../dml/dmlHowDataMaintain.md).
-   `TimeWindowCompactionStrategy (TWCS)` This strategy is an alternative for time series data. TWCS compacts SSTables using a series of *time windows*. While with a time window, TWCS compacts all SSTables flushed from memory into larger SSTables using STCS. At the end of the time window, all of these SSTables are compacted into a single SSTable. Then the next time window starts and the process repeats. The duration of the time window is the only setting required. See [TWCS compaction subproperties](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#compactSubprop__compactionSubpropertiesTWCS). For more information about TWCS, see [How is data maintained?](../dml/dmlHowDataMaintain.md).
-   `LeveledCompactionStrategy (LCS)`: The leveled compaction strategy creates SSTables of a fixed, relatively small size \(160 MB by default\) that are grouped into levels. Within each level, SSTables are guaranteed to be non-overlapping. Each level \(L0, L1, L2 and so on\) is 10 times as large as the previous. Disk I/O is more uniform and predictable on higher than on lower levels as SSTables are continuously being compacted into progressively larger levels. At each level, row keys are merged into non-overlapping SSTables in the next level. This process can improve performance for reads, because Cassandra can determine which SSTables in each level to check for the existence of row key data. This compaction strategy is modeled after Google's LevelDB implementation. Also see [LCS compaction subproperties](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#compactSubprop__compactionSubpropertiesLCS).

For more details, see [How is data maintained?](../dml/dmlHowDataMaintain.md) and [Configuring compaction](../operations/opsConfigureCompaction.md).

**Note:** A major compaction incurs considerably more disk I/O than minor compactions.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

