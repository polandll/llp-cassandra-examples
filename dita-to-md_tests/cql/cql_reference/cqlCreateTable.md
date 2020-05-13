# CREATE TABLE {#cqlCreateTable .reference}

Define a new table.

Define a new table.

## Synopsis {#synopsis .section}

```
CREATE TABLE [IF NOT EXISTS] [keyspace\_name.]table\_name ( 
   column\_definition [, ...]
   PRIMARY KEY (column\_name [, column\_name ...])
[WITH table\_options
   | CLUSTERING ORDER BY (clustering\_column\_name order])
   | ID = 'table\_hash\_tag'
   | COMPACT STORAGE]
```

|Syntax conventions|Description|
|------------------|-----------|
|UPPERCASE|Literal keyword.|
|Lowercase|Not literal.|
|`Italics`|Variable value. Replace with a user-defined value.|
|`[]`|Optional. Square brackets \(`[]`\) surround optional command arguments. Do not type the square brackets.|
|`( )`|Group. Parentheses \( `( )` \) identify a group to choose from. Do not type the parentheses.|
|`|`|Or. A vertical bar \(`|`\) separates alternative elements. Type any one of the elements. Do not type the vertical bar.|
|`...`|Repeatable. An ellipsis \( `...` \) indicates that you can repeat the syntax element as often as required.|
|`'Literal string'`|Single quotation \(`'`\) marks must surround literal strings in CQL statements. Use single quotation marks to preserve upper case.|
|`{ key : value }`|Map collection. Braces \(`{ }`\) enclose map collections or key value pairs. A colon separates the key and the value.|
|`<datatype1,datatype2>`|Set, list, map, or tuple. Angle brackets \( `< >` \) enclose data types in a set, list, map, or tuple. Separate the data types with a comma.|
|`cql\_statement;`|End CQL statement. A semicolon \(`;`\) terminates all CQL statements.|
|`[--]`|Separate the command line options from the command arguments with two hyphens \( `--` \). This syntax is useful when arguments might be mistaken for command line options.|
|`' <schema\> ... </schema\> '`|Search CQL only: Single quotation marks \(`'`\) surround an entire XML schema declaration.|
|`@xml\_entity='xml\_entity\_type'`|Search CQL only: Identify the entity and literal value to overwrite the XML element in the schema and solrConfig files.|

## Description {#description .section}

The `CREATE TABLE` command creates a new [table](/en/glossary/doc/glossary/gloss_table.html) under the current keyspace.

The `IF NOT EXISTS` keywords may be used in creating a table. Attempting to create an existing table returns an error unless the `IF NOT EXISTS` option is used. If the option is used, the statement if a no-op if the table already exists.

A [static column](../cql_using/refStaticCol.md) can store the same data in multiple clustered rows of a partition, and then retrieve that data with a single `SELECT` statement.

You can add a [counter column](../cql_using/useCounters.md) to a counter table.

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

## column\_definition {#refcolumndef}

Name column, define the data type, and set to static or primary key.

Columns are defined enclosed in parenthesis after the table name, use a comma-separated list to define multiple columns. All tables must have at least one primary key column. Each column is defined using the following syntax:

```
column\_name cql\_type\_definition [STATIC | PRIMARY KEY] [, ...]
```

| |Description|
|--|-----------|
|column\_name|Use a unique name for each column in table. To preserve case or use special characters, enclose the name in double-quotes.|
|cql\_type\_definition|Defines the type of data allowed in the column, see [CQL data type](cql_data_types_c.md) or a [user-defined type](cqlRefUDType.md).|
|`STATIC`|Optional, the column has a single value.|
|`PRIMARY KEY`|Optional, use to indicate that the column is the only primary key for the table; to define a key that uses multiple columns see [PRIMARY KEY](cqlCreateTable.md#).|

**Restriction:** 

-   When primary key is at the end of a column definition that column is the only primary key for the table.
-   A table must have at least one `PRIMARY KEY`.
-   A static column cannot be a primary key.
-   Primary keys can include frozen collections.

Create a table that has a frozen user defined type.

```
CREATE TABLE cycling.race_winners (
   race_name text, 
   race_position int, 
   cyclist_name FROZEN<fullname>, 
   PRIMARY KEY (race_name, race_position));
```

See ["Creating a user-defined type"](../cql_using/useCreateUDT.md) for information on creating UDTs. In Cassandra 3.6 and later, UDTs can be created unfrozen if only non-collection fields are used in the user-defined type creation. If the table is created with an unfrozen UDT, then [individual field values can be updated and deleted](../cql_using/useInsertUDT.md).

## PRIMARY KEY {#refPkCol}

Uniquely identifies rows, determines storage partitions, and data ordering \(clustering\) within the partition.

### Single key {#singlekey .section}

When the `PRIMARY KEY` is one column, append PRIMARY KEY to the end of the column definition. This is only schema information required to create a table. When there is one primary key, it is the partition key; the data is divided and stored by the unique values in this column.

```
column\_name cql\_type\_definition PRIMARY KEY
```

Alternatively, you can declare the primary key consisting of only one column in the same way as you declare a compound primary key.

Create the cyclist\_name table with UUID as the primary key:

```screen
CREATE TABLE cycling.cyclist_name ( 
   id UUID PRIMARY KEY, 
   lastname text, 
   firstname text );
```

**Restriction:** 

Primary keys cannot have the data type: counter, non-frozen collection, or static.

### Compound key {#compoundPK .section}

A compound primary key consists of more than one column; the first column is the partition key, and the additional columns are clustering keys. To define compound primary key as follows:

```
PRIMARY KEY (partition\_column\_name, clustering\_column\_name [, ...])
```

Create the cyclist category table and store the data in reverse order:

```screen
CREATE TABLE cycling.cyclist_category (
   category text, 
   points int, 
   id UUID, 
   lastname text, 
   PRIMARY KEY (category, points)) 
WITH CLUSTERING ORDER BY (points DESC);
```

### Composite partition key {#cqlPKcomposite .section}

A composite partition key is a partition key consisting of multiple columns. Enclose the partition key columns in parenthesis.

```
PRIMARY KEY (
   (partition\_column\_name[, ...]), 
    clustering\_column\_name [, ...])
```

Create a table that is optimized for query by cyclist rank by year:

```screen
CREATE TABLE cycling.rank_by_year_and_name ( 
   race_year int, 
   race_name text, 
   cyclist_name text, 
   rank int, 
   PRIMARY KEY ((race_year, race_name), rank) );
```

## table\_options {#tabProp}

CQL table properties and descriptions of the syntax.

Table properties tune data handling, including I/O operations, compression, and compaction. Set table properties in the following CQL requests:

-   [CREATE TABLE](cqlCreateTable.md#)
-   [ALTER TABLE](cqlAlterTable.md)
-   [CREATE MATERIALIZED VIEW](cqlCreateMaterializedView.md)
-   [ALTER MATERIALIZED VIEW](cqlAlterMaterializedView.md)

**Note:** Cassandra applies the default value if an option is not defined.

Table property options that have one value use the following syntax:

```
option\_name = 'value' [AND ...]
```

Table property that have multiple subproperties are specified in a map. Maps are in simple JSON format, key value pairs in a comma separated list enclosed by curly brackets:

```
option\_name = { 'subproperty' : 'value' [, ...] } [AND ...]
```

**Note:** Enclose strings in quotes; not required for numeric values.

In a CQL statement use a `WITH` clause to define table property options, separate multiple values with `AND`, for example:

```
ALTER TABLE [keyspace\_name.]table\_name
WITH option_name = 'value' 
AND option_name = option\_map;
```

 bloom\_filter\_fp\_chance
 :   False-positive probability for SSTable [bloom filter](https://en.wikipedia.org/wiki/Bloom_filter). When a client requests data, the bloom filter checks if the row exists before executing disk I/O.

```
bloom_filter_fp_chance = N
```

    Value ranges from 0 to 1.0, where:

    -   `0`: \(Min value\) enables the largest possible bloom filter and uses the most memory.
    -   `1.0`: \(Max value\) disables the bloom filter.

    **Tip:** Recommended setting: `0.1`. A higher value yields diminishing returns.

    **Default**: `bloom_filter_fp_chance = '0.01'`

  caching
 :   Caching optimizes the use of cache memory of a table without manual tuning. Cassandra weighs the cached data by size and access frequency. Coordinate this setting with the global caching properties in the cassandra.yaml file. See [Cassandra 3.0 documentation](/en/cassandra-oss/3.0/cassandra/operations/opsSetCaching.html).

```
caching = {
 'keys' = 'ALL | NONE',
 'rows_per_partition' = 'ALL' | 'NONE' |N}
```

    Valid values:

    -   `ALL`– all primary keys or rows
    -   `NONE`– no primary keys or rows
    -   `N`: \(rows per partition only\) Number of rows; specify a whole number

    Cassandra caches only the first N rows in a partition, as determined by the clustering order.

    For example, to cache all riders in each age partition:

    ```screen
    ALTER MATERIALIZED VIEW cycling.cyclist_by_age 
    WITH caching = { 
     'keys' : 'ALL', 
     'rows_per_partition' : 'ALL' } ;
    ```

    **Default**: `{ 'keys' : 'NONE', 'rows_per_partition' : 'NONE' }`

  cdc
 :   Create a Change Data Capture \(CDC\) log on the table.

```
cdc = TRUE | FALSE
```

    Valid values:

    -   `TRUE`- create CDC log
    -   `FALSE`- do not create CDC log

    `CREATE TABLE` and `ALTER TABLE` can be modified with this table option, but not `CREATE MATERIALIZED VIEW` or `ALTER MATERIALIZED VIEW`.

    For example, create a table with a CDC log:

    ```screen
    CREATE TABLE cycling.cyclist_name 
    WITH cdc = TRUE;
    ```

  comments
 :   Provide documentation on the table.

```
comments = 'text'
```

    **Tip:** Enter a description of the types of queries the table was designed to satisfy.

    For example, note the base table for the materialized view:

    ```screen
    ALTER MATERIALIZED VIEW cycling.cyclist_by_age 
    WITH comment = "Basetable: cyclist_mv";
    ```

  dclocal\_read\_repair\_chance
 :   Probability that a successful read operation triggers a read repair, between 0 and 1; default value: `0.01`. Unlike the repair controlled by [dclocal\_read\_repair\_chance](cqlCreateTable.md#cqlTableDclocal_read_repair_chance), this repair is limited to replicas in the same DC as the coordinator.

  default\_time\_to\_live
 :   TTL \(Time To Live\) in seconds, where zero is disabled. When specified, the value is set for the [Time To Live](/en/glossary/doc/glossary/gloss_ttl.html) \(TTL\) marker on each column in the table; default value: `0`. When the table TTL is exceeded, the table is tombstoned.

  gc\_grace\_seconds
 :   Seconds after data is marked with a tombstone \(deletion marker\) before it is eligible for garbage-collection. Default value: 864000. The default value allows time for Cassandra to maximize consistency prior to deletion.

    **Note:** Tombstoned records within the grace period are excluded from [hints](/en/cassandra-oss/3.0/cassandra/operations/opsRepairNodesHintedHandoff.html) or [batched mutations](../cql_using/useBatchTOC.md).

    In a single-node cluster, this property can safely be set to zero. You can also reduce this value for tables whose data is not explicitly deleted — for example, tables containing only data with [TTL](/en/glossary/doc/glossary/gloss_ttl.html) set, or tables with default\_time\_to\_live set. However, if you lower the gc\_grace\_seconds value, consider its interaction with these operations:

    -   **hint replays** — When a node goes down and then comes back up, other nodes replay the write operations \(called [hints](/en/cassandra-oss/3.0/cassandra/operations/opsRepairNodesHintedHandoff.html)\) that are queued for that node while it was unresponsive. Cassandra does not replay hints older than gc\_grace\_seconds after creation. The [max\_hint\_window\_in\_ms](/en/cassandra-oss/3.0/cassandra/configuration/configCassandra_yaml.html#max_hint_window_in_ms) setting in the [cassandra.yaml](/en/cassandra-oss/3.0/cassandra/configuration/configCassandra_yaml.html) file sets the time limit \(3 hours by default\) for collecting hints for the unresponsive node.
    -   **batch replays** — Like hint queues, [batch operations](../cql_using/useBatchTOC.md) store database mutations that are replayed in sequence. As with hints, Cassandra does not replay a batched mutation until gc\_grace\_seconds after it was created. If your application uses batch operations, consider the possibility that decreasing gc\_grace\_seconds increases the chance that a batched write operation may restore deleted data. The [batchlog\_replay\_throttle\_in\_kb](/en/cassandra-oss/3.0/cassandra/configuration/configCassandra_yaml.html#batchlog_replay) and [concurrent\_batchlog\_writes](/en/cassandra-oss/3.0/cassandra/configuration/configCassandra_yaml.html#concurrent_batchlog_writes) properties in the [cassandra.yaml](/en/cassandra-oss/3.0/cassandra/configuration/configCassandra_yaml.html) file give some control of the batch replay process. The most important factors, however, are the size and scope of the batches you use.

  memtable\_flush\_period\_in\_ms
 :   Milliseconds before `memtables` associated with the table are flushed.

    **Default**: `0`

  min\_index\_interval
 :   Minimum gap between index entries in the index summary. A lower min\_index\_interval means the index summary contains more entries from the index, which allows Cassandra to search fewer index entries to execute a read. A larger index summary may also use more memory. The value for min\_index\_interval is the densest possible sampling of the index.

  max\_index\_interval
 :   If the total memory usage of all index summaries reaches this value, Cassandra decreases the index summaries for the coldest SSTables to the maximum set by max\_index\_interval. The max\_index\_interval is the sparsest possible sampling in relation to memory pressure.

  read\_repair\_chance
 :   The probability that a successful read operation triggers a read repair. Unlike the repair controlled by [dclocal\_read\_repair\_chance](cqlCreateTable.md#cqlTableDclocal_read_repair_chance), this repair is not limited to replicas in the same DC as the coordinator. The value must be between `0` and `1`; default value: `0.0`.

  speculative\_retry
 :   Overrides normal read timeout when read\_repair\_chance is not 1.0, sending another request to read. Specify the value as a number followed by a type, `ms` \(milliseconds\) or `percentile`. For example, `speculative_retry = '3ms'`.

    Use the speculative retry property to configure [rapid read protection](https://www.datastax.com/blog/2013/10/rapid-read-protection-cassandra-202). In a normal read, Cassandra sends data requests to just enough replica nodes to satisfy the [consistency level](/en/glossary/doc/glossary/gloss_consistency_level.html). In rapid read protection, Cassandra sends out extra read requests to other replicas, even after the consistency level has been met. The speculative retry property specifies the trigger for these extra read requests.

    -   `ALWAYS`: The coordinator node sends extra read requests to all other replicas after every read of that table.
    -   `**X**percentile`: Cassandra constantly tracks each table's typical read latency \(in milliseconds\). Set speculative retry to `Xpercentile` to tell the coordinator node to retrieve the typical latency time of the table being read and calculate X percent of that figure. The coordinator sends redundant read requests if the number of milliseconds it waits without responses exceeds that calculated figure. \(For example, if the speculative\_retry property for Table\_A is set to `80percentile`, and that table's typical latency is 60 milliseconds, the coordinator node handling a read of Table\_A would send a normal read request first, and send out redundant read requests if it received no responses within 48ms, which is 80 % of 60ms.\)
    -   `**N**ms`: The coordinator node sends extra read requests to all other replicas if the coordinator node has not received any responses within `N` milliseconds.
    -   `NONE`: The coordinator node does not send extra read requests after any read of that table.

    For example:

    ```
    ALTER TABLE users WITH speculative_retry = '10ms';
    ```

    Or:

    ```
    ALTER TABLE users WITH speculative_retry = '99percentile';
    ```

 |Cassandra Version|Compaction Strategy|
|-----------------|-------------------|
|3.0 Linux|[LCS](/en/cassandra-oss/3.0/cassandra/dml/dmlHowDataMaintain.html#dmlHowDataMaintain__lcs-compaction)|[STCS](/en/cassandra-oss/3.0/cassandra/dml/dmlHowDataMaintain.html#dmlHowDataMaintain__stcs-compaction)|[DTCS](/en/cassandra-oss/3.0/cassandra/dml/dmlHowDataMaintain.html#dmlHowDataMaintain__dtcs-compaction)|[TWCS](/en/cassandra-oss/3.0/cassandra/dml/dmlHowDataMaintain.html#dmlHowDataMaintain__twcs)|
|3.x Linux|[LCS](/en/cassandra-oss/3.x/cassandra/dml/dmlHowDataMaintain.html#dmlHowDataMaintain__lcs-compaction)|[STCS](/en/cassandra-oss/3.x/cassandra/dml/dmlHowDataMaintain.html#dmlHowDataMaintain__stcs-compaction)|[DTCS](/en/cassandra-oss/3.x/cassandra/dml/dmlHowDataMaintain.html#dmlHowDataMaintain__dtcs-compaction)|[TWCS](/en/cassandra-oss/3.x/cassandra/dml/dmlHowDataMaintain.html#dmlHowDataMaintain__twcs)|

### compression {#compressSubprop}

Configuring compression for a table.

Configure `compression` by specifying the compression algorithm class followed by the subproperties in simple JSON format. Choosing the right compressor depends on your requirements for space savings over read performance. LZ4 is fastest to decompress, followed by Snappy, then by Deflate. Compression effectiveness is inversely correlated with decompression speed. The extra compression from Deflate or Snappy is not enough to make up for the decreased performance for general-purpose workloads, but for archival data they may be worth considering. Developers can also implement custom compression classes using the `org.apache.cassandra.io.compress.ICompressor` interface.

``` {#cqlTableCompressionSyntax}
compression = { 
   ['class' : 'compression\_algorithm\_name', 
     'chunk_length_kb' : 'value',  
     'crc_check_chance' : 'value',] 
   | 'sstable_compression' : ''] 
}
```

|Subproperty|Description|
|-----------|-----------|
|class|Sets the compressor name, The class name of the compression algorithm. Cassandra provides the following built-in classes:

-   `LZ4Compressor`, see
-   `SnappyCompressor`
-   `DeflateCompressor`

Default: `LZ4Compressor`.|
|chunk\_length\_kb|Size \(in KB\) of the block. On disk, SSTables are compressed by block to allow random reads. Values larger than the default value might improve the compression rate, but increases the minimum size of data to be read from disk when a read occurs. The default value is a good middle-ground for compressing tables. Adjust compression size to account for read/write access patterns \(how much data is typically requested at once\) and the average size of rows in the table. Default value: `64KB`. Default value:``.

|
|crc\_check\_chance|When compression is enabled, each compressed block includes a checksum of that block for the purpose of detecting disk bitrot and avoiding the propagation of corruption to other replica. This option defines the probability with which those checksums are checked during read. By default they are always checked. Set to 0 to disable checksum checking and to 0.5, for instance, to check them on every other read. Default: `1.0`.

|
|sstable\_compression|Disables compression. Specify a null value.|

To disable compression, specify the `sstable_compression` option with value of empty string \(''\):

```screen
ALTER TABLE cycling.cyclist_name 
WITH COMPRESSION = {'sstable_compression': ''};
```

### compaction {#compactSubprop}

Constructing a map of the compaction option and its subproperties.

The compaction option in [CREATE TABLE](cqlCreateTable.md#) or [ALTER TABLE](cqlAlterTable.md#alter-compression) `WITH` clause defines the strategy for cleaning up data after writes. Define a compaction class and properties in simple JSON format:

```
compaction = { 
   'class' : 'compaction\_strategy\_name' 
   [, 'subproperty\_name' : 'value',...] 
}
```

**Note:** 

For more guidance, see the [When to Use Leveled Compaction](https://www.datastax.com/blog/2011/10/when-use-leveled-compaction), [Leveled Compaction in Apache Cassandra](https://www.datastax.com/blog/2011/10/leveled-compaction-apache-cassandra) blog, and [How data is maintained](/en/cassandra-oss/3.0/cassandra/dml/dmlHowDataMaintain.html).

#### compaction properties {#cqlTableCompSizeTieredCompactionStrategy .section}

Cassandra provides the following compaction classes, each class has different subproperties:

-   [SizeTieredCompactionStrategy \(STCS\)](cqlCreateTable.md#compactionSubpropertiesSTCS)
-   [DateTieredCompactionStrategy](cqlCreateTable.md#compactionSubproperties)
-   [TimeWindowCompactionStrategy \(TWCS\)](cqlCreateTable.md#compactionSubpropertiesTWCS)
-   [LeveledCompactionStrategy \(LCS\)](cqlCreateTable.md#compactionSubpropertiesLCS)

 SizeTieredCompactionStrategy \(STCS\)
 :   Triggers a minor compaction when table meets the `min_threshold`. Minor compactions do not involve all the tables in a keyspace.See [SizeTieredCompactionStrategy](/en/cassandra-oss/3.x/cassandra/dml/dmlHowDataMaintain.html#dmlHowDataMaintain__stcs-compaction) in the Cassandra documentation for more details.

    Default compaction strategy.

    |Subproperty|Description|
    |-----------|-----------|
    |bucket\_high|Size-tiered compaction merges sets of SSTables that are approximately the same size. Casssandra compares each SSTable size to the average of all SSTable sizes on the node. It merges SSTables whose size in KB are within \[average-size × bucket\_low\] and \[average-size × bucket\_high\].Default value: `1.5`

|
    |bucket\_low|See [bucket\_high](cqlCreateTable.md#compaction_bucket_high). Default value: `0.5`.

|
    |enabled|Enables background compaction. Default value: `true`. See [Enabling and disabling background compaction](cqlCreateTable.md#moreEnableDisable).|
    |log\_all|Activates advanced logging for the entire cluster. Default value: `false`.

|
    |max\_threshold|The maximum number of SSTables to allow in a minor compaction. Default value: `32`.

|
    |min\_threshold|The minimum number of SSTables to trigger a minor compaction. Default value: `4`.|
    |min\_sstable\_size|STCS groups SSTables into buckets. The bucketing process groups SSTables that differ in size by less than 50%. This bucketing process is too fine grained for small SSTables. If your SSTables are small, use min\_sstable\_size to define a size threshold \(in bytes\) below which all SSTables belong to one unique bucket. Default value: `50MB`.|
    |only\_purge\_repaired\_tombstones|In Cassandra 3.0 and later: true allows purging tombstones only from repaired SSTables. The purpose is to prevent data from resurrecting if repair is not run within `gc_grace_seconds`. If you do not run repair for a long time, Cassandra keeps all tombstones — this may cause problems. Default value: `false`.|
    |tombstone\_compaction\_interval|The minimum number of seconds after which an SSTable is created before Cassandra considers the SSTable for tombstone compaction. An SSTable is eligible for tombstone compaction if the table exceeds the tombstone\_threshold ratio. Default value: `86400`.|
    |tombstone\_threshold|The ratio of garbage-collectable tombstones to all contained columns. If the ratio exceeds this limit, Cassandra starts compaction on that table alone, to purge the tombstones. Default value: `0.2`.|
    |unchecked\_tombstone\_compaction|True allows Cassandra to run tombstone compaction without pre-checking which tables are eligible for this operation. Even without this pre-check, Cassandra checks an SSTable to make sure it is safe to drop tombstones. Default value: `false`.|

    **Note:** Cassandra 3.0 and later no longer support the `cold_reads_to_omit` property for [SizeTieredCompactionStrategy](/en/cassandra-oss/3.0/cassandra/dml/dmlHowDataMaintain.html#dml_types_of_compaction).

    **Note:** For more details, see [How data is maintained \> Compaction Strategy \> STCS](/en/cassandra-oss/3.x/cassandra/dml/dmlHowDataMaintain.html#dmlHowDataMaintain__stcs-compaction)

  DateTieredCompactionStrategy
 :   Stores data written within a certain period of time in the same SSTable. Also see [DateTieredCompactionStrategy](/en/cassandra-oss/3.x/cassandra/dml/dmlHowDataMaintain.html#dmlHowDataMaintain__dtcs-compaction) in the Cassandra documentation.

    |Subproperty|Description|
    |-----------|-----------|
    |base\_time\_seconds|The size of the first time window. Default value: `3600`.|
    |enabled|Enables background compaction. Default value: `true`. See [Enabling and disabling background compaction](cqlCreateTable.md#moreEnableDisable).|
    |log\_all|True activates advanced logging for the entire cluster. Default value: `false`.|
    |max\_sstable\_age\_days|Cassandra does not compact SSTables if its most recent data is older than this property. Fractional days can be set. Default value: `1000`. **Attention:** This parameter is deprecated.

|
    |max\_window\_size\_seconds|The maximum window size in seconds. Default value: `86400`.|
    |max\_threshold|The maximum number of SSTables allowed in a minor compaction. Default value: `32`.|
    |min\_threshold|The minimum number of SSTables that trigger a minor compaction. Default value: `4`.|
    |timestamp\_resolution|Units, MICROSECONDS or MILLISECONDS, to match the timestamp of inserted data. Default value: `MICROSECONDS`.|
    |tombstone\_compaction\_interval|The minimum number of seconds after an SSTable is created before Cassandra considers the SSTable for tombstone compaction. Tombstone compaction is triggered if the number of garbage-collectable tombstones in the SSTable is greater than tombstone\_threshold. Default value: `86400`.|
    |tombstone\_threshold|The ratio of garbage-collectable tombstones to all contained columns. If the ratio exceeds this limit, Cassandra starts compaction on that table alone, to purge the tombstones. Default value: `0.2`.|
    |unchecked\_tombstone\_compaction|True allows Cassandra to run tombstone compaction without pre-checking which tables are eligible for this operation. Even without this pre-check, Cassandra checks an SSTable to make sure it is safe to drop tombstones. Default value: `false`.|

  TimeWindowCompactionStrategy \(TWCS\)
 :   Compacts SSTables using a series of *time windows* or *buckets*. TWCS creates a new time window within each successive time period. During the active time window, TWCS compacts all SSTables flushed from memory into larger SSTables using STCS. At the end of the time period, all of these SSTables are compacted into a single SSTable. Then the next time window starts and the process repeats. See [TimeWindowCompactionStrategy](/en/cassandra-oss/3.x/cassandra/dml/dmlHowDataMaintain.html#dmlHowDataMaintain__twcs-compaction) in the Cassandra documentation for more details. 

    |Compaction Subproperties|Description|
    |------------------------|-----------|
    |compaction\_window\_unit|Time unit used to define the bucket size, milliseconds, seconds, hours, etc. Default value: `milliseconds`.|
    |compaction\_window\_size|Units per bucket.|
    |log\_all|True activates advanced logging for the entire cluster. Default value: `false`.|

  LeveledCompactionStrategy \(LCS\)
 :   Creates SSTables of a fixed, relatively small size \(160 MB by default\) that are grouped into levels. Within each level, SSTables are guaranteed to be non-overlapping. Each level \(L0, L1, L2 and so on\) is 10 times as large as the previous. Disk I/O is more uniform and predictable on higher than on lower levels as SSTables are continuously being compacted into progressively larger levels. At each level, row keys are merged into non-overlapping SSTables in the next level. See [LeveledCompactionStrategy \(LCS\)](/en/cassandra-oss/3.x/cassandra/dml/dmlHowDataMaintain.html#dmlHowDataMaintain__lcs-compaction) in the Cassandra documentation.

    |Subproperties|Default|Description|
    |-------------|-------|-----------|
    |enabled|true|Enables background compaction. See [Enabling and disabling background compaction](cqlCreateTable.md#moreEnableDisable) below.|
    |log\_all|false|True activates advanced logging for the entire cluster.|
    |sstable\_size\_in\_mb|160MB|The target size for SSTables that use the Leveled Compaction Strategy. Although SSTable sizes should be less or equal to sstable\_size\_in\_mb, it is possible tthat compaction may produce a larger SSTable during compaction. This occurs when data for a given partition key is exceptionally large. Cassandra does not split the data into two SSTables.|
    |tombstone\_compaction\_interval|864000 \(one day\)|The minimum number of seconds after an SSTable is created before Cassandra considers the SSTable for tombstone compaction. Cassandra begins tombstone compaction SSTable's tombstone\_threshold exceeds value of the following property.|
    |tombstone\_threshold|0.2|The ratio of garbage-collectable tombstones to all contained columns. If the ratio exceeds this limit, Cassandra starts compaction on that table alone, to purge the tombstones.|
    |unchecked\_tombstone\_compaction|false|True allows Cassandra to run tombstone compaction without pre-checking which tables are eligible for this operation. Even without this pre-check, Cassandra checks an SSTable to make sure it is safe to drop tombstones.|

 #### Enabling and disabling background compaction {#moreEnableDisable .section}

The following example sets the enable property to disable background compaction:

```
ALTER TABLE mytable 
WITH COMPACTION = {
   'class': 'SizeTieredCompactionStrategy', 
   'enabled': 'false' }
```

Disabling background compaction can be harmful: without it, Cassandra does not regain disk space, and may allow [zombies](/en/glossary/doc/glossary/gloss_zombie.html) to propagate. Although compaction uses I/O, it is better to leave it enabled in most cases.

#### Reading extended compaction logs {#enabling-extended-compaction-logging .section}

Set the `log_all` subproperty to `true` to collect in-depth information about compaction activity on a node in a dedicated log file.

**Important:** If you enable extended logging for any table on any node, Cassandra enables it for all tables on all nodes in the cluster.

When extended compaction is enabled, Cassandra creates a file named compaction-%d.log \(where `%d` is a sequential number\) in home/logs.

The compaction logging service logs detailed information about four types of compaction events:

-   `type:enable`

    Lists SSTables that have been flushed previously

    ```
    {"type":"enable","keyspace":"test","table":"t","time":1470071098866,"strategies":
      [    {"strategyId":"0","type":"LeveledCompactionStrategy","tables":[],"repaired":true,"folders":
          ["/home/carl/oss/cassandra/bin/../data/data"]},
        {"strategyId":"1","type":"LeveledCompactionStrategy","tables":[],"repaired":false,"folders":
          ["/home/carl/oss/cassandra/bin/../data/data"]
        }
     ]
    }
    ```

-   `type: flush`

    Logs a flush event from a memtable to an SSTable on disk, including the CompactionStrategy for each table.

    ```
    {"type":"flush","keyspace":"test","table":"t","time":1470083335639,"tables":
      [    {"strategyId":"1","table":
          {"generation":1,"version":"mb","size":106846362,"details":
            {"level":0,"min_token":"-9221834874718566760","max_token":"9221396997139245178"}
          }
        }
     ]
    }
    
    ```

-   `type: compaction`

    Logs a compaction event.

    ```
    {"type":"compaction","keyspace":"test","table":"t","time":1470083660267,"start":"1470083660188","end":"1470083660267","input":
      [    {"strategyId":"1","table":
          {"generation":1372,"version":"mb","size":1064979,"details":
            {"level":1,"min_token":"7199305267944662291","max_token":"7323434447996777057"}
          }
        }
     ],"output":
      [    {"strategyId":"1","table":
          {"generation":1404,"version":"mb","size":1064306,"details":
            {"level":2,"min_token":"7199305267944662291","max_token":"7323434447996777057"}
          }
        }
     ]
    }
    
    ```

-   `type: pending`

    Lists the number of pending tasks for a compaction strategy

    ```
    {"type":"pending","keyspace":"test","table":"t","time":1470083447967,"strategyId":"1","pending":200}
    ```


### Table keywords {#refClstrOrdr}

 CLUSTERING ORDER BY \( column\_name ASC \| DESC\)
 :   Order rows storage to make use of the on-disk sorting of columns. Specifying order can make query results more efficient. Options are:

     `ASC`: ascending \(default order\)

     `DESC`: descending, reverse order

    The following example shows a table definition that changes the clustering order to descending by insertion time.

    The following example shows a table definition stores the categories with the highest points first.

    ```screen
    CREATE TABLE cycling.cyclist_category ( 
       category text, 
       points int, 
       id UUID, 
       lastname text, 
       PRIMARY KEY (category, points)) 
    WITH CLUSTERING ORDER BY (points DESC);
    ```

  COMPACT STORAGE
 :   Use `COMPACT STORAGE` to store data in the legacy \(Thrift\) storage engine format to conserve disk space.

    Use compact storage for the category table.

    ```
    CREATE TABLE cycling.cyclist_category ( 
       category text, 
       points int, 
       id UUID, 
       lastname text, 
       PRIMARY KEY (category, points)) 
    WITH CLUSTERING ORDER BY (points DESC)
       AND COMPACT STORAGE;
    ```

    **Important:** For Cassandra 3.0 and later, the [storage engine is much more efficient](https://www.datastax.com/2015/12/storage-engine-30) at storing data, and compact storage is not necessary.

  ID
 :   If a table is accidentally dropped with [DROP TABLE](cqlDropTable.md), use this option to recreate the table and run a commitlog replayer to retrieve the data.

    ```
    CREATE TABLE users (
      userid text PRIMARY KEY,
      emails set<text>
    ) WITH ID='5a1c395e-b41f-11e5-9f22-ba0be0483c18';
    ```

 #### Configuring read repairs {#cql_tabprop_more_read_repairs .section}

Cassandra performs [read repair](/en/cassandra-oss/3.0/cassandra/operations/opsRepairNodesReadRepair.html) whenever a read reveals inconsistencies among replicas. You can also configure Cassandra to perform read repair after a completely consistent read. Cassandra compares and coordinates all replicas, even those that were not accessed in the successful read. The [dclocal\_read\_repair\_chance](cqlCreateTable.md#cqlTableDclocal_read_repair_chance) and [read\_repair\_chance](cqlCreateTable.md#cqlTableRead_repair_chance) set the probability that a consistent read of a table triggers a read repair. The first of these properties sets the probability for a read repair that is confined to the same datacenter as the coordinator node. The second property sets the probability for a read repair across all datacenters that contain matching replicas. This cross-datacenter operation is much more resource-intensive than the local operation.

Recommendations: if the table is for time series data, both properties can be set to `0` \(zero\). For other tables, the more performant strategy is to set dc\_local\_read\_repair\_chance to `0.1` and read\_repair\_chance to `0`. If you want to use read\_repair\_chance, set this property to `0.1`.

