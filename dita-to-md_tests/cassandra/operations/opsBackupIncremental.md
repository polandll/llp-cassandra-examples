# Enabling incremental backups {#opsBackupIncremental .task}

Steps to enable incremental backups. When incremental backups are enabled, Cassandra hard-links each memtable flushed to an SSTable to a backups directory under the keyspace data directory.

When incremental backups are enabled \(disabled by default\), Cassandra hard-links each memtable-flushed SSTable to a backups directory under the keyspace data directory. This allows storing backups offsite without transferring entire snapshots. Also, incremental backups combined with snapshots to provide a dependable, up-to-date backup mechanism. Compacted SSTables will not create hard links in /backups because these SSTables do not contain any data that has not already been linked.A snapshot at a point in time, plus all incremental backups and commit logs since that time form a compete backup.

As with snapshots, Cassandra does not automatically clear incremental backup files. DataStax recommends setting up a process to clear incremental backup hard-links each time a new snapshot is created.

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

1.  Edit the cassandra.yaml configuration file on each node in the cluster and change the value of [incremental\_backups](../configuration/configCassandra_yaml.md#incremental_backups) to true.


**Parent topic:** [Backing up and restoring data](../../cassandra/operations/opsBackupRestore.md)

