# Taking a snapshot {#opsBackupTakesSnapshot .task}

Steps for taking a global snapshot or per node.

Snapshots are taken per node using the [nodetool snapshot](../tools/toolsSnapShot.md) command. To take a global snapshot, run the nodetool snapshot command using a parallel ssh utility, such as pssh.

A snapshot first flushes all in-memory writes to disk, then makes a hard link of the SSTable files for each keyspace. You must have enough free disk space on the node to accommodate making snapshots of your data files. A single snapshot requires little disk space. However, snapshots can cause your disk usage to grow more quickly over time because a snapshot prevents old obsolete data files from being deleted. After the snapshot is complete, you can move the backup files to another location if needed, or you can leave them in place.

**Note:** Cassandra can only restore data from a snapshot when the table schema exists. It is recommended that you also backup the schema. See `DESCRIBE SCHEMA` in [DESCRIBE](/en/cql-oss/3.3/cql/cql_reference/cqlshDescribe.html).

1.  Run the nodetool snapshot command, specifying the hostname, JMX port, and keyspace. For example:

    ```language-bash
    nodetool -h localhost -p 7199 snapshot mykeyspace
    ```


The snapshot is created in data\_directory/keyspace\_name/table\_name-UUID/snapshots/snapshot\_name directory. Each snapshot directory contains numerous .db files that contain the data at the time of the snapshot.

For example:

-   Package installations: /var/lib/cassandra/data/mykeyspace/users-081a1500136111e482d09318a3b15cc2/snapshots/1406227071618/mykeyspace-users-ka-1-Data.db
-   Tarball installations:install\_location/data/data/mykeyspace/users-081a1500136111e482d09318a3b15cc2/snapshots/1406227071618/mykeyspace-users-ka-1-Data.db

The location of the data directory depends on the type of installation:

|Package installations|/var/lib/cassandra|
|Tarball installations|install\_location/data/data|

**Parent topic:** [Backing up and restoring data](../../cassandra/operations/opsBackupRestore.md)

