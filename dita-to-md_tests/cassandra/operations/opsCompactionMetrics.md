# Compaction metrics {#opsCompactionMetrics .concept}

Monitoring compaction performance is an important aspect of knowing when to add capacity to your cluster.

Monitoring compaction performance is an important aspect of knowing when to add capacity to your cluster. The following attributes are exposed through CompactionManagerMBean:

|Attribute|Description|
|---------|-----------|
|BytesCompacted|Total number of bytes compacted since server \[re\]start|
|CompletedTasks|Number of completed compactions since server \[re\]start|
|PendingTasks|Estimated number of compactions remaining to perform|
|TotalCompactionsCompleted|Total number of compactions since server \[re\]start|

**Parent topic:** [Monitoring a Cassandra cluster](../../cassandra/operations/opsMonitoring.md)

