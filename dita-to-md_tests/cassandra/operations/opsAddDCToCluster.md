# Adding a datacenter to a cluster {#opsAddDCToCluster .task}

Steps for adding a datacenter to an existing cluster.

Steps for adding a datacenter to an existing cluster.

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

1.  Ensure that old data files won't interfere with the new cluster:

    1.  Remove any existing \(running\) nodes in a different cluster or datacenter first that contain old data.

    2.  Properly clean these nodes.

    3.  Completely remove the application directories \(recommended\).

    4.  After removal, install Cassandra from scratch.

2.  Configure the keyspace and create the new datacenter:

    1.  Use [ALTER KEYSPACE](/en/cql-oss/3.3/cql/cql_reference/cqlAlterKeyspace.html) to use the [NetworkTopologyStrategy](../architecture/archDataDistributeReplication.md#rep-strategy-ul) for the following keyspaces:

        -   All user-created
        -   system: `system_distributed`, `system_auth`, `system_traces`
        This step is required for multiple datacenter clusters because nodetool rebuild \([11](opsAddDCToCluster.md#step-nodetool-rebuild)\) requires a replica of these keyspaces in the specified source datacenter.

    2.  Create a new datacenter with a replication factor of zero.

        You can use cqlsh to create or alter a keyspace:

        ```
        CREATE KEYSPACE "sample-ks" WITH REPLICATION =
          { 'class' : 'NetworkTopologyStrategy', 'ExistingDC' : 3 , 'NewDC' : 0};
        ```

3.  In the new datacenter, install Cassandra on each new node. Do not start the service or restart the node.

    Be sure to use the same version of Cassandra on all nodes in the cluster.

4.  Configure cassandra.yaml on each new node following the configuration of the other nodes in the cluster:

    1.  Set other cassandra.yaml properties, such as -seeds and endpoint\_snitch, to match the settings in the cassandra.yaml files on other nodes in the cluster. See [Initializing a multiple node cluster \(multiple datacenters\)](../initialize/initMultipleDS.md).

        **Note:** Do not make all nodes seeds, see [Internode communications \(gossip\)](../architecture/archGossipAbout.md).

    2.  If using vnodes, set [num\_tokens](../configuration/configCassandra_yaml.md#num_tokens) on each node.

        The recommended value is 256. Do not set the [initial\_token](../configuration/configCassandra_yaml.md#initial_token).

    3.  If using single-node-per-token architecture, generate the initial token for each node. Add this as the value for each node's [initial\_token](../configuration/configCassandra_yaml.md#initial_token) property, and make sure the num\_tokens is commented out.

        See [Generating tokens](../configuration/configGenTokens.md) and [Adding or replacing single-token nodes](opsAddRplSingleTokenNodes.md).

5.  On each new node, add the new datacenter definition to the properties file for the type of [snitches](../architecture/archSnitchesAbout.md) used in the cluster:

    **Note:** Do not use the SimpleSnitch. The SimpleSnitch \(default\) is used only for single-datacenter deployments. It does not recognize datacenter or rack information and can be used only for single-datacenter deployments or single-zone in public clouds.

    |Snitch|Configuring file|
    |------|----------------|
    |[PropertyFileSnitch](../architecture/archSnitchPFSnitch.md)|cassandra-topology.properties|
    |[GossipPropertyFileSnitch](../architecture/archsnitchGossipPF.md)|cassandra-rackdc.properties|
    |[Ec2Snitch](../architecture/archSnitchEC2.md)|
    |[Ec2MultiRegionSnitch](../architecture/archSnitchEC2MultiRegion.md)|
    |[GoogleCloudSnitch](../architecture/archSnitchGoogle.md)|

6.  In the existing datacenters:

    1.  On some nodes, update the seeds property in the cassandra.yaml file to include the seed nodes in the new datacenter and restart those nodes. \(Changes to the cassandra.yaml file require restarting to take effect.\)

    2.  Add the new datacenter definition to the properties file for the type of snitch used in the cluster \([5](opsAddDCToCluster.md#set-snitch)\). If changing snitches, see [Switching snitches](opsSwitchSnitch.md).

7.  To avoid the client prematurely connecting to the new datacenter:

    1.  Make sure the clients are configured to use the `DCAwareRoundRobinPolicy`.

    2.  Be sure that your client point to the existing datacenter, so it's not trying to access the new datacenter, which may not have any data.

    See the programming instructions for your [driver](/en/developer/driver-matrix/doc/common/driverMatrix.html).

8.  To ensure you are not using a consistency level for reads or writes that queries the new datacenter, review the [consistency level](../dml/dmlConfigConsistency.md) for global or per-operation level for multiple datacenter operation:

    1.  If using a `QUORUM` consistency level, change to `LOCAL_QUORUM`.

    2.  If using the `ONE` consistency level, set to `LOCAL_ONE`.

    **Warning:** If client applications are not properly configured, they may connect to the new datacenter before the datacenter is ready. This results in connection exceptions, timeouts, and/or inconsistent data.

9.  [Start Cassandra](../initialize/referenceStartStopTOC.md) on the new nodes.

10. After all nodes are running in the cluster and the client applications are datacenter aware \([7](opsAddDCToCluster.md#DCAwareRoundRobinPolicy)\), use cqlsh to alter the keyspaces:

    ```
    ALTER KEYSPACE "sample-ks" WITH REPLICATION =
    	{'class’: 'NetworkTopologyStrategy', 'ExistingDC':3, 'NewDC':3};
    ```

    **Warning:** If client applications are not properly configured, they may connect to the new datacenter before the datacenter is ready. This results in connection exceptions, timeouts, and/or inconsistent data.

11. Run [nodetool rebuild](../tools/toolsRebuild.md) on each node in the new datacenter.

    ``` {#rebuild-example .screen}
    $ nodetool rebuild -- name\_of\_existing\_data\_center
    ```

    CAUTION:

    If you don't specify the existing datacenter in the command line, the new nodes will appear to rebuild successfully, but will not contain any data.

    If you miss this step, requests to the new datacenter with LOCAL\_ONE or ONE consistency levels may fail if the existing datacenters are not completely in-sync.

    This step ensures that the new nodes recognize the existing datacenters in the cluster.

    You can run rebuild on one or more nodes at the same time. Run on one node at a time to reduce the impact on the existing cluster. Run on multiple nodes when the cluster can handle the extra I/O and network pressure.


The datacenters in the cluster are now replicating with each other.

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

**Parent topic:** [Adding or removing nodes, datacenters, or clusters](../../cassandra/operations/opsAddingRemovingNodeTOC.md)

**Related information**  


[Install locations](../install/installLocationsTOC.md)

[Starting Cassandra as a service](../initialize/referenceStartCservice.md)

[Starting Cassandra as a stand-alone process](../initialize/referenceStartCprocess.md)

