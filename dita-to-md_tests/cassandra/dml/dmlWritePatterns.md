# How do write patterns affect reads? {#dmlWritePatterns .concept}

A brief description about how write patterns affect reads.

It is important to consider how the write operations will affect the read operations in the cluster. The type of [compaction strategy](dmlHowDataMaintain.md) Cassandra performs on your data is configurable and can significantly affect read performance. Using the SizeTieredCompactionStrategy or DateTieredCompactionStrategy tends to cause data fragmentation when rows are frequently updated. The LeveledCompactionStrategy \(LCS\) was designed to prevent fragmentation under this condition.

**Parent topic:** [How Cassandra reads and writes data](../../cassandra/dml/dmlIntro.md)

