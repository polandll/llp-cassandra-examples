# Restoring from a snapshot {#opsBackupSnapshotRestore .task}

Methods for restoring from a snapshot.

Restoring a keyspace from a snapshot requires all snapshot files for the table, and if using incremental backups, any incremental backup files created after the snapshot was taken. Streamed SSTables \(from repair, decommission, and so on\) are also hardlinked and included.

**Note:** Restoring from snapshots and incremental backups temporarily causes intensive CPU and I/O activity on the node being restored.

## Restoring from local nodes {#local-backup .section}

This method copies the SSTables from the snapshots directory into the correct data directories.

1.  Make sure the table schema exists.

    Cassandra can only restore data from a snapshot when the table schema exists. If the schema does not exist and has not been backed up, you must recreate the schema.

2.  If necessary, [truncate](/en/cql-oss/3.3/cql/cql_reference/cqlTruncate.html) the table.

    **Note:** You may not need to truncate under certain conditions. For example, if a node lost a disk, you might restart before restoring so that the node continues to receive new writes before starting the restore procedure.

    Truncating is usually necessary. For example, if there was an accidental deletion of data, the tombstone from that delete has a later write timestamp than the data in the snapshot. If you restore without truncating \(removing the tombstone\), Cassandra continues to shadow the restored data. This behavior also occurs for other types of overwrites and causes the same problem.

3.  Locate the most recent snapshot folder. For example:

    data\_directory/keyspace\_name/table\_name-UUID/snapshots/snapshot\_name

4.  Copy the most recent snapshot SSTable directory to the data\_directory/keyspace/table\_name-UUID directory.

    The location of the data directory depends on the type of installation:

        |Package installations|/var/lib/cassandra|
    |Tarball installations|install\_location/data/data|

5.  Run [nodetool refresh](../tools/toolsRefresh.md).

## Restoring from centralized backups {#central-backup .section}

This method uses [sstableloader](../tools/toolsBulkloader.md) to restore snapshots.

1.  Make sure the table schema exists.

    Cassandra can only restore data from a snapshot when the table schema exists. If the schema does not exist and has not been backed up, you must recreate the schema.

2.  If necessary, [truncate](/en/cql-oss/3.3/cql/cql_reference/cqlTruncate.html) the table.

    **Note:** You may not need to truncate under certain conditions. For example, if a node lost a disk, you might restart before restoring so that the node continues to receive new writes before starting the restore procedure.

    Truncating is usually necessary. For example, if there was an accidental deletion of data, the tombstone from that delete has a later write timestamp than the data in the snapshot. If you restore without truncating \(removing the tombstone\), Cassandra continues to shadow the restored data. This behavior also occurs for other types of overwrites and causes the same problem.

3.  Restore the most recent snapshot using the [sstableloader](../tools/toolsBulkloader.md) tool on the backed-up SSTables.

    The sstableloader streams the SSTables to the correct nodes. You do not need to remove the commitlogs or drain or restart the nodes.


**Parent topic:** [Backing up and restoring data](../../cassandra/operations/opsBackupRestore.md)

