# Replacing a running node {#opsReplaceLiveNode .task}

Two methods for replacing a node with a new node, such as when updating to newer hardware or performing proactive maintenance.

Steps to replace a node with a new node, such as when updating to newer hardware or performing proactive maintenance.

You can replace a running node in two ways:

-   [Adding a node and then decommissioning the old node](opsReplaceLiveNode.md#add-replace)
-   [Using nodetool to replace a running node](opsReplaceLiveNode.md#)

**Note:** To change the IP address of a node, simply change the IP of node and then restart Cassandra. If you change the IP address of a seed node, you must update the -seeds parameter in the [seed\_provider](../configuration/configCassandra_yaml.md#seed_provider) list in each node's cassandra.yaml file.

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

## Adding a node and then decommissioning the old node {#add-replace .section}

You must prepare and start the replacement node, integrate it into the cluster, and then decommission the old node.

1.  Be sure to use the same version of Cassandra on all nodes in the cluster.
2.  Prepare and start the replacement node, as described in [Adding nodes to an existing cluster](opsAddNodeToCluster.md).

    **Note:** If not using vnodes, see [Adding single-token nodes to a cluster](opsAddRplSingleTokenNodes.md).

3.  Confirm that the replacement node is alive:

    -   Run [nodetool ring](../tools/toolsRing.md) if not using vnodes.
    -   Run [nodetool status](../tools/toolsStatus.md) if using vnodes.
    The status should show:

    -   nodetool ring: Up
    -   nodetool status: UN
4.  Note the Host ID of the original node; it is used in the next step.

5.  Using the Host ID of the original node, decommission the original node from the cluster using the [nodetool decommission](../tools/toolsDecommission.md) command.

6.  Run [nodetool cleanup](../tools/toolsCleanup.md) on all the other nodes in the same datacenter.


**Parent topic:** [Adding or removing nodes, datacenters, or clusters](../../cassandra/operations/opsAddingRemovingNodeTOC.md)

## Using nodetool to replace a running node {#opsReplaceLiveNodeAlternate}

This method allows you to replace a running node while avoiding streaming the data twice or running cleanup.

CAUTION:

If using a consistency level of ONE, you risk losing data because the node might contain the only copy of a record. Be absolutely sure that no application uses consistency level ONE.

1.  [Stop Cassandra](../initialize/referenceStartStopTOC.md) on the node to be replaced.

2.  Follow the [instructions for replacing a dead node](opsReplaceNode.md) using the old node’s IP address for `-Dcassandra.replace_address`.

3.  Ensure that [consistency level](/en/cql-oss/3.3/cql/cql_reference/cqlshConsistency.html) ONE is not used on this node.


**Related information**  


[Removing a node](opsRemoveNode.md)

