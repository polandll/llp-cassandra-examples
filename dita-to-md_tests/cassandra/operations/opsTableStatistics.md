# Table statistics {#opsTableStatistics .concept}

Compaction metrics provide a number of statistics that are important for monitoring performance trends.

For individual tables, ColumnFamilyStoreMBean provides the same general latency attributes as StorageProxyMBean. Unlike StorageProxyMBean, ColumnFamilyStoreMBean has a number of other statistics that are important to monitor for performance trends. The most important of these are:

|Attribute|Description|
|---------|-----------|
|MemtableDataSize|The total size consumed by this table's data \(not including metadata\).|
|MemtableColumnsCount|Returns the total number of columns present in the [memtable](/en/glossary/doc/glossary/gloss_memtable.html) \(across all keys\).|
|MemtableSwitchCount|How many times the memtable has been flushed out.|
|RecentReadLatencyMicros|The average read latency since the last call to this bean.|
|RecentWriterLatencyMicros|The average write latency since the last call to this bean.|
|LiveSSTableCount|The number of live SSTables for this table.|

The recent read latency and write latency counters are important in making sure operations are happening in a consistent manner. If these counters start to increase after a period of staying flat, you probably need to add capacity to the cluster.

You can set a threshold and monitor LiveSSTableCount to ensure that the number of [SSTables](/en/glossary/doc/glossary/gloss_sstable.html) for a given table does not become too great.

**Parent topic:** [Monitoring a Cassandra cluster](../../cassandra/operations/opsMonitoring.md)

