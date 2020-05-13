# Expiring data with time-to-live {#useExpire .concept}

Use time-to-live \(TTL\) to expire data in a column or table.

Columns and tables support an optional expiration period called TTL \(time-to-live\); TTL is not supported on counter columns. Define the TTL value in seconds. Data expires once it exceeds the TTL period and is then marked with a [tombstone](/en/glossary/doc/glossary/gloss_tombstone.html). Expired data continues to be available for read requests during the grace period, see [gc\_grace\_seconds](../cql_reference/cqlCreateTable.md#cqlTableGc_grace_seconds). Normal compaction and repair processes automatically remove the tombstone data.

**Note:** 

-   TTL precision is one second, which is calculated by the coordinator node. When using TTL, ensure that all nodes in the cluster have synchronized clocks.
-   A very short TTL is not very useful.

-   Expiring data uses additional 8 bytes of memory and disk space to record the TTL and grace period.


## Setting a TTL for a specific column { .section .title2}

Use CQL to [set the TTL](useTTL.md).

To change the TTL of a specific column, you must re-insert the data with a new TTL. Cassandra upserts the column with the new TTL.

To remove TTL from a column, set TTL to zero. For details, see the [UPDATE](../cql_reference/cqlUpdate.md) documentation.

## Setting a TTL for a table { .section .title2}

Use [CREATE TABLE](../cql_reference/cqlCreateTable.md#) or [ALTER TABLE](../cql_reference/cqlAlterTable.md) to define the [default\_time\_to\_live](../cql_reference/cqlCreateTable.md#cqlTableDefaultTTL) property for all columns in a table. If any column exceeds TTL, the entire table is tombstoned.

For details and examples, see [Expiring data with TTL example](useExpireExample.md).

-   **[Expiring data with TTL example](../../cql/cql_using/useExpireExample.md)**  
 Using the INSERT and UPDATE commands for setting the expire time for data in a column.
-   **[Inserting data using COPY and a CSV file](../../cql/cql_using/useInsertCopyCSV.md)**  
Inserting data with the cqlsh command COPY from a CSV file is common for testing queries.

**Parent topic:** [Inserting and updating data](../../cql/cql_using/useInsertDataTOC.md)

