# Repairing nodes {#opsRepairNodesTOC}

Node repair topics.

Over time, data in a replica can become inconsistent with other replicas due to the distributed nature of the database. Node repair corrects the inconsistencies so that eventually all nodes have the same and most up-to-date data. It is important part of regular maintenance for every Cassandra cluster.

Cassandra provides the following repair processes:

-   [Hinted Handoff](opsRepairNodesHintedHandoff.md)

    If a node becomes unable to receive a particular write, the write's coordinator node preserves the data to be written as a set of *hints*. When the node comes back online, the coordinator effects repair by handing off hints so that the node can catch up with the required writes.

-   [Read Repair](opsRepairNodesReadRepair.md)

    During the read path, a query assembles data from several nodes. The coordinator node for this write compares the data from each replica node. If any replica node has outdated data, the coordinator node sends it the most recent version. The scope of this type of repair depends on the keyspace's replication factor. During a write, Cassandra collects only enough replica data to satisfy the replication factor, and only performs read repair on nodes that participate in that write operation.

    But Cassandra can also choose a write at random and perform read repair on all replicas, regardless of the replication factor.

-   [Anti-Entropy Repair](opsRepairNodesManualRepair.md)

    Cassandra provides the [nodetool repair](../tools/toolsRepair.md) tool, which you can use to repair recovering nodes, and which you should use as part of regular maintenance purposes.


You can use Cassandra settings or Cassandra tools to configure each type of repair. For details on when to use each type of repair and how to configure each one, see the pages listed above.

-   **[Hinted Handoff: repair during write path](../../cassandra/operations/opsRepairNodesHintedHandoff.md)**  
Describes hinted handoff, repair during write path.
-   **[Read Repair: repair during read path](../../cassandra/operations/opsRepairNodesReadRepair.md)**  
Describes read repair, repair during read path.
-   **[Manual repair: Anti-entropy repair](../../cassandra/operations/opsRepairNodesManualRepair.md)**  
Describe how manual repair works.
-   **[Migrating to incremental repairs](../../cassandra/operations/opsRepairNodesMigration.md)**  
To start using incremental repairs, migrate the SSTables on each node.

**Parent topic:** [Operations](../../cassandra/operations/operationsTOC.md)

