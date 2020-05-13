# Compression {#opsAboutConfigCompress .concept}

Compression maximizes the storage capacity of Cassandra nodes by reducing the volume of data on disk and disk I/O, particularly for read-dominated workloads.

Compression maximizes the storage capacity of Cassandra nodes by reducing the volume of data on disk and disk I/O, particularly for read-dominated workloads. Cassandra quickly finds the location of rows in the SSTable index and decompresses the relevant row chunks. Compression is important for Cassandra 2.2, but Cassandra 3.0 and later uses a new storage engine that dramatically reduces disk volume automatically. For information on the Cassandra 3.0 improvements, see [Putting some structure in the storage engine](https://www.datastax.com/2015/12/storage-engine-30)

Write performance is not negatively impacted by compression in Cassandra as it is in traditional databases. In traditional relational databases, writes require overwrites to existing data files on disk. The database has to locate the relevant pages on disk, decompress them, overwrite the relevant data, and finally recompress. In a relational database, compression is an expensive operation in terms of CPU cycles and disk I/O. Because Cassandra SSTable data files are immutable \(they are not written to again after they have been flushed to disk\), there is no recompression cycle necessary in order to process writes. SSTables are compressed only once when they are written to disk. Writes on compressed tables can show up to a 10 percent performance improvement.

In Cassandra 2.2 and later, the commit log can also be compressed and write performance can be improved 6-12%. For more information, see [Updates to Cassandra’s Commit Log in 2.2](https://www.datastax.com/dev/blog/updates-to-cassandras-commit-log-in-2-2).

-   **[When to compress data](../../cassandra/operations/opsWhenCompress.md)**  
Compression is best suited for tables that have many rows and each row has the same columns, or at least as many columns, as other rows.
-   **[Configuring compression](../../cassandra/operations/opsConfigCompress.md)**  
Steps for configuring compression.

**Parent topic:** [Operations](../../cassandra/operations/operationsTOC.md)

