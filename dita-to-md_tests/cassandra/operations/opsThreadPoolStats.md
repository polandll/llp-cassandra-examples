# Thread pool and read/write latency statistics {#opsThreadPoolStats .concept}

Increases in pending tasks on thread pool statistics can indicate when to add additional capacity.

Cassandra maintains distinct thread pools for different stages of execution. Each of the thread pools provide statistics on the number of tasks that are active, pending, and completed. Trends on these pools for increases in the pending tasks column indicate when to add additional capacity. After a baseline is established, configure alarms for any increases above normal in the pending tasks column. Use [nodetool tpstats](../tools/toolsTPstats.md) on the command line to view the thread pool details shown in the following table.

|Thread Pool|Description|
|-----------|-----------|
|AntiEntropyStage|Tasks related to repair|
|CacheCleanupExecutor|Tasks related to cache maintenance \(counter cache, row cache\)|
|CompactionExecutor|Tasks related to compaction|
|CounterMutationStage|Tasks related to leading counter writes|
|GossipStage|Tasks related to the gossip protocol|
|HintsDispatcher|Tasks related to sending hints|
|InternalResponseStage|Tasks related to miscellaneous internal task responses|
|MemtableFlushWriter|Tasks related to flushing memtables|
|MemtablePostFlush|Tasks related to maintenance after memtable flush completion|
|MemtableReclaimMemory|Tasks related to reclaiming memtable memory|
|MigrationStage|Tasks related to schema maintenance|
|MiscStage|Tasks related to miscellaneous tasks, including snapshots and removing hosts|
|MutationStage|Tasks related to writes|
|Native-Transport-Requests|Tasks related to client requests from CQL|
|PendingRangeCalculator|Tasks related to recalculating range ownership after bootstraps/decommissions|
|PerDiskMemtableFlushWriter\_\*|Tasks related to flushing memtables to a given disk|
|ReadRepairStage|Tasks related to performing read repairs|
|ReadStage|Tasks related to reads|
|RequestResponseStage|Tasks for callbacks from intra-node requests|
|Sampler|Tasks related to sampling statistics|
|SecondaryIndexManagement|Tasks related to secondary index maintenance|
|ValidationExecutor|Tasks related to validation compactions|
|ViewMutationStage|Tasks related to maintaining materialized views|

## Read/Write latency metrics {#readwrite-latency-metrics .section}

Cassandra tracks latency \(averages and totals\) of read, write, and slicing operations at the server level through StorageProxyMBean.

**Parent topic:** [Monitoring a Cassandra cluster](../../cassandra/operations/opsMonitoring.md)

