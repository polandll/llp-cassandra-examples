# Adding nodes to an existing cluster {#opsAddNodeToCluster .task}

Steps to add nodes when using virtual nodes.

Virtual nodes \(vnodes\) greatly simplify adding nodes to an existing cluster:

-   Calculating tokens and assigning them to each node is no longer required.
-   Rebalancing a cluster is no longer necessary because a node joining the cluster assumes responsibility for an even portion of the data.

For a detailed explanation about how vnodes work, see [Virtual nodes](../architecture/archDataDistributeVnodesUsing.md).

**Note:** If you do not use vnodes, see [Adding single-token nodes to a cluster](opsAddRplSingleTokenNodes.md).

1.  Be sure to use the same version of Cassandra on all nodes in the cluster.
2.  Install Cassandra on the new nodes, but do not start Cassandra.

    If your Cassandra installation on Debian installation starts automatically, you must [stop](../initialize/referenceStartCservice.md) the node and [clear](../initialize/referenceClearCpkgData.md) the data.

3.  Depending on the snitch used in the cluster, set either the properties in the cassandra-topology.properties or the cassandra-rackdc.properties file:

    -   The [PropertyFileSnitch](../architecture/archSnitchPFSnitch.md) uses the cassandra-topology.properties file.
    -   The [GossipingPropertyFileSnitch](../architecture/archsnitchGossipPF.md), [Ec2Snitch](../architecture/archSnitchEC2.md), [Ec2MultiRegionSnitch](../architecture/archSnitchEC2MultiRegion.md), and [GoogleCloudSnitch](../architecture/archSnitchGoogle.md) use the cassandra-rackdc.properties file.
    The location of the cassandra-topology.properties file depends on the type of installation:

        |Package installations|/etc/cassandra/cassandra-topology.properties|
    |Tarball installations|install\_location/conf/cassandra-topology.properties|

    The location of the cassandra-rackdc.properties file depends on the type of installation:

        |Package installations|/etc/cassandra/cassandra-rackdc.properties|
    |Tarball installations|install\_location/conf/cassandra-rackdc.properties|

4.  Set the following properties in the cassandra.yaml file:

     [auto\_bootstrap](../configuration/configCassandra_yaml.md#auto_bootstrap)
     :   If this option has been set to false, you must set it to true. This option is not listed in the default cassandra.yaml configuration file and defaults to true.

      [cluster\_name](../configuration/configCassandra_yaml.md#cluster_name)
     :   The name of the cluster the new node is joining.

      [listen\_address](../configuration/configCassandra_yaml.md#listen_address)/[broadcast\_address](../configuration/configCassandra_yaml.md#broadcast_address)
     :   Can usually be left blank. Otherwise, use IP address or host name that other Cassandra nodes use to connect to the new node.

      [endpoint\_snitch](../architecture/archSnitchesAbout.md)
     :   The snitch Cassandra uses for locating nodes and routing requests.

      [num\_tokens](../configuration/configCassandra_yaml.md#num_tokens)
     :   The number of vnodes to assign to the node. If the hardware capabilities vary among the nodes in your cluster, you can assign a proportional number of vnodes to the larger machines.

      [seed\_provider](../configuration/configCassandra_yaml.md#seed_provider)
     :   Make sure that the new node lists at least one node in the existing cluster. The -seeds list determines which nodes the new node should contact to learn about the cluster and establish the gossip process.

        **Note:** Seed nodes cannot [bootstrap](/en/glossary/doc/glossary/gloss_bootstrap.html). Make sure the new node is not listed in the -seeds list. **Do not make all nodes seed nodes.** Please read [Internode communications \(gossip\)](../architecture/archGossipAbout.md).

      Other non-default settings
     :   Change any other non-default settings you have made to your existing cluster in the cassandra.yaml file and cassandra-topology.properties or cassandra-rackdc.properties files. Use the diff command to find and merge any differences between existing and new nodes.

     The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

        |Package installations|/etc/cassandra/cassandra.yaml|
    |Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

5.  Start the bootstrap node.

6.  Use [nodetool status](../tools/toolsStatus.md) to verify that the node is fully bootstrapped and all other nodes are up \(UN\) and not in any other state.

7.  After all new nodes are running, run [nodetool cleanup](../tools/toolsCleanup.md) on each of the previously existing nodes to remove the keys that no longer belong to those nodes. Wait for cleanup to complete on one node before running nodetool cleanup on the next node.

    Cleanup can be safely postponed for low-usage hours.


**Parent topic:** [Adding or removing nodes, datacenters, or clusters](../../cassandra/operations/opsAddingRemovingNodeTOC.md)

**Related information**  


[Starting Cassandra as a service](../initialize/referenceStartCservice.md)

[Starting Cassandra as a stand-alone process](../initialize/referenceStartCprocess.md)

[The nodetool utility](../tools/toolsNodetool.md)

[Install locations](../install/installLocationsTOC.md)

