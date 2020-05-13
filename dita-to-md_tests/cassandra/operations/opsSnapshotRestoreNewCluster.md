# Restoring a snapshot into a new cluster {#opsSnapshotRestoreNewCluster .task}

Steps for restoring a snapshot by recovering the cluster into another newly created cluster.

Suppose you want to copy a snapshot of SSTable data files from a three node Cassandra cluster with vnodes enabled \(256 tokens\) and recover it on another newly created three node cluster \(256 tokens\). The token ranges will not match, because the token ranges cannot be exactly the same in the new cluster. You need to specify the tokens for the new cluster that were used in the old cluster.

**Note:** This procedure assumes you are familiar with [restoring a snapshot](opsBackupSnapshotRestore.md) and configuring and [initializing a cluster](../initialize/initTOC.md).

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

1.  To recover the snapshot on the new cluster:
2.  From the old cluster, retrieve the list of tokens associated with each node's IP:

    ```screen
    $ nodetool ring | grep ip\_address\_of\_node | awk '{print $NF ","}' | xargs
    ```

3.  In the cassandra.yaml file for each node in the new cluster, add the list of tokens you obtained in the previous step to the [initial\_token](../configuration/configCassandra_yaml.md#initial_token) parameter using the same num\_tokens setting as in the old cluster.

4.  Make any other necessary changes in the new cluster's cassandra.yaml and property files so that the new nodes match the old cluster settings. Make sure the seed nodes are set for the new cluster.

5.  Clear the system table data from each new node:

    ```screen
    $ sudo rm -rf /var/lib/cassandra/data/system/*
    ```

    This allows the new nodes to use the initial tokens defined in the cassandra.yaml when they restart.

6.  Start each node using the specified list of token ranges in new cluster's cassandra.yaml:

    ```
    initial_token: -9211270970129494930, -9138351317258731895, -8980763462514965928, ...
    ```

7.  Create schema in the new cluster. All the schemas from the old cluster must be reproduced in the new cluster.

8.  [Stop the node](../initialize/referenceStartStopTOC.md). Using `nodetool refresh` is unsafe because files within the data directory of a running node can be silently overwritten by identically named just-flushed SSTables from memtable flushes or compaction. Copying files into the data directory and restarting the node will not work for the same reason.

9.  [Restore the SSTable files snapshotted](opsBackupSnapshotRestore.md) from the old cluster onto the new cluster using the same directories, while noting that the UUID component of target directory names has changed. Without restoration, the new cluster will not have data to read upon restart.

10. Restart the node.


**Parent topic:** [Backing up and restoring data](../../cassandra/operations/opsBackupRestore.md)

