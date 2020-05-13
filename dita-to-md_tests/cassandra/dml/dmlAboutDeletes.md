# How is data deleted? {#dmlAboutDeletes .concept}

How Cassandra deletes data and why deleted data can reappear.

Cassandra's processes for deleting data are designed to improve performance, and to work with Cassandra's built-in properties for data distribution and fault-tolerance.

Cassandra treats a delete as an insert or [upsert](/en/glossary/doc/glossary/gloss_upsert.html). The data being added to the partition in the [DELETE](/en/cql-oss/3.3/cql/cql_reference/cqlDelete.html) command is a deletion marker called a [tombstone](/en/glossary/doc/glossary/gloss_tombstone.html). The tombstones go through Cassandra's write path, and are written to SSTables on one or more nodes. The key difference feature of a tombstone: it has a built-in expiration date/time. At the end of its expiration period \(for details see below\) the tombstone is deleted as part of Cassandra's normal [compaction](dmlHowDataMaintain.md#dml-compaction) process.

You can also mark a Cassandra record \(row or column\) with a [time-to-live](/en/cql-oss/3.3/cql/cql_using/useTTL.html) value. After this amount of time has ended, Cassandra marks the record with a tombstone, and handles it like other tombstoned records.

## Deletion in a distributed system {#deletion-in-a-distributed-system .section}

In a multi-node cluster, Cassandra can store replicas of the same data on two or more nodes. This helps prevent data loss, but it complicates the delete process. If a node receives a delete for data it stores locally, the node tombstones the specified record and tries to pass the tombstone to other nodes containing replicas of that record. But if one replica node is unresponsive at that time, it does not receive the tombstone immediately, so it still contains the pre-delete version of the record. If the tombstoned record has already been deleted from the rest of the cluster befor that node recovers, Cassandra treats the record on the recovered node as new data, and propagates it to the rest of the cluster. This kind of deleted but persistent record is called a [zombie](/en/glossary/doc/glossary/gloss_zombie.html).

To prevent the reappearance of zombies, Cassandra gives each tombstone a *grace period*. The purpose of the grace period is to give unresponsive nodes time to recover and process tombstones normally. If a client writes a new update to the tombstoned record during the grace period, Cassandra overwrites the tombstone. If a client sends a read for that record during the grace period, Cassandra disregards the tombstone and retrieves the record from other replicas if possible.

When an unresponsive node recovers, Cassandra uses [hinted handoff](../operations/opsRepairNodesHintedHandoff.md) to replay the database [mutations](/en/glossary/doc/glossary/gloss_mutation.html) the node missed while it was down. Cassandra does not replay a mutation for a tombstoned record during its grace period. But if the node does not recover until after the grace period ends, Cassandra may miss the deletion.

After the tombstone's grace period ends, Cassandra deletes the tombstone during compaction.

The grace period for a tombstone is set by the property gc\_grace\_seconds. Its default value is 864000 seconds \(ten days\). Each table can have its own value for this property.

## More about Cassandra deletes {#more-about-deletes .section}

Details:

-   The expiration date/time for a tombstone is the date/time of its creation plus the value of the [table property](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#tabProp) gc\_grace\_seconds.
-   Cassandra also supports [Batch data insertion and updates](/en/cql-oss/3.3/cql/cql_using/useBatchTOC.html). This procedure also introduces the danger of replaying a record insertion after that record has been removed from the rest of the cluster. Cassandra does not replay a batched mutation for a tombstoned record that is still within its grace period.
-   On a single-node cluster, you can set gc\_grace\_seconds to `0` \(zero\).
-   To completely prevent the reappearance of zombie records, run [nodetool repair](../tools/toolsRepair.md) on a node after it recovers, and on each table every gc\_grace\_seconds.
-   If all records in a table are given a TTL at creation, and all are allowed to expire and not deleted manually, it is not necessary to run [nodetool repair](../tools/toolsRepair.md) for that table on a regular basis.
-   If you use the [SizeTieredCompactionStrategy or DateTieredCompactionStrategy](dmlHowDataMaintain.md), you can delete tombstones immediately by [manually starting the compaction process](../tools/toolsCompact.md).

    CAUTION:

    If you force compaction, Cassandra may create one very large SSTable from all the data. Cassandra will not trigger another compaction for a long time. The data in the SSTable created during the forced compaction can grow very stale during this long period of non-compaction.

-   Cassandra allows you to set a default\_time\_to\_live [property](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#tabProp) for an entire table. Columns and rows marked with regular TTLs are processed as described above; but when a record exceeds the table-level TTL, Cassandra deletes it immediately, without tombstoning or compaction.
-   Cassandra supports immediate deletion through the [DROP KEYSPACE](/en/cql-oss/3.3/cql/cql_reference/cqlDropKeyspace.html) and [DROP TABLE](/en/cql-oss/3.3/cql/cql_reference/cqlDropTable.html) statements.

**Parent topic:** [How Cassandra reads and writes data](../../cassandra/dml/dmlIntro.md)

