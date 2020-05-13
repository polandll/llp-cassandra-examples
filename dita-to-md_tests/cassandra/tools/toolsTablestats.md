# nodetool tablestats {#toolsTablestats .reference}

Provides statistics about one or more tables.

Provides statistics about one or more tables.

## Synopsis {#synopsis .section}

```language-bash
nodetool [ options ] tablestats
[ -H | --human-readable ] 
[ -i  table [, table ] . . . ] [ - - ] 
[ keyspace | table | keyspace.table ] [keyspace | table | keyspace.table ] . . .
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`-F format`|`--format format`|Output format: `json` or `yaml`.|
|`-H`|`--human-readable`|Display bytes in human readable form: KiB \(kibibyte\), MiB \(mebibyte\), GiB \(gibibyte\), TiB \(tebibyte\).|
|`-i`|``|Ignore the list of tables and display the remaining tables.|
|keyspace.table|List of tables \(or keyspace\) names.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

The nodetool tablestats command provides statistics about one or more tables. It's updated when SSTables change through compaction or flushing. Cassandra uses the [metrics-core](http://metrics.dropwizard.io/3.1.0/) library to make the output more informative and easier to understand.

|Name of statistic|Example value|Brief description|Related information|
|-----------------|-------------|-----------------|-------------------|
|Keyspace|libdata|Name of the [keyspace](/en/glossary/doc/glossary/gloss_keyspace.html)|[Keyspace and table](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#refClstrOrdr__cql-compact-storage) |
|Table|libout|Name of this [table](/en/glossary/doc/glossary/gloss_table.html)| |
|SSTable count|3|Number of [SSTables](/en/glossary/doc/glossary/gloss_sstable.html) containing data for this table|[How to use the SSTable counts metric](/en/dse-trblshoot/doc/troubleshooting/slowReads.html)|
|Space used \(live\)|9592399|Total number of bytes of disk space used by all active SSTables belonging to this table|[Storing data on disk in SSTables](../dml/dmlHowDataWritten.md#storing-data-on-disk-in-sstables)|
|Space used \(total\)|9592399|Total number of bytes of disk space used by SSTables belonging to this table, including obsolete SSTables waiting to be GCd|Same as above.|
|Space used by snapshots \(total\):|0|Total number of bytes of disk space used by snapshot of this table's data|[About snapshots](../operations/opsAboutSnapshots.md)|
|Off heap memory used \(total\)| |Total number of bytes of off heap memory used for memtables, Bloom filters, index summaries and compression metadata for this table| |
|SSTable Compression Ratio|0.367…|Ratio of size of compressed SSTable data to its uncompressed size|Types of [compression](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#compressSubprop) options.|
|Number of keys \(estimate\)|3|The number of partition keys for this table|Not the number of primary keys. This gives you the estimated number of partitions in the table.|
|Memtable cell count|1022550|Number of cells \(storage engine rows x columns\) of data in the [memtable](/en/glossary/doc/glossary/gloss_memtable.html) for this table|[Cassandra memtable structure in memory](../dml/dmlIntro.md)|
|Memtable data size|32028148|Total number of bytes in the memtable for this table|Total amount of live data stored in the memtable, excluding any data structure overhead.|
|Memtable off heap memory used|0|Total number of bytes of off-heap data for this memtable, including column related overhead and partitions overwritten|The maximum amount is set in cassandra.yaml by the property [memtable\_offheap\_space\_in\_mb](../configuration/configCassandra_yaml.md#memtable_offheap_space_in_mb).|
|Memtable switch count|3|Number of times a full memtable for this table was swapped for an empty one|Increases each time the memtable for a table is flushed to disk. See [How memtables are measured](http://thelastpickle.com/blog/2011/05/04/How-are-Memtables-measured.html) article.|
|Local read count|11207|Number of requests to read tables in the keyspace since startup| |
|Local read latency|0.048 ms|Round trip time in milliseconds to complete the most recent request to read the table|[Factors that affect read latency](../dml/dmlAboutReads.md)|
|Local write count|17598|Number of local requests to update the table since startup| |
|Local write latency|0.054 ms|Round trip time in milliseconds to complete an update to the table|[Factors that affect write latency](../dml/dmlAboutDataConsistency.md) |
|Pending flushes|0|Estimated number of reads, writes, and cluster operations pending for this table| **Important:** Monitor this metric to watch for blocked or overloaded memtable flush writers. The [nodetool tpstats](toolsTPstats.md) tool does not report on blocked flushwriters.

 |
|Bloom filter false positives|0|Number of false positives reported by this table's Bloom filter|[Tuning bloom filters](../operations/opsTuningBloomFilters.md)|
|Bloom filter false ratio|0.00000|Fraction of all bloom filter checks resulting in a false positive from the most recent read| |
|Bloom filter space used, bytes|11688|Size in bytes of the bloom filter data for this table| |
|Bloom filter off heap memory used|8|The number of bytes of off heap memory used for Bloom filters for this table| |
|Index summary off heap memory used|41|The number of bytes of off heap memory used for index summaries for this table| |
|Compression metadata off heap memory used|8|The number of bytes of off heap memory used for compression offset maps for this table| |
|Compacted partition minimum|1110|Size in bytes of the smallest compacted partition for this table| |
|Compacted partition maximum bytes|126934|Size in bytes of the largest compacted partition for this table| |
|Compacted partition mean bytes|2730|The average size of compacted partitions for this table| |
|Average live cells per slice \(last five minutes\)|0.0|Average number of cells scanned by single key queries during the last five minutes| |
|Maximum live cells per slice \(last five minutes\)|0.0|Maximum number of cells scanned by single key queries during the last five minutes| |
|Average tombstones per slice \(last five minutes\)|0.0|Average number of tombstones scanned by single key queries during the last five minutes| |
|Maximum tombstones per slice \(last five minutes\)|0.0|Maximum number of tombstones scanned by single key queries during the last five minutes| |
|Dropped mutations|0.0|The number of mutations \(INSERTs, UPDATEs or DELETEs\) started on this table but not completed|A high number of dropped mutations can indicate an overloaded node.|

## Examples {#example .section}

An excerpt of the output of the command reporting on a library data table just flushed to disk.

```
$ nodetool tablestats keyspace1.standard1
Keyspace: keyspace1
	Read Count: 182849
	Read Latency: 0.11363755339104945 ms.
	Write Count: 435355
	Write Latency: 0.01956930550929701 ms.
	Pending Flushes: 0
		Table: standard1
		SSTable count: 2
		Space used (live): 54131487
		Space used (total): 54131487
		Space used by snapshots (total): 0
		Off heap memory used (total): 309620
		SSTable Compression Ratio: 0.0
		Number of keys (estimate): 376390
		Memtable cell count: 200120
		Memtable data size: 47355786
		Memtable off heap memory used: 0
		Memtable switch count: 2
		Local read count: 182849
		Local read latency: 0.125 ms
		Local write count: 435355
		Local write latency: 0.022 ms
		Pending flushes: 0
		Bloom filter false positives: 11
		Bloom filter false ratio: 0.00009
		Bloom filter space used: 272192
		Bloom filter off heap memory used: 272176
		Index summary off heap memory used: 37444
		Compression metadata off heap memory used: 0
		Compacted partition minimum bytes: 216
		Compacted partition maximum bytes: 258
		Compacted partition mean bytes: 258
		Average live cells per slice (last five minutes): 1.0
		Maximum live cells per slice (last five minutes): 1
		Average tombstones per slice (last five minutes): 1.0
		Maximum tombstones per slice (last five minutes): 1

```

Using the human-readable option

Use the human-readable `-H` option to get output in easier-to-read units. For example:

```
$ C:\> %CASSANDRA\_HOME%nodetool tablestats -H keyspace1.standard1
Keyspace: keyspace1
	Read Count: 182849
	Read Latency: 0.11363755339104945 ms.
	Write Count: 435355
	Write Latency: 0.01956930550929701 ms.
	Pending Flushes: 0
		Table: standard1
		SSTable count: 2
		Space used (live): 51.62 MB
		Space used (total): 51.62 MB
		Space used by snapshots (total): 0 bytes
		Off heap memory used (total): 302.36 KB
		SSTable Compression Ratio: 0.0
		Number of keys (estimate): 376390
		Memtable cell count: 200120
		Memtable data size: 45.16 MB
		Memtable off heap memory used: 0 bytes
		Memtable switch count: 2
		Local read count: 182849
		Local read latency: 0.125 ms
		Local write count: 435355
		Local write latency: 0.022 ms
		Pending flushes: 0
		Bloom filter false positives: 11
		Bloom filter false ratio: 0.00000
		Bloom filter space used: 265.81 KB
		Bloom filter off heap memory used: 265.8 KB
		Index summary off heap memory used: 36.57 KB
		Compression metadata off heap memory used: 0 bytes
		Compacted partition minimum bytes: 216 bytes
		Compacted partition maximum bytes: 258 bytes
		Compacted partition mean bytes: 258 bytes
		Average live cells per slice (last five minutes): 1.0
		Maximum live cells per slice (last five minutes): 1
		Average tombstones per slice (last five minutes): 1.0
		Maximum tombstones per slice (last five minutes): 1

```

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

