# How is data updated? {#dmlWriteUpdate .concept}

A brief description of how Cassandra updates data.

Cassandra treats each new row as an [upsert](/en/glossary/doc/glossary/gloss_upsert.html): if the new row has the same primary key as that of an existing row, Cassandra processes it as an update to the existing row.

During a [write](dmlHowDataWritten.md), Cassandra adds each new row to the database without checking on whether a duplicate record exists. This policy makes it possible that many versions of the same row may exist in the database. For more details about writes, see [How is data written?](dmlHowDataWritten.md)

Periodically, the rows stored in memory are streamed to disk into structures called SSTables. At certain intervals, Cassandra [compacts](dmlHowDataMaintain.md#dml-compaction) smaller SSTables into larger SSTables. If Cassandra encounters two or more versions of the same row during this process, Cassandra only writes the most recent version to the new SSTable. After compaction, Cassandra drops the original SSTables, deleting the outdated rows.

Most Cassandra installations store replicas of each row on two or more nodes. Each node performs compaction independently. This means that even though out-of-date versions of a row have been dropped from one node, they may still exist on another node.

This is why Cassandra performs another round of comparisons during a [read process](dmlAboutReads.md). When a client requests data with a particular primary key, Cassandra retrieves many versions of the row from one or more replicas. The version with the most recent timestamp is the only one returned to the client \("last-write-wins"\).

**Note:** Some database operations may only write partial updates of a row, so some versions of a row may include some columns, but not all. During a compaction or write, Cassandra assembles a complete version of each row from the partial updates, using the most recent version of each column.

**Parent topic:** [How Cassandra reads and writes data](../../cassandra/dml/dmlIntro.md)

