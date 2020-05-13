# Dropping a user-defined function \(UDF\) {#useDropUDF .task}

How to use the DROP command to delete a user-defined function \(UDF\).

You drop a user-defined function \(UDF\) using the DROP command.

1.  Drop the fLog\(\) function. The conditional option `IF EXISTS` can be included.

    ```
    cqlsh> DROP FUNCTION [IF EXISTS] fLog;
    ```


**Parent topic:** [Removing a keyspace, schema, or data](../../cql/cql_using/useRemoveData.md)

