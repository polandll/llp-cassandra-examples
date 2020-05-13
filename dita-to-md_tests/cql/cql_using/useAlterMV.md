# Altering a materialized view {#useAlterMV .task}

Altering the properties of a materialized view with the ALTER MATERIALIZED VIEW command.

In Cassandra 3.0 and later, a materialized view has [table properties](../cql_reference/cqlCreateTable.md#) like its source tables. Use the `ALTER MATERIALIZED VIEW` command alter the view's properties. Specify updated properties and values in a `WITH` clause. Materialized views do not perform repair, so properties regarding repair are invalid.

-   Alter a materialized view to change the caching properties.

    ```
    cqlsh> ALTER MATERIALIZED VIEW cycling.cyclist_by_birthday WITH caching = {'keys' : 'NONE', 'rows_per_partition' : '15' };
    ```


**Parent topic:** [Using CQL](../../cql/cql_using/useAboutCQL.md)

**Related information**  


[Creating a materialized view](useCreateMV.md)

[CREATE MATERIALIZED VIEW](../cql_reference/cqlCreateMaterializedView.md)

[ALTER MATERIALIZED VIEW](../cql_reference/cqlAlterMaterializedView.md)

[DROP MATERIALIZED VIEW](../cql_reference/cqlDropMatializedView.md)

