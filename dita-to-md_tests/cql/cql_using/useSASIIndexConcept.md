# Indexing with SSTable attached secondary indexes \(SASI\) {#useSASIIndexConcept .concept}

Explain what a SSTable Attached Secondary Index \(SASI\) is.

In Cassandra 3.4 and later, SSTable Attached Secondary Indexes \(SASI\) have been introduced that improve on the existing secondary index implementation with superior performance for queries that previously required the use of `ALLOW FILTERING`. SASI is significantly less resource intensive, using less memory, disk, and CPU. It enables querying with prefix and contains on strings, similar to the SQL implementation of `LIKE = "foo%"` or `LIKE = "%foo%"`, as shown in SELECT. It also supports SPARSE indexing to improve performance of querying large, dense number ranges such as time series data.

SASI takes advantage of Cassandra's write-once immutable ordered data model to build indexes when data is flushed from the memtable to disk. The SASI index data structures are built in memory as the SSTable is written and flushed to disk as sequential writes before the SSTable writing completes. One index file is written for each indexed column.

SASI supports all queries already supported by CQL, and supports the `LIKE` operator using `PREFIX`, `CONTAINS`, and `SPARSE`. If `ALLOW FILTERING` is used, SASI also supports queries with multiple predicates using `AND`. With SASI, the performance pitfalls of using filtering are not realized because the filtering is not performed even if `ALLOW FILTERING` is used.

SASI is implemented using memory mapped B+ trees, an efficient data structure for indexes. B+ trees allow range queries to perform quickly. SASI generates an index for each SSTable. Some key features that arise from this design are:

-   SASI can reference offsets in the data file, skipping the Bloom filter and partition indexes to go directory to where data is stored.
-   When SSTables are compacted, new indexes are generated automatically.

Currently, SASI does not support collections. Regular [secondary indexes](useIndexColl.md) can be built for collections. Static columns are supported in Cassandra 3.6 and later.

-   **[Using a SSTable Attached Secondary Index \(SASI\)](../../cql/cql_using/useSASIIndex.md)**  
Using CQL to create a SSTable Attached Secondary Index \(SASI\) on a column after defining a table.

**Parent topic:** [Indexing tables](../../cql/cql_using/useCreateQueryIndexes.md)

