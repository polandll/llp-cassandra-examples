# Misuse of BATCH statement {#useBatchBadExample .task}

How to misuse a BATCH statement.

Misused, `BATCH` statements can cause many problems in a distributed database like Cassandra. Batch operations that involve multiple nodes are a definite anti-pattern. Keep in mind which partitions data will be written to when grouping `INSERT` and `UPDATE` statements in a `BATCH` statement. Writing to several partitions might require interaction with several nodes in the cluster, causing a great deal of latency for the write operation.

-   This example shows an anti-pattern since the `BATCH` statement will write to several different partitions, given the partition key id.

    ```
    cqlsh> BEGIN BATCH
    INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES  (6d5f1663-89c0-45fc-8cfd-60a373b01622,'HOSKINS', 'Melissa');
    INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES  (38ab64b6-26cc-4de9-ab28-c257cf011659,'FERNANDES', 'Marcia');
    INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES  (9011d3be-d35c-4a8d-83f7-a3c543789ee7,'NIEWIADOMA', 'Katarzyna');
    INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES  (95addc4c-459e-4ed7-b4b5-472f19a67995,'ADRIAN', 'Vera');
    APPLY BATCH;
    ```

    In this example, four partitions are accessed, but consider the effect of including 100 partitions in a batch - the performance would degrade considerably.


**Parent topic:** [Batching data insertion and updates](../../cql/cql_using/useBatchTOC.md)

