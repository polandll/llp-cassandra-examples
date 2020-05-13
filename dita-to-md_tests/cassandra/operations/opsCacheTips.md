# Tips for efficient cache use {#opsCacheTips .concept}

Various tips for efficient cache use.

[Tuning the row cache in Cassandra 2.1](https://www.datastax.com/dev/blog/row-caching-in-cassandra-2-1) describes best practices of using the built-in caching mechanisms and designing an effective data model. Some tips for efficient cache use are:

-   Store lower-demand data or data with extremely long partitions in a table with minimal or no caching.
-   Deploy a large number of Cassandra nodes under a relatively light load per node.
-   Logically separate heavily-read data into discrete tables.

When you query a table, [turn on tracing](/en/cql-oss/3.3/cql/cql_reference/cqlshTracing.html) to check that the table actually gets data from the cache rather than from disk. The first time you read data from a partition, the trace shows this line below the query because the cache has not been populated yet:

```
Row cache miss [ReadStage:41]
```

In subsequent queries for the same partition, look for a line in the trace that looks something like this:

```
Row cache hit [ReadStage:55]
```

This output means the data was found in the cache and no disk read occurred. Updates invalidate the cache. If you query rows in the cache plus uncached rows, request more rows than the global limit allows, or the query does not grab the beginning of the partition, the trace might include a line that looks something like this:

```
Ignoring row cache as cached value could not satisfy query [ReadStage:89]
```

This output indicates that an insufficient cache caused a disk read. Requesting rows not at the beginning of the partition is a likely cause. Try removing constraints that might cause the query to skip the beginning of the partition, or [place a limit](/en/cql-oss/3.3/cql/cql_reference/cqlSelect.html?#specifying-rows-returned-using-limit) on the query to prevent results from overflowing the cache. To ensure that the query hits the cache, try increasing the cache size limit, or restructure the table to position frequently accessed rows at the head of the partition.

**Parent topic:** [Configuring data caches](../../cassandra/operations/opsConfiguringCaches.md)

