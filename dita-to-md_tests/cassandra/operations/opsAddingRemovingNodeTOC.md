# Adding or removing nodes, datacenters, or clusters {#opsAddingRemovingNodeTOC}

Topics for adding or removing nodes, datacenters, or clusters.

-   **[Adding nodes to an existing cluster](../../cassandra/operations/opsAddNodeToCluster.md)**  
Steps to add nodes when using virtual nodes.
-   **[Adding a datacenter to a cluster](../../cassandra/operations/opsAddDCToCluster.md)**  
Steps for adding a datacenter to an existing cluster.
-   **[Replacing a dead node or dead seed node](../../cassandra/operations/opsReplaceNode.md)**  
Steps to replace a node that has died for some reason, such as hardware failure.
-   **[Replacing a running node](../../cassandra/operations/opsReplaceLiveNode.md#)**  
Two methods for replacing a node with a new node, such as when updating to newer hardware or performing proactive maintenance.
-   **[Moving a node from one rack to another](../../cassandra/operations/opsMoveNodeRack.md)**  

-   **[Decommissioning a datacenter](../../cassandra/operations/opsDecomissionDC.md)**  
Steps to properly remove a datacenter so no information is lost.
-   **[Removing a node](../../cassandra/operations/opsRemoveNode.md)**  
Reduce the size of a datacenter.
-   **[Switching snitches](../../cassandra/operations/opsSwitchSnitch.md)**  
Steps for switching snitches.
-   **[Changing keyspace replication strategy](../../cassandra/operations/opsChangeKSStrategy.md)**  
Changing the strategy of a keyspace from SimpleStrategy to NetworkTopologyStrategy.
-   **[Edge cases for transitioning or migrating a cluster](../../cassandra/operations/opsMoveCluster.md)**  
Unusual migration scenarios without interruption of service.
-   **[Adding single-token nodes to a cluster](../../cassandra/operations/opsAddRplSingleTokenNodes.md)**  
Steps for adding nodes in single-token architecture clusters, not vnodes.
-   **[Adding a datacenter to a single-token architecture cluster](../../cassandra/operations/opsAddDCSingleTokenNodes.md)**  
Steps for adding a datacenter to single-token architecture clusters, not vnodes.
-   **[Replacing a dead node in a single-architecture cluster](../../cassandra/operations/opsReplaceSingleTokenNode.md)**  
Steps for replacing nodes in single-token architecture clusters, not vnodes.

**Parent topic:** [Operations](../../cassandra/operations/operationsTOC.md)

