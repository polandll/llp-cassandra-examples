# Using lightweight transactions {#useInsertLWT .task}

INSERT and UPDATE statements that use the IF clause support lightweight transactions, also known as Compare and Set \(CAS\).

[INSERT](../cql_reference/cqlInsert.md) and [UPDATE](../cql_reference/cqlUpdate.md) statements using the `IF` clause support lightweight transactions, also known as Compare and Set \(CAS\). A common use for lightweight transactions is an insertion operation that must be unique, such as a cyclist's identification. [Lightweight transactions](/en/cassandra-oss/3.0/cassandra/dml/dmlLtwtTransactions.html) should not be used casually, as the latency of operations increases fourfold due to the due to the round-trips necessary between the CAS coordinators.

Cassandra 2.1.1 and later support non-equal conditions for lightweight transactions. You can use <, <=, \>, \>=, != and IN operators in WHERE clauses to query lightweight tables.

It is important to note that using `IF NOT EXISTS` on an `INSERT`, the timestamp will be designated by the lightweight transaction, and [USING TIMESTAMP](../cql_reference/cqlInsert.md#timestamp_ttl) is prohibited.

-   Insert a new cyclist with their id.

    ```
    cqlsh> INSERT INTO cycling.cyclist_name (id, lastname, firstname)
      VALUES (4647f6d3-7bd2-4085-8d6c-1229351b5498, 'KNETEMANN', 'Roxxane')
      IF NOT EXISTS;
    ```

-   Perform a CAS operation against a row that does exist by adding the predicate for the operation at the end of the query. For example, reset Roxane Knetemann's firstname because of a spelling error.

    ```
    cqlsh> UPDATE cycling.cyclist_name
      SET firstname = ‘Roxane’
      WHERE id = 4647f6d3-7bd2-4085-8d6c-1229351b5498
      IF firstname = ‘Roxxane’;
    ```


**Parent topic:** [Inserting and updating data](../../cql/cql_using/useInsertDataTOC.md)

