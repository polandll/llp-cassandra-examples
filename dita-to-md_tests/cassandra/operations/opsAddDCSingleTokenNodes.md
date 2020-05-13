# Adding a datacenter to a single-token architecture cluster {#opsAddDCSingleTokenNodes .task}

Steps for adding a datacenter to single-token architecture clusters, not vnodes.

Steps for adding a datacenter to single-token architecture clusters, not vnodes.

1.  Ensure that you are using [NetworkTopologyStrategy](../dml/dmlConfigConsistency.md) for all keyspaces.

2.  For each new node, edit the configuration properties in the cassandra.yaml file:

    -   Set `auto_bootstrap` to `False`.
    -   Set the `initial_token`. Be sure to offset the tokens in the new datacenter, see [Generating tokens](../configuration/configGenTokens.md).
    -   Set the `cluster name`.
    -   Set any other non-default settings.
    -   Set the [seed lists](../configuration/configCassandra_yaml.md#seed_provider). Every node in the cluster must have the same list of seeds and include at least one node from each datacenter. Typically one to three seeds are used per datacenter.
3.  Update either the properties file on all nodes to include the new nodes. You do not need to restart.

    -   GossipingPropertyFileSnitch: cassandra-rackdc.properties
    -   PropertyFileSnitch: cassandra-topology.properties
4.  Ensure that your client does not auto-detect the new nodes so that they aren't contacted by the client until explicitly directed.

5.  If using a QUORUM [consistency level](../dml/dmlConfigConsistency.md) for reads or writes, check the LOCAL\_QUORUM or EACH\_QUORUM consistency level to make sure that the level meets the requirements for multiple datacenters.

6.  [Start the new nodes](../initialize/referenceStartCservice.md).

7.  The `GossipingPropertyFileSnitch` always loads cassandra-topology.properties when that file is present. Remove the file from each node on any new cluster or any cluster migrated from the `PropertyFileSnitch`.

8.  After all nodes are running in the cluster:

    1.  Change the [replication factor](/en/cql-oss/3.3/cql/cql_reference/cqlAlterKeyspace.html) for your keyspace for the expanded cluster.

    2.  Run [nodetool rebuild](../tools/toolsRebuild.md) on each node in the new datacenter.

    The location of the cassandra-rackdc.properties file depends on the type of installation:

        |Package installations|/etc/cassandra/cassandra-rackdc.properties|
    |Tarball installations|install\_location/conf/cassandra-rackdc.properties|

    The location of the cassandra-topology.properties file depends on the type of installation:

        |Package installations|/etc/cassandra/cassandra-topology.properties|
    |Tarball installations|install\_location/conf/cassandra-topology.properties|

    The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

        |Package installations|/etc/cassandra/cassandra.yaml|
    |Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|


**Parent topic:** [Adding or removing nodes, datacenters, or clusters](../../cassandra/operations/opsAddingRemovingNodeTOC.md)

