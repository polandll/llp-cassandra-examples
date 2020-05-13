# Backing up and restoring data {#opsBackupRestore .concept}

Cassandra backs up data by taking a snapshot of all on-disk data files \(SSTable files\) stored in the data directory.

-   **[About snapshots](../../cassandra/operations/opsAboutSnapshots.md)**  
A brief description of how Cassandra backs up data.
-   **[Taking a snapshot](../../cassandra/operations/opsBackupTakesSnapshot.md)**  
Steps for taking a global snapshot or per node.
-   **[Deleting snapshot files](../../cassandra/operations/opsBackupDeleteSnapshot.md)**  
Steps to delete snapshot files.
-   **[Enabling incremental backups](../../cassandra/operations/opsBackupIncremental.md)**  
Steps to enable incremental backups. When incremental backups are enabled, Cassandra hard-links each memtable flushed to an SSTable to a backups directory under the keyspace data directory.
-   **[Restoring from a snapshot](../../cassandra/operations/opsBackupSnapshotRestore.md)**  
Methods for restoring from a snapshot.
-   **[Restoring a snapshot into a new cluster](../../cassandra/operations/opsSnapshotRestoreNewCluster.md)**  
Steps for restoring a snapshot by recovering the cluster into another newly created cluster.
-   **[Recovering from a single disk failure using JBOD](../../cassandra/operations/opsRecoverUsingJBOD.md)**  
Steps for recovering from a single disk failure in a disk array using JBOD \(just a bunch of disks\).

**Parent topic:** [Operations](../../cassandra/operations/operationsTOC.md)

