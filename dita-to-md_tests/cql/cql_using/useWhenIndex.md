# When to use an index {#useWhenIndex .concept}

When and when not to use an index.

Cassandra's built-in indexes are best on a table having many rows that contain the indexed value. The more unique values that exist in a particular column, the more overhead you will have, on average, to query and maintain the index. For example, suppose you had a races table with a billion entries for cyclists in hundreds of races and wanted to look up rank by the cyclist. Many cyclists' ranks will share the same column value for race year. The race\_year column is a good candidate for an index.

In Cassandra 3.4 and later, a new implementation of secondary indexes, [SSTable Attached Secondary Indexes \(SASI\)](useSASIIndex.md) is available..

## When *not* to use an index {#when-no-index .section}

Do not use an index in these situations:

-   On high-cardinality columns for a query of a huge volume of records for a small number of results. See [Problems using a high-cardinality column index](useWhenIndex.md#highCardCol) below.
-   In tables that use a counter column.
-   On a frequently updated or deleted column. See [Problems using an index on a frequently updated or deleted column](useWhenIndex.md#upDatIndx) below.
-   To look for a row in a large partition unless narrowly queried. See [Problems using an index to look for a row in a large partition unless narrowly queried](useWhenIndex.md#largCluster) below.

**Problems using a high-cardinality column index**

If you create an index on a high-cardinality column, which has many distinct values, a query between the fields will incur many seeks for very few results. In the table with a billion songs, looking up songs by writer \(a value that is typically unique for each song\) instead of by their artist, is likely to be very inefficient. It would probably be more efficient to manually maintain the table as a form of an index instead of using the Cassandra built-in index. For columns containing unique data, it is sometimes fine performance-wise to use an index for convenience, as long as the query volume to the table having an indexed column is moderate and not under constant load.

Conversely, creating an index on an extremely low-cardinality column, such as a boolean column, does not make sense. Each value in the index becomes a single row in the index, resulting in a huge row for all the false values, for example. Indexing a multitude of indexed columns having foo = true and foo = false is not useful.

**Problems using an index on a frequently updated or deleted column**

Cassandra stores tombstones in the index until the tombstone limit reaches 100K cells. After exceeding the tombstone limit, the query that uses the indexed value will fail.

**Problems using an index to look for a row in a large partition unless narrowly queried**

A query on an indexed column in a large cluster typically requires collating responses from multiple data partitions. The query response slows down as more machines are added to the cluster. You can avoid a performance hit when looking for a row in a large partition by narrowing the search.

**Parent topic:** [Indexing](../../cql/cql_using/usePrimaryIndex.md)

