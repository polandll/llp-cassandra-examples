# Inserting simple data into a table {#useInsertSimple .task}

Inserting set data with the INSERT command.

In a production database, inserting columns and column values programmatically is more practical than using `cqlsh`, but often, testing queries using this SQL-like shell is very convenient.

Insertion, update, and deletion operations on rows sharing the same partition key for a table are performed atomically and in isolation.

-   To insert simple data into the table cycling.cyclist\_name, use the `INSERT` command. This example inserts a single record into the table.

    ```
    cqlsh> INSERT INTO cycling.cyclist_name (id, lastname, firstname) VALUES (5b6962dd-3f90-4c93-8f61-eabfa4a803e2, 'VOS','Marianne');
    ```

-   You can insert complex string constants using double dollar signs to enclose a string with quotes, backslashes, or other characters that would normally need to be escaped.

    ```language-cql
    cqlsh> INSERT INTO cycling.calendar (race_id, race_start_date, race_end_date, race_name) VALUES 
      (201, '2015-02-18', '2015-02-22', $$Women's Tour of New Zealand$$);
    ```


**Parent topic:** [Inserting and updating data](../../cql/cql_using/useInsertDataTOC.md)

