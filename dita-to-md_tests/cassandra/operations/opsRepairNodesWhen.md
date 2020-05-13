# When to run anti-entropy repair {#opsRepairNodesWhen .concept}

When should anti-entropy repair be run on nodes.

When to run anti-entropy repair is dependent on the characteristics of a Cassandra cluster. General guidelines are presented here, and should be tailored to each particular case.

## When is repair needed? {#opsRepairGuidelines .section}

Run repair in these situations:

-   To routinely maintain node health.

    **Note:** Even if deletions never occur, schedule regular repairs. Setting a column to null is a delete.

-   To recover a node after a failure while bringing it back into the cluster.
-   To update data on a node containing data that is not read frequently, and therefore does not get read repair.
-   To update data on a node that has been down.
-   To recover missing data or corrupted SSTables. To do this, you must run non-incremental repair.

Guidelines for running routine node repair include:

-   Run incremental repair daily, run full repairs weekly to monthly. Monthly is generally sufficient, but run more frequently if warranted.

    **Important:** Full repair is useful for maintaining data integrity, even if deletions never occur.

-   Use the parallel and partitioner range options, unless precluded by the scope of the repair.
-   Run a full repair to eliminate anti-compaction. Anti-compaction is the process of splitting an SSTable into two SSTables, one with repaired data and one with non-repaired data. This has [compaction strategy implications](https://www.datastax.com/dev/blog/anticompaction-in-cassandra-2-1).

    **Note:** Before you can run incremental repair, you must set the repaired state of each SSTable. For instructions, see [Migrating to incremental repairs](opsRepairNodesMigration.md).

-   Run repair frequently enough that every node is repaired before reaching the time specified in the [gc\_grace\_seconds](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#tabProp) setting. Deleted data is properly handled in the cluster if this requirement is met.
-   Schedule routine node repair to minimize cluster disruption.
    -   If possible, schedule repair operation for low-usage hours.
    -   If possible, schedule repair operations on single nodes at a time.
-   Increase the time value setting of gc\_grace\_seconds if data is seldom deleted or overwritten. For these tables, changing the setting will:
    -   Minimizes impact to disk space.
    -   Allow longer interval between repair operations.
-   Mitigate heavy disk usage by configuring nodetool compaction throttling options \([setcompactionthroughput](../tools/toolsSetCompactionThroughput.md) and [setcompactionthreshold](../tools/toolsSetCompactionThreshold.md)\) before running a repair.

Guidelines for running repair on a downed node:

-   Do not use partitioner range, `-pr`.

**Parent topic:** [Manual repair: Anti-entropy repair](../../cassandra/operations/opsRepairNodesManualRepair.md)

