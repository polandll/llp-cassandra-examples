# Batching inserts, updates and deletes {#useBatch .concept}

Batching inserts, updates and deletes.

Batch operations for both single partition and multiple partitions ensure atomicity. An atomic transaction is an indivisible and irreducible series of operations such that either all occur, or nothing occurs. Single partition batch operations are atomic automatically, while multiple partition batch operations require the use of a batchlog to ensure atomicity.

Use batching if atomicity is a primary concern for a group of operations. Single partition batch operations are processed server-side as a single mutation for improved performance, provided the number of operations do not exceed the [maximum size of a single operation](/en/cassandra-oss/3.0/cassandra/configuration/configCassandra_yaml.html#configCassandra_yaml__max_mutation_size_in_kb) or cause the query to time out. Multiple partition batch operations often suffer from performance issues, and should only be used if atomicity must be ensured.

Batching can be effective for single partition write operations. But batches are often mistakenly used in an attempt to optimize performance. Depending on the batch operation, the performance may actually worsen. Some batch operations place a greater burden on the coordinator node and lessen the efficiency of the data insertion. The number of partitions involved in a batch operation, and thus the potential for multi-node accessing, can increase the latency dramatically. In all batching, the coordinator node manages all write operations, so that the coordinator node can pose a bottleneck to completion.

Good reasons for batching operations in Apache Cassandra are:

-   Inserts, updates or deletes to a single partition when atomicity and isolation is a requirement. Atomicity ensures that either all or nothing is written. Isolation ensures that partial insertion or updates are not accessed until all operations are complete.

    Single partition batching will send one message to the coordinator for all operations. All replicas for the single partition receive the data, and the coordinator waits for acknowledgement. No batchlog mechanism is necessary. The number of nodes involved in the batch is bounded by the number of replicas.

-   Ensuring atomicity for small inserts or updates to multiple partitions when inconsistency cannot occur.

    Multiple partition batching will send one message to the coordinator for all operations. The coordinator writes a batchlog that is replicated to other nodes to ensure that inconsistency will not occur if the coordinator fails. Then the coordinator must wait for all nodes with an affected partition to acknowledge the operations before removing the logged batch. The number of nodes involved in the batch is bounded by number of distinct partition keys in the logged batch plus \(possibly\) the batchlog replica nodes. While a batch operation for a small number of partitions may be critical for consistency, this use case is more the exception than the rule.


Poor reasons for batching operations in Apache Cassandra are:

-   Inserting or updating data to multiple partitions, especially when a large number of partitions are involved.

    As stated above, [batching to multiple partitions](useBatchBadExample.md) has performance costs. Unlogged batch operations are possible, to avoid the additional time cost of the batchlog, but the coordinator node will still be a bottleneck the performance due to the synchronous nature. A better alternative uses asynchronous writes using driver code; the token aware loading balancing will distribute the writes to several coordinator nodes, decreasing the time to complete the insert and update operations.


Batched statements can save network round-trips between the client and the server, and possibly between the coordinator and the replicas. However, consider carefully before implementing batch operations, and decide if they are truly necessary. For information about the fastest way to load data, see "[Cassandra: Batch loading without the Batch keyword](https://medium.com/@foundev/cassandra-batch-loading-without-the-batch-keyword-40f00e35e23e)."

**Parent topic:** [Batching data insertion and updates](../../cql/cql_using/useBatchTOC.md)

