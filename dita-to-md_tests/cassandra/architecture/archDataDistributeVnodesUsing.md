# Virtual nodes {#archDataDistributeVnodesUsing .concept}

Overview of virtual nodes \(vnodes\).

Virtual nodes, known as Vnodes, distribute data across nodes at a finer granularity than can be easily achieved if calculated tokens are used. Vnodes simplify many tasks in Cassandra:

-   Tokens are automatically calculated and assigned to each node.
-   Rebalancing a cluster is automatically accomplished when adding or removing nodes. When a node joins the cluster, it assumes responsibility for an even portion of data from the other nodes in the cluster. If a node fails, the load is spread evenly across other nodes in the cluster.
-   Rebuilding a dead node is faster because it involves every other node in the cluster.
-   The proportion of vnodes assigned to each machine in a cluster can be assigned, so smaller and larger computers can be used in building a cluster.

**Note:** DataStax recommends using **8** vnodes \(tokens\). Using 8 vnodes distributes the workload between systems with a ~10% variance and has minimal impact on performance.

For more information, see the article [Virtual nodes in Cassandra 1.2](https://www.datastax.com/blog/2012/12/virtual-nodes-cassandra-12). To convert an existing cluster to vnodes, see [Enabling virtual nodes on an existing production cluster](../configuration/configVnodesProduction.md).

-   **[How data is distributed across a cluster \(using virtual nodes\)](../../cassandra/architecture/archDataDistributeDistribute.md)**  
Vnodes use consistent hashing to distribute data without requiring new token generation and assignment.

**Parent topic:** [Data distribution and replication](../../cassandra/architecture/archDataDistributeAbout.md)

