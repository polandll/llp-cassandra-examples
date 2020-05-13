# Using a counter {#useCounters .task}

A counter is a special column for storing a number that is changed in increments.

To load data into a counter column, or to increase or decrease the value of the counter, use the UPDATE command. Cassandra rejects USING TIMESTAMP or USING TTL in the command to update a counter column.

-   Create a table for the counter column.

    ```
    cqlsh> USE cycling;
    CREATE TABLE popular_count (
      id UUID PRIMARY KEY,
      popularity counter
      );
    ```

-   Loading data into a counter column is different than other tables. The data is updated rather than inserted.

    ```
    UPDATE cycling.popular_count
     SET popularity = popularity + 1
     WHERE id = 6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47;
    ```

-   Take a look at the counter value and note that popularity has a value of 1.

    ```
    SELECT * FROM cycling.popular_count;
    ```

-   Additional increments or decrements will change the value of the counter column.


**Parent topic:** [Creating a counter table](../../cql/cql_using/useCountersConcept.md)

