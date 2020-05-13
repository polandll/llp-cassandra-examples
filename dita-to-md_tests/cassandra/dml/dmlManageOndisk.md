# Storage engine {#dmlManageOndisk .concept}

A description about Cassandra's storage structure and engine.

Cassandra uses a storage structure similar to a [Log-Structured Merge Tree](https://en.wikipedia.org/wiki/Log-structured_merge-tree), unlike a typical relational database that uses a [B-Tree](https://en.wikipedia.org/wiki/B-tree). Cassandra avoids reading before writing. Read-before-write, especially in a large distributed system, can result in large latencies in read performance and other problems. For example, two clients read at the same time; one overwrites the row to make update A, and the other overwrites the row to make update B, removing update A. This race condition will result in ambiguous query results - which update is correct?

To avoid using read-before-write for most writes in Cassandra, the storage engine groups inserts and updates in memory, and at intervals, sequentially writes the data to disk in append mode. Once written to disk, the data is immutable and is never overwritten. Reading data involves combining this immutable sequentially-written data to discover the correct query results. You can use [Lightweight transactions \(LWT\)](dmlLtwtTransactions.md) to check the state of the data before writing. However, this feature is recommended only for limited use.

A log-structured engine that avoids overwrites and uses sequential I/O to update data is essential for writing to solid-state disks \(SSD\) and hard disks \(HDD\). On HDD, writing randomly involves a higher number of seek operations than sequential writing. The seek penalty incurred can be substantial. Because Cassandra sequentially writes immutable files, thereby avoiding [write amplification](http://en.wikipedia.org/wiki/Write_amplification) and disk failure, the database accommodates inexpensive, consumer SSDs extremely well. For many other databases, write amplification is a problem on SSDs.

**Parent topic:** [Database internals](../../cassandra/dml/dmlDatabaseInternalsTOC.md)

