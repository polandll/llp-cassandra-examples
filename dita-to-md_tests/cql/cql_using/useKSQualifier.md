# Using the keyspace qualifier {#useKSQualifier .task}

To simplify tracking multiple keyspaces, use the keyspace qualifier instead of the USE statement.

Sometimes issuing a USE statement to select a keyspace is inconvenient. Connection pooling requires managing multiple keyspaces. To simplify tracking multiple keyspaces, use the keyspace qualifier instead of the USE statement. You can specify the keyspace using the keyspace qualifier in these statements:

-   ALTER TABLE
-   CREATE TABLE
-   DELETE
-   INSERT
-   SELECT
-   TRUNCATE
-   UPDATE

1.  To specify a table when you are not in the keyspace that contains the table, use the name of the keyspace followed by a period, then the table name. For example, cycling.race\_winners.

    ```
    cqlsh> INSERT INTO cycling.race_winners ( race_name, race_position, cyclist_name ) VALUES (
      'National Championships South Africa WJ-ITT (CN)', 
      1, 
      {firstname:'Frances',lastname:'DU TOUT'}
    );
    
    ```


**Parent topic:** [Creating a table](../../cql/cql_using/useCreateTableTOC.md)

