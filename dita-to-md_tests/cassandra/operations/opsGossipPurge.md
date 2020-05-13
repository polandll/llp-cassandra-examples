# Purging gossip state on a node {#opsGossipPurge .task}

Correcting a problem in the gossip state.

Gossip information is persisted locally by each node to use immediately on node restart without having to wait for gossip communications.

1.  In the unlikely event you need to correct a problem in the gossip state:
2.  Use the [nodetool assassinate](../tools/toolsAssassinate.md) to shut down the problem node.

    This takes approximately 35 seconds to complete, so wait for confirmation that the node is deleted.

3.  If this method doesn't solve the problem, stop your client application from sending writes to the cluster.

4.  Take the entire cluster offline:

    1.  [Drain](../tools/toolsDrain.md) each node.

        ```language-bash
        nodetool options drain
        ```

    2.  Stop each node:

        -   Package installations:

            ```language-bash
            sudo service cassandra stop
            ```

        -   Tarball installations:

            ```language-bash
            sudo service cassandra stop
            ```

5.  Clear the data from the peers directory, remove all directories in the peers-*UUID* directory, where *UUID* is the particular directory that corresponds to the appropriate node:

    ```screen
    $ sudo rm -r /var/lib/cassandra/data/system/peers-UUID/*
    ```

    CAUTION:

    Use caution when performing this step. The action clears internal system data from Cassandra and may cause application outage without careful execution and validation of the results. To validate the results, run the following query individually on each node to confirm that all of the nodes are able to see all other nodes.

    ```
    select * from system.peers;
    ```

6.  Clear the gossip state when the node starts:

    -   For tarball installations, you can use a command line option or edit the cassandra-env.sh. To use the command line:

        ```screen
        $ install\_location/bin/cassandra -Dcassandra.load_ring_state=false
        ```

    -   For package installations or if you are not using the command line option [above](opsGossipPurge.md#command-line-step), add the following line to the cassandra-env.sh file:

        ```
        $env:JVM_OPTS="$JVM_OPTS -Dcassandra.load_ring_state=false"
        ```

        -    Package installations:/usr/share/cassandra/cassandra-env.sh
        -   Tarball installations:install\_location/conf/cassandra-env.sh
    The location of the cassandra-env.sh file depends on the type of installation:

        |Package installations|/etc/cassandra/cassandra-env.sh|
    |Tarball installations|install\_location/conf/cassandra-env.sh|

7.  Bring the cluster online one node at a time, starting with the seed nodes.

    -    Package installations:

        ```language-bash
        sudo service cassandra start #Starts Cassandra
        ```

    -   Tarball installations:

        ```language-bash
        cd install\_location
        ```


Remove the line you added in the cassandra-env.sh file.

**Parent topic:** [Operations](../../cassandra/operations/operationsTOC.md)

