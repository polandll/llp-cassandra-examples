# What's new in Apache Cassandra 3.x {#features .concept}

An overview of new features in Apache Cassandra 3.x.

The latest version of Apache Cassandra™ 3.x is 3.9.

The [CHANGES.txt](https://github.com/apache/cassandra/blob/cassandra-3.6/CHANGES.txt#L1-L113) describes the changes in detail. You can view all version changes by branch or tag in the drop-down list on the changes page.

## New features Cassandra 3.2 and later {#new-features-linux3x .section}

| **-graph option for cassandra-stress**

 | `cassandra-stress` results can be [automatically graphed](tools/toolsCStress.md#cstress-graph) for data visualization.

 |
| **TTL for COPY FROM**

 | A [TTL value](/en/cql-oss/3.3/cql/cql_reference/cqlshCopy.html) can be specified when copying from CSV files.

 |
| **bulkloader can use third party authentication**

 | The [bulkloader](tools/toolsBulkloader.md) has an option `-ap` for third-party authentication.

 |
| **CREATE TABLE WITH ID**

 | If a table is accidentally dropped, it can be [recreated with its ID](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html) and the commitlog replayed to regain data.

 |
| **Static columns can be indexed**

 | In Cassandra 3.4 and later, static columns can be indexed.

 |
| **New option for nodetool compact**

 | In Cassandra 3.4 and later, addition of --user-defined[compact](tools/toolsCompact.md) to `nodetool compact` to allow user to submit a list of files. Handy for dealing with low disk space or tombstone purging.

 |
| **Display timestamp in sub-second precision**

 | In Cassandra 3.4 and later, [timestamp](/en/cql-oss/3.3/cql/cql_reference/timestamp_type_r.html) defaults to include sub-second precision.

 |
| **nodetool gettimeout and nodetool settimeout**

 | In Cassandra 3.4 and later, two nodetool commands to print out or set the value of a timeout in milliseconds.

 |
| **jvm.options file for GC and some JVM options**

 | Some JVM options have been moved from the cassandra-env.sh file into the new [jvm.options](tools/toolsCUtility.md) file.

 |
| **JBOD improvements**

 | Improvements to SSTable partitioning by token range have improved JBOD compaction and backup. See [Improving JBOD](https://www.datastax.com/dev/blog/improving-jbod) for more details. A new command is available to support the improvements, [nodetool relocatesstables](tools/toolsRelocateSSTables.md).

 |
| **Clustering columns can be used in WHERE clause without secondary index**

 | In Cassandra 3.6 and later, [clustering columns without a secondary index can be used in a WHERE clause](/en/cql-oss/3.3/cql/cql_using/useQueryColumnsSort.html), provided the ALLOW FILTERING clause is also used.

 |
| **Update and delete individual subfields of a user-defined type \(UDT\)**

 | In Cassandra 3.6 and later, if a UDT has only non-collection fields, an [individual field value can be updated or deleted](/en/cql-oss/3.3/cql/cql_using/useInsertUDT.html).

 |
| **PER PARTITION LIMIT**

 | In Cassandra 3.6 and later, a query can be [limited to return results from each partition](/en/cql-oss/3.3/cql/cql_using/useQueryColumnsSort.html), such as a "Top 3" listing.

 |
| **CAS statistics added to nodetool proxyhistograms**

 | In Cassandra 3.6 and later, [CAS read and write latency](tools/toolsProxyHistograms.md) is displayed for compare-and-set operations.

 |
| **--hex-format option added to nodetool getsstables**

 | In Cassandra 3.6 and later, an option to use a [hex-formatted key](tools/toolsGetSstables.md) to get SSTables is added to nodetool getsstables.

 |
| **Static columns can now be used with SASI indexes**

 | In Cassandra 3.6 and later, [static columns can be used with SASI indexes](/en/cql-oss/3.x/cql/cql_reference/cqlCreateCustomIndex.html).

 |
| **Change Data Capture \(CDC\) logging**

 |In Cassandra 3.8 and later, [change data capture \(CDC\) logging](configuration/configCDCLogging.md) can be enabled.|

## New features released in Cassandra 3.0 {#new-features .section}

| **Storage engine refactored**

 |The Storage Engine has been refactored.|
| **Materialized Views**

 |Materialized views handle automated server-side denormalization, with consistency between base and view data.|
|***Operations improvements***|
| **Addition of MAX\_WINDOW\_SIZE\_SECONDS to DTCS compaction settings**

 | Allow DTCS compaction governance based on [maximum window size](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#compactSubprop__cqlTableCompSizeTieredCompactionStrategy) rather than SSTable age.

 |
| **File-based Hint Storage and Improved Replay**

 | Hints are now stored in files and replay is improved.

 |
| **Default garbage collector is changed to G1**

 | [Default garbage collector](operations/opsTuneJVM.md) is changed from Concurrent-Mark-Sweep \(CMS\) to G1. G1 performance is better for nodes with heap size of 4GB or greater.

 |
| **Changed syntax for CREATE TABLE compression options**

 | Made the compression options more consistent for `CREATE TABLE`.

 |
| **Add nodetool command to force blocking batchlog replay**

 | BatchlogManager can force batchlog replay using nodetool.

 |
| **Nodetool over SSL**

 | Nodetool can connect using SSL like cqlsh.

 |
| **New nodetool options for hinted handoffs**

 | Nodetool options `disablehintsfordc` and `enablehintsfordc` added. to selectively disable or enable hinted handoffs for a datacenter.

 |
| **nodetool stop**

 | Nodetool option added to stop compactions.

 |
|***Other notable changes***|
| **Requires Java 8**

 | Java 8 is now required.

 |
| **nodetool cfstats and nodetool cfhistograms renamed**

 | Renamed `nodetool cfstats` to `nodetool tablestats`. Renamed `nodetool cfhistograms` to `nodetool tablehistograms`.

 |
| **Native protocol v1 and v2 are dropped**

 | Native protocol v1 and v2 are dropped in Cassandra 3.0.

 |

**Parent topic:** [About Apache Cassandra](../cassandra/cassandraAbout.md)

