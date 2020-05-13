# Moving a node from one rack to another {#opsMoveNodeRack}

A common task is moving a node from one rack to another. For example, when using GossipPropertyFileSnitch, a common error is mistakenly placing a node in the wrong rack. To correct the error, use one of the following procedures.

-   The preferred method is to [decommission the node](../tools/toolsDecommission.md) and re-add it to the correct rack and datacenter.
    -   This method takes longer to complete than the alternative method. Data is moved that the decommissioned node doesn't need anymore. Then the node gets new data while bootstrapping. The alternative method does both operations simultaneously.
-   An alternative method is to [update the node's topology](opsSwitchSnitch.md) and restart the node. Once the node is up, run a [full repair](opsRepairNodesManualRepair.md) on the cluster.

    CAUTION:

    This method is not preferred because until the repair is completed, the node may blindly handle requests for data the node doesn't yet have. To mitigate this problem with request handling, start the node with `-Dcassandra.join_ring=false` after repairing once, then fully join the node to the cluster using the [JMX method](opsMonitoring.md) `org.apache.cassandra.db.StorageService.joinRing()`. The node will be less likely to be out of sync with other nodes before it serves any requests. After joining the node to the cluster, repair the node again, so that any writes missed during the first repair will be captured.


**Parent topic:** [Adding or removing nodes, datacenters, or clusters](../../cassandra/operations/opsAddingRemovingNodeTOC.md)

