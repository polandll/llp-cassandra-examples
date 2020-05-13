# Recovering from a single disk failure using JBOD {#opsRecoverUsingJBOD .task}

Steps for recovering from a single disk failure in a disk array using JBOD \(just a bunch of disks\).

Steps for recovering from a single disk failure in a disk array using JBOD \(just a bunch of disks\).

Cassandra might not fail from the loss of one disk in a JBOD array, but some reads and writes may fail when:

-   The operation's consistency level is ALL.
-   The data being requested or written is stored on the defective disk.
-   The data to be compacted is on the defective disk.

It's possible that you can simply replace the disk, restart Cassandra, and run nodetool repair. However, if the disk crash corrupted the Cassandra system table, you must remove the incomplete data from the other disks in the array. The procedure for doing this depends on whether the cluster uses [vnodes](/en/glossary/doc/glossary/gloss_vnode.html) or single-token architecture.

1.  These steps are supported for Cassandra versions 3.2 and later. If a disk fails on a node in a cluster using an earlier version of Cassandra, [replace the node](opsReplaceNode.md).
2.  Verify that the node has a defective disk and identify the disk:

    1.  Check the [logs](../configuration/configLoggingLevels.md) on the affected node.

        Disk failures are logged in `FILE NOT FOUND` entries, which identifies the mount point or disk that has failed.

    2.  If no `FILE NOT FOUND` entries exist, see [DataStax Support](https://support.datastax.com/hc/en-us).

3.  If the node is still running, [stop Cassandra](../initialize/referenceStartStopTOC.md) and shut down the node.

4.  Replace the defective disk and restart the node.

5.  If the node cannot restart:

    1.  Try restarting Cassandra without bootstrapping the node:

        Package installations:

        1.  Add the following option to cassandra-env.sh file:

            ```
            JVM_OPTS="$JVM_OPTS -Dcassandra.allow_unsafe_replace=true
            ```

        2.  [Start the node](../initialize/referenceStartCservice.md).
        3.  After the node bootstraps, remove the `-Dcassandra.allow_unsafe_replace=true` parameter from cassandra-env.sh.
        4.  [Restart the node](../initialize/referenceStartCservice.md).
        Tarball installations:

        -   Start Cassandra with this option:

            ```screen
            $ sudo bin/cassandra Dcassandra.allow_unsafe_replace=true
            ```

6.  If Cassandra restarts, run [nodetool repair](../tools/toolsRepair.md) on the node. If not, [replace the node](opsReplaceNode.md).

7.  If the repair succeeds, the node is restored to production. Otherwise, go to [7](opsRecoverUsingJBOD.md#vnode-used) or [8](opsRecoverUsingJBOD.md#single-token-nodes-used).

8.  For a cluster using vnodes:

    1.  On the affected node, clear the system directory on each functioning drive.

        Example for a node with a three disk JBOD array:

        ```no-highlight
        $ -/mnt1/cassandra/data
        $ -/mnt2/cassandra/data
        $ -/mnt3/cassandra/data
        ```

        If `mnt1` has failed:

        ```no-highlight
        $ rm -fr /mnt2/cassandra/data/system
        $ rm -fr /mnt3/cassandra/data/system
        ```

    2.  Restart Cassandra without bootstrapping as described in [4](opsRecoverUsingJBOD.md#restart-w-out-boots):

        ```no-highlight
        $ -Dcassandra.allow_unsafe_replace=true
        ```

    3.  Run [nodetool repair](../tools/toolsRepair.md) on the node.

        If the repair succeeds, the node is restored to production. If not, [replace the dead node](opsReplaceNode.md).

9.  For a cluster single-token nodes:

    1.  On one of the cluster's working nodes, run [nodetool ring](../tools/toolsRing.md) to retrieve the list of the repaired node's tokens:

        ```screen
        $ nodetool ring | grep ip\_address\_of\_node | awk ' {print $NF ","}' | xargs
        ```

    2.  Copy the output of the nodetool ring into a spreadsheet \(space-delimited\).

    3.  Edit the output, keeping the list of tokens and deleting the other columns.

    4.  On the node with the new disk, open the cassandra.yaml file and add the tokens \(as a comma-separated list\) to the [initial\_token](../configuration/configCassandra_yaml.md#initial_token) property.

    5.  Change any other non-default settings in the new nodes to match the existing nodes. Use the diff command to find and merge any differences between the nodes.

        If the repair succeeds, the node is restored to production. If not, [replace the node](opsReplaceNode.md).

    6.  On the affected node, clear the system directory on each functioning drive.

        Example for a node with a three disk JBOD array:

        ```no-highlight
        $ -/mnt1/cassandra/data
        $ -/mnt2/cassandra/data
        $ -/mnt3/cassandra/data
        ```

        If `mnt1` has failed:

        ```no-highlight
        $ rm -fr /mnt2/cassandra/data/system
        $ rm -fr /mnt3/cassandra/data/system
        ```

    7.  Restart Cassandra without bootstrapping as described in [4](opsRecoverUsingJBOD.md#restart-w-out-boots):

        ```no-highlight
        $ -Dcassandra.allow_unsafe_replace=true
        ```

    8.  Run [nodetool repair](../tools/toolsRepair.md) on the node.

        If the repair succeeds, the node is restored to production. If not, [replace the node](opsReplaceNode.md).

        The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

                |Package installations|/etc/cassandra/cassandra.yaml|
        |Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

        The location of the cassandra-rackdc.properties file depends on the type of installation:

                |Package installations|/etc/cassandra/cassandra-rackdc.properties|
        |Tarball installations|install\_location/conf/cassandra-rackdc.properties|

        The location of the cassandra-topology.properties file depends on the type of installation:

                |Package installations|/etc/cassandra/cassandra-topology.properties|
        |Tarball installations|install\_location/conf/cassandra-topology.properties|

        The location of the cassandra-env.sh file depends on the type of installation:

                |Package installations|/etc/cassandra/cassandra-env.sh|
        |Tarball installations|install\_location/conf/cassandra-env.sh|


**Parent topic:** [Backing up and restoring data](../../cassandra/operations/opsBackupRestore.md)

