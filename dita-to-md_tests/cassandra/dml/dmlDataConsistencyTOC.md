# Data consistency {#dmlDataConsistencyTOC}

Topics about how up-to-date and synchronized a row of data is on all replicas.

-   **[How are consistent read and write operations handled?](../../cassandra/dml/dmlAboutDataConsistency.md)**  
An introduction to how Cassandra extends eventual consistency with tunable consistency to vary the consistency of data read and written.
-   **[How are Cassandra transactions different from RDBMS transactions?](../../cassandra/dml/dmlTransactionsDiffer.md)**  

-   **[How do I accomplish lightweight transactions with linearizable consistency?](../../cassandra/dml/dmlLtwtTransactions.md)**  
A description about lightweight transactions and when to use them.
-   **[How do I discover consistency level performance?](../../cassandra/dml/dmlCLDiscovery.md)**  
 Use tracing to discover what the consistency level is currently set to, and how it affects performance.
-   **[How is the consistency level configured?](../../cassandra/dml/dmlConfigConsistency.md)**  
Consistency levels in Cassandra can be configured to manage availability versus data accuracy.
-   **[How is the serial consistency level configured?](../../cassandra/dml/dmlConfigSerialConsistency.md)**  
Serial consistency levels in Cassandra can be configured to manage lightweight transaction isolation.
-   **[How are read requests accomplished?](../../cassandra/dml/dmlClientRequestsRead.md)**  
The three types of read requests that a coordinator node can send to a replica.
-   **[How are write requests accomplished?](../../cassandra/dml/dmlClientRequestsWrite.md)**  
How write requests work.

**Parent topic:** [Database internals](../../cassandra/dml/dmlDatabaseInternalsTOC.md)

