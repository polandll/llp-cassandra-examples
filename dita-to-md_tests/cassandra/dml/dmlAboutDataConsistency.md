# How are consistent read and write operations handled? {#dmlAboutDataConsistency .concept}

An introduction to how Cassandra extends eventual consistency with tunable consistency to vary the consistency of data read and written.

Consistency refers to how up-to-date and synchronized all replicas of a row of Cassandra data are at any given moment. Ongoing [repair operations](../operations/opsRepairNodesTOC.md) in Cassandra ensure that all replicas of a row will eventually be consistent. Repairs work to decrease the variability in replica data, but constant data traffic through a widely distributed system can lead to inconsistency \(stale data\) at any given time. Cassandra is a AP system according to the [CAP theorem](https://en.wikipedia.org/wiki/CAP_theorem), providing high availability and partition tolerance. Cassandra does have flexibility in its configuration, though, and can perform more like a CP \(consistent and partition tolerant\) system according to the CAP theorem, depending on the application requirements. Two consistency features are tunable consistency and linearizable consistency.

## Tunable consistency {#eventual-consistency .section}

To ensure that Cassandra can provide the proper levels of consistency for its reads and writes, Cassandra extends the concept of [eventual consistency](http://en.wikipedia.org/wiki/Eventual_consistency) by offering tunable consistency. You can tune Cassandra's consistency level per-operation, or set it globally for a cluster or datacenter. You can vary the consistency for individual read or write operations so that the data returned is more or less consistent, as required by the client application. This allows you to make Cassandra act more like a CP \(consistent and partition tolerant\) or AP \(highly available and partition tolerant\) system according to the CAP theorem, depending on the application requirements.

**Note:** It is not possible to "tune" Cassandra into a completely CA system. See [You Can't Sacrifice Partition Tolerance](https://codahale.com/you-cant-sacrifice-partition-tolerance/) for a more detailed discussion.

There is a tradeoff between operation latency and consistency: higher consistency incurs higher latency, lower consistency permits lower latency. You can control latency by tuning consistency.

The consistency level determines the number of replicas that need to acknowledge the read or write operation success to the client application. For read operations, the read consistency level specifies how many replicas must respond to a read request before returning data to the client application. If a read operation reveals inconsistency among replicas, Cassandra initiates a [read repair](../operations/opsRepairNodesReadRepair.md) to update the inconsistent data.

For write operations, the write consistency level specified how many replicas must respond to a write request before the write is considered successful. Even at low consistency levels, Cassandra writes to all replicas of the partition key, including replicas in other datacenters. The write consistency level just specifies when the coordinator can report to the client application that the write operation is considered completed. Write operations will use [hinted handoffs](../operations/opsRepairNodesHintedHandoff.md) to ensure the writes are completed when replicas are down or otherwise not responsive to the write request.

Typically, a client specifies a consistency level that is less than the replication factor specified by the keyspace. Another common practice is to write at a consistency level of QUORUM and read at a consistency level of QUORUM. The choices made depend on the client application's needs, and Cassandra provides maximum flexibility for application design.

## Linearizable consistency {#linearizable-consistency .section}

In ACID terms, linearizable consistency \(or serial consistency\) is a serial \(immediate\) isolation level for [lightweight transactions](dmlLtwtTransactions.md). Cassandra does not use employ traditional mechanisms like locking or transactional dependencies when concurrently updating multiple rows or tables.

However, some operations must be performed in sequence and not interrupted by other operations. For example, duplications or overwrites in user account creation can have serious consequences. Situations like race conditions \(two clients updating the same record\) can introduce inconsistency across replicas. Writing with high consistency does nothing to reduce this. You can apply linearizable consistency to a unique identifier, like the userID or email address, although is not required for all aspects of the user's account. Serial operations for these elements can be implemented in Cassandra with the Paxos consensus protocol, which uses a quorum-based algorithm. Lightweight transactions can be implemented without the need for a master database or two-phase commit process.

Lightweight transaction write operations use the serial consistency level for Paxos consensus and the regular consistency level for the write to the table. For more information, see [Lightweight Transactions](dmlLtwtTransactions.md).

## Calculating consistency { .section}

Reliability of read and write operations depends on the consistency used to verify the operation. Strong consistency can be guaranteed when the following condition is true:

```
R + W > N
```

where

-   R is the consistency level of read operations
-   W is the consistency level of write operations
-   N is the number of replicas

If the replication factor is 3, then the consistency level of the reads and writes combined must be at least 4. For example, read operations using 2 out of 3 replicas to verify the value, and write operations using 2 out of 3 replicas to verify the value will result in strong consistency. If fast write operations are required, but strong consistency is still desired, the write consistency level is lowered to 1, but now read operations have to verify a matched value on all 3 replicas. Writes will be fast, but reads will be slower.

Eventual consistency occurs if the following condition is true:

```
R + W =< N
```

where

-   R is the consistency level of read operations
-   W is the consistency level of write operations
-   N is the number of replicas

If the replication factor is 3, then the consistency level of the reads and writes combined are 3 or less. For example, read operations using [QUORUM](dmlConfigConsistency.md#about-the-quorum-level) \(2 out of 3 replicas\) to verify the value, and write operations using ONE \(1 out of 3 replicas\) to do fast writes will result in eventual consistency. All replicas will receive the data, but read operations are more vulnerable to selecting data before all replicas write the data.

## Additional consistency examples: { .section}

-   You do a write at ONE, the replica crashes one second later. The other messages are not delivered. The data is lost.
-   You do a write at ONE, and the operation times out. Future reads can return the old or the new value. You will not know the data is incorrect.
-   You do a write at ONE, and one of the other replicas is down. The node comes back online. The application will get old data from that node until the node gets the correct data or a read repair occurs.
-   You do a write at QUORUM, and then a read at QUORUM. One of the replicas dies. You will always get the correct data.

**Parent topic:** [Data consistency](../../cassandra/dml/dmlDataConsistencyTOC.md)

