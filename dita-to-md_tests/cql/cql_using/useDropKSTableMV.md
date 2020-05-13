# Dropping a keyspace, table or materialized view {#useDropKSTableMV .task}

Steps for dropping keyspace, table or materialized view using the DROP command.

You drop a table or keyspace using the DROP command.

-   Drop the test keyspace.

    ```
    cqlsh> DROP KEYSPACE test;
    ```

-   Drop the cycling.last\_3\_days table.

    ```
    cqlsh> DROP TABLE cycling.last_3_days;
    ```

-   Drop the cycling.cyclist\_by\_age materialized view in Cassandra 3.0 and later.

    ```
    cqlsh> DROP MATERIALIZED VIEW cycling.cyclist_by_age;
    ```


**Parent topic:** [Removing a keyspace, schema, or data](../../cql/cql_using/useRemoveData.md)

