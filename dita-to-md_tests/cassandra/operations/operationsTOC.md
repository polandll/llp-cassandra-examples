# Operations {#operationsTOC}

Cassandra operation topics, such as node and datacenter operations, changing replication strategies, configuring compaction and compression, caching, and tuning Bloom filters.

-   **[Adding or removing nodes, datacenters, or clusters](../../cassandra/operations/opsAddingRemovingNodeTOC.md)**  
Topics for adding or removing nodes, datacenters, or clusters.
-   **[Backing up and restoring data](../../cassandra/operations/opsBackupRestore.md)**  
Cassandra backs up data by taking a snapshot of all on-disk data files \(SSTable files\) stored in the data directory.
-   **[Repairing nodes](../../cassandra/operations/opsRepairNodesTOC.md)**  
Node repair topics.
-   **[Monitoring Cassandra](../../cassandra/operations/monitoringCassandraTOC.md)**  
Monitoring topics.
-   **[Tuning Java resources](../../cassandra/operations/opsTuneJVM.md)**  
Tuning the Java Virtual Machine \(JVM\) can improve performance or reduce high memory consumption.
-   **[Data caching](../../cassandra/operations/opsDataCachingTOC.md)**  
Data caching topics.
-   **[Configuring memtable thresholds](../../cassandra/operations/opsMemtableThruput.md)**  
Configuring memtable thresholds to improve write performance.
-   **[Configuring compaction](../../cassandra/operations/opsConfigureCompaction.md)**  
Steps for configuring compaction. The compaction process merges keys, combines columns, evicts tombstones, consolidates SSTables, and creates a new index in the merged SSTable.
-   **[Compression](../../cassandra/operations/opsAboutConfigCompress.md)**  
Compression maximizes the storage capacity of Cassandra nodes by reducing the volume of data on disk and disk I/O, particularly for read-dominated workloads.
-   **[Testing compaction and compression](../../cassandra/operations/opsTestCompactCompress.md)**  
Enabling write survey mode.
-   **[Tuning Bloom filters](../../cassandra/operations/opsTuningBloomFilters.md)**  
Cassandra uses Bloom filters to determine whether an SSTable has data for a particular row.
-   **[Moving data to or from other databases](../../cassandra/operations/migrating.md)**  
Solutions for migrating from other databases.
-   **[Purging gossip state on a node](../../cassandra/operations/opsGossipPurge.md)**  
Correcting a problem in the gossip state.

