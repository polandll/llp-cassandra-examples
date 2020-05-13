# CQL limits {#refLimits .concept}

Upper CQL limits.

Observe the following upper limits:

-   Cells in a partition: ~2 billion \(231\); single column value size: 2 GB \( 1 MB is recommended\)
-   Clustering column value, length of: 65535 \(216-1\)
-   Key length: 65535 \(216-1\)
-   Table / CF name length: 48 characters
-   Keyspace name length: 48 characters
-   Query parameters in a query: 65535 \(216-1\)
-   Statements in a batch: 65535 \(216-1\)
-   Fields in a tuple: 32768 \(215\) \(just a few fields, such as 2-10, are recommended\)
-   Collection \(List\): collection limit: ~2 billion \(231\); values size: 65535 \(216-1\) \(Cassandra 2.1 and later, using native protocol v3\)
-   Collection \(Set\): collection limit: ~2 billion \(231\); values size: 65535 \(216-1\) \(Cassandra 2.1 and later, using native protocol v3\)
-   Collection \(Map\): collection limit: ~2 billion \(231\); number of keys: 65535 \(216-1\); values size: 65535 \(216-1\) \(Cassandra 2.1 and later, using native protocol v3\)
-   Blob size: 2 GB \( less than 1 MB is recommended\)

**Note:** The limits specified for collections are for non-frozen collections.

**Parent topic:** [CQL reference](../../cql/cql_reference/cqlReferenceTOC.md)

