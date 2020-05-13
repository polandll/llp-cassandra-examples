# nodetool setcompactionthreshold {#toolsSetCompactionThreshold .reference}

Sets minimum and maximum compaction thresholds for a table.

Sets minimum and maximum compaction thresholds for a table.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> setcompactionthreshold *--* <keyspace> <table> <minthreshold> <maxthreshold>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|keyspace|Name of a keyspace.|
|table|Name of a table.|
|minthreshold|Sets the minimum number of SSTables to trigger a minor compaction when using SizeTieredCompactionStrategy or DateTieredCompactionStrategy.|
|maxthreshold|Sets the maximum number of SSTables to allow in a minor compaction when using SizeTieredCompactionStrategy or DateTieredCompactionStrategy.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

This parameter controls how many SSTables of a similar size must be present before a minor [compaction](../dml/dmlHowDataMaintain.md#dml-compaction) is scheduled. The [max\_threshold](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#compactSubprop__compactionSubpropertiesSTCS) table property sets an upper bound on the number of SSTables that may be compacted in a single minor compaction, as described in [http://wiki.apache.org/cassandra/MemtableSSTable](http://wiki.apache.org/cassandra/MemtableSSTable).

When using LeveledCompactionStrategy, maxthreshold sets the MAX\_COMPACTING\_L0, which limits the number of L0 SSTables that are compacted concurrently to avoid wasting memory or running out of memory when compacting highly overlapping SSTables.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

