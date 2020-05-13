# Tuning Bloom filters {#opsTuningBloomFilters .concept}

Cassandra uses Bloom filters to determine whether an SSTable has data for a particular row.

Cassandra uses Bloom filters to determine whether an SSTable has data for a particular partition. Bloom filters are unused for range scans, but are used for index scans. Bloom filters are probabilistic sets that allow you to trade memory for accuracy. This means that higher Bloom filter attribute settings [bloom\_filter\_fp\_chance](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#tabProp__moreBloomFilter) use less memory, but will result in more disk I/O if the SSTables are highly fragmented. Bloom filter settings range from 0 to 1.0 \(disabled\). The default value of bloom\_filter\_fp\_chance depends on the [compaction strategy](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#tabProp__moreCompaction). The LeveledCompactionStrategy uses a higher default value \(0.1\) than the SizeTieredCompactionStrategy or DateTieredCompactionStrategy, which have a default of 0.01. Memory savings are nonlinear; going from 0.01 to 0.1 saves about one third of the memory. SSTables using LCS contain a relatively smaller ranges of keys than those using STCS, which facilitates efficient exclusion of the SSTables even without a bloom filter; however, adding a small bloom filter helps when there are many levels in LCS.

The settings you choose depend the type of workload. For example, to run an analytics application that heavily scans a particular table, you would want to inhibit the Bloom filter on the table by setting it high.

To view the observed Bloom filters false positive rate and the number of SSTables consulted per read use [tablestats](../tools/toolsTablestats.md) in the nodetool utility.

Bloom filters are stored off-heap so you don't need include it when determining the -Xmx settings \(the maximum memory size that the heap can reach for the JVM\).

To change the [bloom filter property](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#tabProp__moreBloomFilter) on a table, use CQL. For example:

```
ALTER TABLE addamsFamily WITH bloom_filter_fp_chance = 0.1;
```

After updating the value of bloom\_filter\_fp\_chance on a table, Bloom filters need to be regenerated in one of these ways:

-   [Initiate compaction](opsConfigureCompaction.md)
-   [Upgrade SSTables](../tools/toolsUpgradeSstables.md)

You do not have to restart Cassandra after regenerating SSTables.

**Parent topic:** [Operations](../../cassandra/operations/operationsTOC.md)

