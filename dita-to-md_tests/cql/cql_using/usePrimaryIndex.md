# Indexing {#usePrimaryIndex .concept}

An index provides a means to access data in Cassandra using attributes other than the partition key for fast, efficient lookup of data matching a given condition.

An index provides a means to access data in Cassandra using attributes other than the partition key. The benefit is fast, efficient lookup of data matching a given condition. The index indexes column values in a separate, hidden table from the one that contains the values being indexed. Cassandra has a number of [techniques](https://www.datastax.com/dev/blog/improving-secondary-index-write-performance-in-1-2) for guarding against the undesirable scenario where data might be incorrectly retrieved during a query involving indexes on the basis of stale values in the index.

Indexes can be used for collections, collection columns, static columns, and any other columns except counter columns.

In Cassandra 3.4 and later, [SSTable Attached Secondary Indexes \(SASI\)](useSASIIndex.md) have been introduced.

-   **[When to use an index](../../cql/cql_using/useWhenIndex.md)**  
When and when not to use an index.
-   **[Using a secondary index](../../cql/cql_using/useSecondaryIndex.md)**  
Using CQL to create a secondary index on a column after defining a table.
-   **[Using multiple indexes](../../cql/cql_using/useMultIndexes.md)**  
How to use multiple secondary indexes.
-   **[Indexing a collection](../../cql/cql_using/useIndexColl.md)**  
How to index collections and query the database to find a collection containing a particular value.

**Parent topic:** [Indexing tables](../../cql/cql_using/useCreateQueryIndexes.md)

