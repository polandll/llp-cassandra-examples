# When to compress data {#opsWhenCompress .concept}

Compression is best suited for tables that have many rows and each row has the same columns, or at least as many columns, as other rows.

Compression is most effective on a table with many rows, where each row contains the same set of columns \(or the same number of columns\) as all other rows. For example, a table containing user data such as username, email and state is a good candidate for compression. The greater the similarity of the data across rows, the greater the compression ratio and gain in read performance.

A table whose rows contain differing sets of columns is not well-suited for compression.

Don't confuse table compression with [compact storage](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html) of columns, which is used for backward compatibility of old applications with CQL.

Depending on the data characteristics of the table, compressing its data can result in:

-   25-33% reduction in data size
-   25-35% performance improvement on reads
-   5-10% performance improvement on writes

After configuring compression on an existing table, subsequently created SSTables are compressed. Existing SSTables on disk are not compressed immediately. Cassandra compresses existing SSTables when the normal Cassandra compaction process occurs. Force existing SSTables to be rewritten and compressed by using [nodetool upgradesstables](../tools/toolsUpgradeSstables.md) \(Cassandra 1.0.4 or later\) or [nodetool scrub](../tools/toolsScrub.md).

**Parent topic:** [Compression](../../cassandra/operations/opsAboutConfigCompress.md)

