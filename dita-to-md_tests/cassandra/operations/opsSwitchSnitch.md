# Switching snitches {#opsSwitchSnitch .task}

Steps for switching snitches.

Because [snitches](../architecture/archSnitchesAbout.md) determine how Cassandra distributes replicas, the procedure to switch snitches depends on whether or not the topology of the cluster will change:

-   If data has not been inserted into the cluster, there is no change in the network topology. This means that you only need to set the snitch; no other steps are necessary.
-   If data has been inserted into the cluster, it's possible that the topology has changed and you will need to perform additional steps.
-   If data has been inserted into the cluster that must be kept, change the snitch without changing the topology. Then add a new datacenter with new nodes and racks as desired. Finally, remove nodes from the old datacenters and racks. Simply altering the snitch and replication to move some nodes to a new datacenter will result in data being replicated incorrectly.

A change in topology means that there is a change in the datacenters and/or racks where the nodes are placed. Topology changes may occur when the replicas are placed in different places by the new snitch. Specifically, the replication strategy places the replicas based on the information provided by the new snitch. The following examples demonstrate the differences:

-   **No topology change**

    **Change from**: five nodes using the [SimpleSnitch](../architecture/archSnitchSimple.md) in a single datacenter

    **To**: five nodes in one datacenter and 1 rack using a network snitch such as the [GossipingPropertyFileSnitch](../architecture/archsnitchGossipPF.md)

-   **Topology changes** 
    -   **Change from**: 5 nodes using the SimpleSnitch in a single datacenter

        **To**: 5 nodes in 2 datacenters using the [PropertyFileSnitch](../architecture/archSnitchPFSnitch.md) \(add a datacenter\).

        **Note:** If "splitting" one datacenter into two, [create a new datacenter](opsAddDCToCluster.md) with new nodes. [Alter the keyspace](/en/cql-oss/3.3/cql/cql_reference/cqlAlterKeyspace.html) replication settings for the [keyspace](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#refClstrOrdr__cql-compact-storage) that originally existed to reflect that two datacenters now exist. Once data is replicated to the new datacenter, remove the number of nodes from the original datacenter that have "moved" to the new datacenter.

    -   **Change From**: 5 nodes using the SimpleSnitch in a single datacenter

        **To**: 5 nodes in 1 datacenter and 2 racks using the [RackInferringSnitch](../architecture/archSnitchRackInf.md) \(add rack information\).


1.  Steps for switching snitches:
2.  Create a properties file with datacenter and rack information.

    -   cassandra-rackdc.properties 

        [GossipingPropertyFileSnitch](../architecture/archsnitchGossipPF.md), [Ec2Snitch](../architecture/archSnitchEC2.md), and [Ec2MultiRegionSnitch](../architecture/archSnitchEC2MultiRegion.md) only.

    -   cassandra-topology.properties

        All other network snitches.

3.  Copy the cassandra-rackdc.properties or cassandra-topology.properties file to the Cassandra configuration directory on all the cluster's nodes. They won't be used until the new snitch is enabled.

    The location of the cassandra-topology.properties file depends on the type of installation:

        |Package installations|/etc/cassandra/cassandra-topology.properties|
    |Tarball installations|install\_location/conf/cassandra-topology.properties|

    The location of the cassandra-rackdc.properties file depends on the type of installation:

        |Package installations|/etc/cassandra/cassandra-rackdc.properties|
    |Tarball installations|install\_location/conf/cassandra-rackdc.properties|

    The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

        |Package installations|/etc/cassandra/cassandra.yaml|
    |Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

4.  Change the snitch for each node in the cluster in the node's cassandra.yaml file. For example:

    ```
    endpoint_snitch: GossipingPropertyFileSnitch
    ```

5.  If the topology has not changed, you can restart each node one at a time.

    Any change in the cassandra.yaml file requires a node restart.

6.  If the topology of the network has changed, but no datacenters are added:

    1.  Shut down all the nodes, then restart them.

    2.  Run a [sequential repair](../tools/toolsRepair.md) and [nodetool cleanup](../tools/toolsCleanup.md) on each node.

7.  If the topology of the network has changed and a datacenter is added:

    1.  [Create a new datacenter.](opsAddDCToCluster.md)

    2.  Replicate data into new datacenter. [Remove nodes](opsRemoveNode.md) from old datacenter.

    3.  Run a [sequential repair](../tools/toolsRepair.md) and [nodetool cleanup](../tools/toolsCleanup.md) on each node.


**Parent topic:** [Adding or removing nodes, datacenters, or clusters](../../cassandra/operations/opsAddingRemovingNodeTOC.md)

**Related information**  


[Snitches](../architecture/archSnitchesAbout.md)

