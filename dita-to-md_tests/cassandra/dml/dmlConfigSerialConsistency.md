# How is the serial consistency level configured? {#dmlConfigSerialConsistency .concept}

Serial consistency levels in Cassandra can be configured to manage lightweight transaction isolation.

Serial consistency levels in Cassandra can be configured to manage lightweight transaction isolation. Lightweight transactions have two consistency levels defined. The serial consistency level defines the consistency level of the serial phase, or Paxos phase, of lightweight transactions. The learn phase, which defines what read operations will be guaranteed to complete immediately if lightweight writes are occurring uses a normal consistency level. The serial consistency level is ignored for any query that is not a conditional update.

## Serial consistency levels {#dml-config-write-consistency .section}

|Level|Description|Usage|
|-----|-----------|-----|
|`SERIAL`|Achieves [linearizable consistency](dmlAboutDataConsistency.md#linearizable-consistency) for lightweight transactions by preventing unconditional updates.|This consistency level is only for use with lightweight transaction. Equivalent to QUORUM.|
|`LOCAL_SERIAL`|Same as SERIAL but confined to the datacenter. A conditional write must be written to the [commit log and memtable](dmlHowDataWritten.md#logging-writes-and-memtable-storage) on a quorum of replica nodes in the same datacenter.|Same as SERIAL but used to maintain consistency locally \(within the single datacenter\). Equivalent to LOCAL\_QUORUM.|

**Parent topic:** [Data consistency](../../cassandra/dml/dmlDataConsistencyTOC.md)

