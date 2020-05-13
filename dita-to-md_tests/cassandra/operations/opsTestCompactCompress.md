# Testing compaction and compression {#opsTestCompactCompress .task}

Enabling write survey mode.

Write survey mode is a Cassandra startup option for testing new compaction and compression strategies. In write survey mode, you can test out new compaction and compression strategies on that node and benchmark the write performance differences, without affecting the production cluster.

Write survey mode adds a node to a database cluster. The node accepts all write traffic as if it were part of the normal Cassandra cluster, but the node does not officially join the ring.

Also use write survey mode to try out a new Cassandra version. The nodes you add in write survey mode to a cluster must be of the same major release version as other nodes in the cluster. The write survey mode relies on the streaming subsystem that transfers data between nodes in bulk and differs from one major release to another.

If you want to see how read performance is affected by modifications, stop the node, bring it up as a standalone machine, and then benchmark read operations on the node.

1.  Start the Cassandra node using the write\_survey option:

    -   Package installations:Add the following option to cassandra-env.sh file:

        ```
        JVM_OPTS="$JVM_OPTS -Dcassandra.write_survey=true
        ```

    -   Tarball installations:Start Cassandra with this option:

        ```screen
        $ cd install\_location
        $ sudo bin/cassandra -Dcassandra.write_survey=true
        ```

    The location of the cassandra-topology.properties file depends on the type of installation:

        |Package installations|/etc/cassandra/cassandra-topology.properties|
    |Tarball installations|install\_location/conf/cassandra-topology.properties|

    The location of the cassandra-env.sh file depends on the type of installation:

        |Package installations|/etc/cassandra/cassandra-env.sh|
    |Tarball installations|install\_location/conf/cassandra-env.sh|


**Parent topic:** [Operations](../../cassandra/operations/operationsTOC.md)

