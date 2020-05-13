# Adding single-token nodes to a cluster {#opsAddRplSingleTokenNodes .task}

Steps for adding nodes in single-token architecture clusters, not vnodes.

Steps for adding nodes in single-token architecture clusters, not vnodes.

To add capacity to a cluster, introduce new nodes in stages or by [adding an entire datacenter](opsAddDCSingleTokenNodes.md). Use one of the following methods:

-   **Add capacity by doubling the cluster size:** Adding capacity by doubling \(or tripling or quadrupling\) the number of nodes is less complicated when assigning tokens. Using this method, existing nodes keep their existing token assignments, and the new nodes are assigned tokens that bisect \(or trisect\) the existing token ranges.
-   **Add capacity for a non-uniform number of nodes:** When increasing capacity with this method, you must recalculate tokens for the entire cluster, and assign the new tokens to the existing nodes.

1.  Calculate the tokens for the nodes based on your expansion strategy using the [Token Generating Tool](../configuration/configGenTokens.md).

2.   [Install Cassandra](../install/install_cassandraTOC.md) and configure Cassandra on each new node.

3.  If Cassandra starts automatically \(Debian\), [stop](../initialize/referenceStartCservice.md) the node and [clear](../initialize/referenceClearCpkgData.md) the data.

4.  Configure cassandra.yaml on each new node:

    -   [auto\_bootstrap](../configuration/configCassandra_yaml.md#auto_bootstrap): If false, set it to true.

        This option is not listed in the default cassandra.yaml configuration file and defaults to true.

    -   [cluster\_name](../configuration/configCassandra_yaml.md#cluster_name)
    -   [cassandra.yaml configuration file](../configuration/configCassandra_yaml.md#listen_address)/[broadcast\_address](../configuration/configCassandra_yaml.md#broadcast_address): Usually leave blank. Otherwise, use the IP address or host name that other Cassandra nodes use to connect to the new node.
    -   [endpoint\_snitch](../architecture/archSnitchesAbout.md)
    -   [initial\_token](../configuration/configCassandra_yaml.md#initial_token): Set according to your token calculations.

        CAUTION:

        If this property has no value, Cassandra assigns the node a random token range and results in a badly unbalanced ring.

    -   [seed\_provider](../configuration/configCassandra_yaml.md#seed_provider): Make sure that the new node lists at least one seed node in the existing cluster.

        Seed nodes cannot [bootstrap](/en/glossary/doc/glossary/gloss_bootstrap.html). Make sure the new nodes are not listed in the -seeds list. **Do not make all nodes seed nodes.** See [Internode communications \(gossip\)](../architecture/archGossipAbout.md).

    -   Change any other non-default settings in the new nodes to match the existing nodes. Use the diff command to find and merge any differences between the nodes.
5.  Depending on the snitch, assign the datacenter and rack names in the cassandra-topology.properties or cassandra-rackdc.properties for each node.

6.  [Start Cassandra](../initialize/referenceStartCservice.md) on each new node in two minutes intervals with consistent.rangemovement turned on:

    -   **Package installations:** To each bootstrapped node, add the following option to the /usr/share/cassandra/cassandra-env.sh file and then start Cassandra:

        ```no-highlight
        JVM_OPTS="$JVM_OPTS -Dcassandra.consistent.rangemovement=true
        ```

    -   **Tarball installations:**

        ```screen
        $ bin/cassandra -Dcassandra.consistent.rangemovement=true
        ```

7.  The following operations are resource intensive and should be done during low-usage times.

8.  After the new nodes are fully bootstrapped, use [nodetool move](../tools/toolsMove.md) to assign the new initial\_token value to each node that requires one, one node at a time.

9.  After all nodes have their new tokens assigned, run [nodetool cleanup](../tools/toolsCleanup.md) on each node in the cluster and wait for cleanup to complete on each node before doing the next node.

    This step removes the keys that no longer belong to the previously existing nodes.

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

