# Data replication {#archDataDistributeReplication .concept}

Cassandra stores replicas on multiple nodes to ensure reliability and fault tolerance. A replication strategy determines the nodes where replicas are placed.

Cassandra stores replicas on multiple nodes to ensure reliability and fault tolerance. A replication strategy determines the nodes where replicas are placed. The total number of replicas across the cluster is referred to as the replication factor. A replication factor of 1 means that there is only one copy of each row in the cluster. If the node containing the row goes down, the row cannot be retrieved. A replication factor of 2 means two copies of each row, where each copy is on a different node. All replicas are equally important; there is no primary or master replica. As a general rule, the replication factor should not exceed the number of nodes in the cluster. However, you can increase the replication factor and then add the desired number of nodes later.

Two replication strategies are available:

-   `SimpleStrategy`: Use only for a single [datacenter](/en/glossary/doc/glossary/gloss_data_center.html) and one rack. If you ever intend more than one datacenter, use the `NetworkTopologyStrategy`.
-   `NetworkTopologyStrategy`: Highly recommended for most deployments because it is much easier to expand to multiple datacenters when required by future expansion.

 SimpleStrategy
 :   Use only for a single datacenter and one rack. `SimpleStrategy` places the first replica on a node determined by the partitioner. Additional replicas are placed on the next nodes clockwise in the ring without considering topology \(rack or datacenter location\).

  NetworkTopologyStrategy
 :   Use `NetworkTopologyStrategy` when you have \(or plan to have\) your cluster deployed across multiple datacenters. This strategy specifies how many replicas you want in each datacenter.

    `NetworkTopologyStrategy` places replicas in the same datacenter by walking the ring clockwise until reaching the first node in another rack. `NetworkTopologyStrategy` attempts to place replicas on distinct racks because nodes in the same rack \(or similar physical grouping\) often fail at the same time due to power, cooling, or network issues.

    When deciding how many replicas to configure in each datacenter, the two primary considerations are \(1\) being able to satisfy reads locally, without incurring cross data-center latency, and \(2\) failure scenarios. The two most common ways to configure multiple datacenter clusters are:

    -   Two replicas in each datacenter: This configuration tolerates the failure of a single node per replication group and still allows local reads at a consistency level of `ONE`.
    -   Three replicas in each datacenter: This configuration tolerates either the failure of one node per replication group at a strong consistency level of `LOCAL_QUORUM` or multiple node failures per datacenter using consistency level `ONE`.

    Asymmetrical replication groupings are also possible. For example, you can have three replicas in one datacenter to serve real-time application requests and use a single replica elsewhere for running analytics.

 Replication strategy is defined per keyspace, and is set during keyspace creation. To set up a keyspace, see [creating a keyspace](/en/cql-oss/3.3/cql/cql_using/useCreateKeyspace.html).

For more about replication strategy options, see [Changing keyspace replication strategy](../operations/opsChangeKSStrategy.md).

**Parent topic:** [Data distribution and replication](../../cassandra/architecture/archDataDistributeAbout.md)

