# Deleting snapshot files {#opsBackupDeleteSnapshot .task}

Steps to delete snapshot files.

When taking a snapshot, previous snapshot files are not automatically deleted. You should remove old snapshots that are no longer needed.

The [nodetool clearsnapshot](../tools/toolsClearSnapShot.md) command removes all existing snapshot files from the snapshot directory of each keyspace. You should make it part of your back-up process to clear old snapshots before taking a new one.

1.  To delete all snapshots for a node, run the nodetool clearsnapshot command. For example:

    ```
    $ nodetool -h localhost -p 7199 clearsnapshot
    ```

    To delete snapshots on all nodes at once, run the nodetool clearsnapshot command using a parallel ssh utility.

2.  To delete a single snapshot, run the clearsnapshot command with the snapshot name:

    ```
    $ nodetool clearsnapshot -t <snapshot_name>
    ```

    The file name and path vary according to the type of snapshot. See [nodetools snapshot](../tools/toolsSnapShot.md) for details about snapshot names and paths.


**Parent topic:** [Backing up and restoring data](../../cassandra/operations/opsBackupRestore.md)

