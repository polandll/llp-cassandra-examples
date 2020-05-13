# How Cassandra reads and writes data {#dmlIntro .concept}

Understanding how Cassandra stores data.

To manage and access data in Cassandra, it is important to understand how Cassandra stores data. The hinted handoff feature plus Cassandra conformance and non-conformance to the ACID \(atomic, consistent, isolated, durable\) database properties are key concepts to understand reads and writes. In Cassandra, consistency refers to how up-to-date and synchronized a row of data is on all of its replicas.

Client utilities and application programming interfaces \(APIs\) for developing applications for data storage and retrieval are [available](/en/developer/driver-matrix/doc/common/driverMatrix.html).

-   **[How is data written?](../../cassandra/dml/dmlHowDataWritten.md)**  
Understand how Cassandra writes and stores data.
-   **[How is data maintained?](../../cassandra/dml/dmlHowDataMaintain.md)**  
Cassandra processes data at several stages on the write path. Compaction to maintain healthy SSTables is the last step in the write path process.
-   **[How is data updated?](../../cassandra/dml/dmlWriteUpdate.md)**  
A brief description of how Cassandra updates data.
-   **[How is data deleted?](../../cassandra/dml/dmlAboutDeletes.md)**  
How Cassandra deletes data and why deleted data can reappear.
-   **[How are indexes stored and updated?](../../cassandra/dml/dmlIndexInternals.md)**  
A brief description of how Cassandra stores and distributes indexes.
-   **[How is data read?](../../cassandra/dml/dmlAboutReads.md)**  
How Cassandra combines results from the active memtable and potentially multiple SSTables to satisfy a read.
-   **[How do write patterns affect reads?](../../cassandra/dml/dmlWritePatterns.md)**  
A brief description about how write patterns affect reads.

**Parent topic:** [Database internals](../../cassandra/dml/dmlDatabaseInternalsTOC.md)

