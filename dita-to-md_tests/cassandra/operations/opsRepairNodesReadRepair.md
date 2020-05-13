# Read Repair: repair during read path {#opsRepairNodesReadRepair .concept}

Describes read repair, repair during read path.

Read repair improves consistency in a Cassandra cluster with every read request.

In a read, the coordinator node sends a data request to one replica node and digest requests to others for consistency level \(CL\) greater than `ONE`. If all nodes return consistent data, the coordinator returns it to the client. For a description of how Cassandra handles inconsistency among replicas, see [How are read requests accomplished?](../dml/dmlClientRequestsRead.md).

In read repair, Cassandra sends a digest request to each replica not directly involved in the read. Cassandra compares all replicas and writes the most recent version to any replica node that does not have it. If the query's [consistency level](../dml/dmlConfigConsistency.md#dml-config-read-consistency) is above `ONE`, Cassandra performs this process on all replica nodes in the foreground before the data is returned to the client. Read repair repairs any node queried by the read. This means that for a consistency level of `ONE`, no data is repaired because no comparison takes place. For `QUORUM`, only the nodes that the query touches are repaired, not all nodes.

Cassandra can also perform read repair randomly on a table, independent of any read. The [read\_repair\_chance](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#tabProp) property set for a table configures the frequency of this operation.

Read repair cannot be performed on tables that use [DateTieredCompactionStrategy](opsConfigureCompaction.md), due to the method of checking timestamps used in DTCS compaction. If your table uses `DateTieredCompactionStrategy`, set `read_repair_chance` to zero. For other compaction strategies, `read_repair_chance` is typically set to a value of 0.2.

**Parent topic:** [Repairing nodes](../../cassandra/operations/opsRepairNodesTOC.md)

