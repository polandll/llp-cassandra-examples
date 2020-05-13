# Data distribution and replication {#archDataDistributeAbout .concept}

How data is distributed and factors influencing replication.

In Cassandra, data distribution and replication go together. Data is organized by table and identified by a primary key, which determines which node the data is stored on. Replicas are copies of rows. When data is first written, it is also referred to as a replica.

Factors influencing replication include:

-   [Virtual nodes](archDataDistributeVnodesUsing.md): assigns data ownership to physical machines.
-   [Partitioner](archPartitionerAbout.md): partitions the data across the cluster.
-   [Replication strategy](archDataDistributeReplication.md): determines the replicas for each row of data.
-   [Snitch](archSnitchesAbout.md): defines the topology information that the replication strategy uses to place replicas.

-   **[Consistent hashing](../../cassandra/architecture/archDataDistributeHashing.md)**  
Consistent hashing allows distribution of data across a cluster to minimize reorganization when nodes are added or removed.
-   **[Virtual nodes](../../cassandra/architecture/archDataDistributeVnodesUsing.md)**  
Overview of virtual nodes \(vnodes\).
-   **[Data replication](../../cassandra/architecture/archDataDistributeReplication.md)**  
Cassandra stores replicas on multiple nodes to ensure reliability and fault tolerance. A replication strategy determines the nodes where replicas are placed.

**Parent topic:** [Understanding the architecture](../../cassandra/architecture/archTOC.md)

