# How is the consistency level configured? {#dmlConfigConsistency .concept}

Consistency levels in Cassandra can be configured to manage availability versus data accuracy.

Consistency levels in Cassandra can be configured to manage availability versus data accuracy. You can configure consistency on a cluster, datacenter, or per individual read or write operation. Consistency among participating nodes can be set globally and also controlled on a per-operation basis. Within `cqlsh`, use [`CONSISTENCY`](/en/cql-oss/3.3/cql/cql_reference/cqlshConsistency.html), to set the consistency level for all queries in the current `cqlsh` session. For programming client applications, set the consistency level using an appropriate driver. For example, using the Java driver, call `QueryBuilder.insertInto` with `setConsistencyLevel` to set a per-insert consistency level.

The consistency level defaults to `ONE` for all write and read operations.

## Write consistency levels {#dml-config-write-consistency .section}

This table describes the write consistency levels in strongest-to-weakest order.

|Level|Description|Usage|
|-----|-----------|-----|
|`ALL`|A write must be written to the[commit log and memtable](dmlHowDataWritten.md#logging-writes-and-memtable-storage) on all replica nodes in the cluster for that partition.|Provides the highest consistency and the lowest availability of any other level.|
|`EACH_QUORUM`|Strong consistency. A write must be written to the [commit log and memtable](dmlHowDataWritten.md#logging-writes-and-memtable-storage) on a quorum of replica nodes in *each* [datacenter](/en/glossary/doc/glossary/gloss_data_center.html).|Used in multiple datacenter clusters to strictly maintain consistency at the same level in each datacenter. For example, choose this level if you want a read to fail when a datacenter is down and the `QUORUM` cannot be reached on that datacenter.|
|`QUORUM`|A write must be written to the [commit log and memtable](dmlHowDataWritten.md#logging-writes-and-memtable-storage) on a quorum of replica nodes across *all* datacenters.|Used in either single or multiple datacenter clusters to maintain strong consistency across the cluster. Use if you can tolerate some level of failure.|
|`LOCAL_QUORUM`|Strong consistency. A write must be written to the [commit log and memtable](dmlHowDataWritten.md#logging-writes-and-memtable-storage) on a quorum of replica nodes in the same datacenter as the [coordinator](/en/glossary/doc/glossary/gloss_coordinator_node.html). Avoids latency of inter-datacenter communication.|Used in multiple datacenter clusters with a rack-aware replica placement strategy, such as [NetworkTopologyStrategy](../architecture/archDataDistributeReplication.md), and a properly configured snitch. Use to maintain consistency locally \(within the single datacenter\). Can be used with[SimpleStrategy](../architecture/archDataDistributeReplication.md#rep-strategy-ul).|
|`ONE`|A write must be written to the [commit log and memtable](dmlHowDataWritten.md#logging-writes-and-memtable-storage) of at least one replica node.|Satisfies the needs of most users because consistency requirements are not stringent.|
|`TWO`|A write must be written to the [commit log and memtable](dmlHowDataWritten.md#logging-writes-and-memtable-storage) of at least two replica nodes.|Similar to `ONE`.|
|`THREE`|A write must be written to the [commit log and memtable](dmlHowDataWritten.md#logging-writes-and-memtable-storage) of at least three replica nodes.|Similar to `TWO`.|
|`LOCAL_ONE`|A write must be sent to, and successfully acknowledged by, at least one replica node in the local datacenter.|In a multiple datacenter clusters, a consistency level of `ONE` is often desirable, but cross-DC traffic is not. `LOCAL_ONE` accomplishes this. For security and quality reasons, you can use this consistency level in an offline datacenter to prevent automatic connection to online nodes in other datacenters if an offline node goes down.|
|`ANY`|A write must be written to at least one node. If all replica nodes for the given partition key are down, the write can still succeed after a [hinted handoff](../operations/opsRepairNodesHintedHandoff.md) has been written. If all replica nodes are down at write time, an `ANY` write is not readable until the replica nodes for that partition have recovered.|Provides low latency and a guarantee that a write never fails. Delivers the lowest consistency and highest availability.|

## Read consistency levels {#dml-config-read-consistency .section}

This table describes read consistency levels in strongest-to-weakest order.

|Level|Description|Usage|
|-----|-----------|-----|
|`ALL`|Returns the record after all replicas have responded. The read operation will fail if a replica does not respond.|Provides the highest consistency of all levels and the lowest availability of all levels.|
|`EACH_QUORUM`|Not supported for reads.|
|`QUORUM`|Returns the record after a quorum of replicas from all [datacenters](/en/glossary/doc/glossary/gloss_data_center.html) has responded.|Used in either single or multiple datacenter clusters to maintain strong consistency across the cluster. Ensures strong consistency if you can tolerate some level of failure.|
|`LOCAL_QUORUM`|Returns the record after a quorum of replicas in the current datacenter as the [coordinator](/en/glossary/doc/glossary/gloss_coordinator_node.html) has reported. Avoids latency of inter-datacenter communication.|Used in multiple datacenter clusters with a rack-aware replica placement strategy \( `NetworkTopologyStrategy`\) and a properly configured snitch. Fails when using `SimpleStrategy`.|
|`ONE`|Returns a response from the closest replica, as determined by the [snitch](../architecture/archSnitchesAbout.md). By default, a [read repair](/en/glossary/doc/glossary/gloss_read_repair.html) runs in the background to make the other replicas consistent.|Provides the highest availability of all the levels if you can tolerate a comparatively high probability of stale data being read. The replicas contacted for reads may not always have the most recent write.|
|`TWO`|Returns the most recent data from two of the closest replicas.|Similar to `ONE`.|
|`THREE`|Returns the most recent data from three of the closest replicas.|Similar to `TWO`.|
|`LOCAL_ONE`|Returns a response from the closest replica in the local datacenter.|Same usage as described in the table about write consistency levels.|
|`SERIAL`|Allows reading the current \(and possibly [uncommitted](dmlHowDataWritten.md#logging-writes-and-memtable-storage)\) state of data without proposing a new addition or update. If a `SERIAL` read finds an uncommitted transaction in progress, it will commit the transaction as part of the read. Similar to QUORUM.|To read the latest value of a column after a user has invoked a [lightweight transaction](dmlLtwtTransactions.md) to write to the column, use `SERIAL`. Cassandra then checks the inflight lightweight transaction for updates and, if found, returns the latest data.|
|`LOCAL_SERIAL`|Same as `SERIAL`, but confined to the datacenter. Similar to LOCAL\_QUORUM.|Used to achieve [linearizable consistency](dmlAboutDataConsistency.md#linearizable-consistency) for lightweight transactions.|

## How QUORUM is calculated {#about-the-quorum-level .section}

The `QUORUM` level writes to the number of nodes that make up a quorum. A quorum is calculated, and then rounded down to a whole number, as follows:

```no-highlight
quorum = (sum_of_replication_factors / 2) + 1
```

The sum of all the `replication_factor` settings for each datacenter is the `sum_of_replication_factors`.

```no-highlight
sum_of_replication_factors = datacenter1_RF + datacenter2_RF + . . . + datacenter*n*_RF
```

Examples:

-   Using a replication factor of 3, a quorum is 2 nodes. The cluster can tolerate 1 replica down.
-   Using a replication factor of 6, a quorum is 4. The cluster can tolerate 2 replicas down.
-   In a two datacenter cluster where each datacenter has a replication factor of 3, a quorum is 4 nodes. The cluster can tolerate 2 replica nodes down.
-   In a five datacenter cluster where two datacenters have a replication factor of 3 and three datacenters have a replication factor of 2, a quorum is 7 nodes.

The more datacenters, the higher number of replica nodes need to respond for a successful operation.

Similar to `QUORUM`, the `LOCAL_QUORUM` level is calculated based on the replication factor of the same datacenter as the coordinator node. That is, even if the cluster has more than one datacenter, the quorum is calculated only with local replica nodes.

In `EACH_QUORUM`, every datacenter in the cluster must reach a quorum based on that datacenter's replication factor in order for the read or write request to succeed. That is, for every datacenter in the cluster a quorum of replica nodes must respond to the coordinator node in order for the read or write request to succeed.

## Configuring client consistency levels {#configuring-client-consistency-levels .section}

You can use a `cqlsh` command, [`CONSISTENCY`](/en/cql-oss/3.3/cql/cql_reference/cqlshConsistency.html), to set the consistency level for queries in the current `cqlsh` session. For programming client applications, set the consistency level using an appropriate driver. For example, call `QueryBuilder.insertInto` with a `setConsistencyLevel` argument using the Java driver.

**Parent topic:** [Data consistency](../../cassandra/dml/dmlDataConsistencyTOC.md)

