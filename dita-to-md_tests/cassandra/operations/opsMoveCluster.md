# Edge cases for transitioning or migrating a cluster {#opsMoveCluster .task}

Unusual migration scenarios without interruption of service.

The information in this topic is intended for the following types of scenarios \(without any interruption of service\):

-   Transition a cluster on EC2 to a cluster on Amazon virtual private cloud \(VPC\).
-   Migrate from a cluster when the network separates the current cluster from the future location.
-   Migrate from an early Cassandra cluster to a recent major version.

1.  The following method ensures that if something goes wrong with the new cluster, you still have the existing cluster until you no longer need it.
2.  Set up and configure the new cluster as described in [Initializing a cluster](../initialize/initTOC.md).

    **Note:** If you're not using vnodes, be sure to configure the token ranges in the new nodes to match the ranges in the old cluster.

3.  Set up the schema for the new cluster using [CQL](/en/cql-oss/3.3/cql/cqlIntro.html).

4.  Configure your client to write to both clusters.

    Depending on how the writes are done, code changes may be needed. Be sure to use identical consistency levels.

5.  Ensure that the data is flowing to the new nodes so you won't have any gaps when you copy the snapshots to the new cluster in step 6.

6.  [Snapshot](opsBackupTakesSnapshot.md) the old EC2 cluster.

7.  Copy the data files from your keyspaces to the nodes.

    -   You may be able to copy the data files to their matching nodes in the new cluster, which is simpler and more efficient. This will work if:
        -   You are not using vnodes
        -   The destination is not a different version of Cassandra
        -   The node ratio is 1:1
    -   If the clusters are different sizes or if you are using vnodes, use the [sstableloader \(Cassandra bulk loader\)](../tools/toolsBulkloader.md) \(sstableloader\).
8.  You can either switch to the new cluster all at once or perform an incremental migration.

    For example, to perform an incremental migration, you can set your client to designate a percentage of the reads that go to the new cluster. This allows you to test the new cluster before decommissioning the old cluster.

9.  Decommission the old cluster, as described in [Decommissioning a datacenter](opsDecomissionDC.md).


**Parent topic:** [Adding or removing nodes, datacenters, or clusters](../../cassandra/operations/opsAddingRemovingNodeTOC.md)

