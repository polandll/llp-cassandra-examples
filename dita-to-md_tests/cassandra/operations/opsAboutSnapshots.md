# About snapshots {#opsAboutSnapshots .concept}

A brief description of how Cassandra backs up data.

Cassandra backs up data by taking a snapshot of all on-disk data files \(SSTable files\) stored in the data directory. You can take a snapshot of all keyspaces, a single keyspace, or a single table while the system is online.

Using a parallel ssh tool \(such as pssh\), you can snapshot an entire cluster. This provides an eventually consistent backup. Although no one node is guaranteed to be consistent with its replica nodes at the time a snapshot is taken, a restored snapshot resumes consistency using Cassandra's built-in consistency mechanisms.

After a system-wide snapshot is performed, you can enable incremental backups on each node to backup data that has changed since the last snapshot: each time a memtable is flushed to disk and an SSTable is created, a hard link is copied into a /backups subdirectory of the data directory \(provided JNA is enabled\). Compacted SSTables will not create hard links in /backups because these SSTables do not contain any data that has not already been linked.

**Parent topic:** [Backing up and restoring data](../../cassandra/operations/opsBackupRestore.md)

