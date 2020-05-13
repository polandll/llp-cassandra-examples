# Expiring data with TTL example {#useExpireExample .task}

Using the INSERT and UPDATE commands for setting the expire time for data in a column.

Both the `INSERT` and `UPDATE` commands support setting a time for data in a column to expire. Use CQL to set the expiration time \(TTL\).

-   Use the `INSERT` command to set calendar listing in the calendar table to expire in 86400 seconds, or one day.

    ```
    cqlsh> INSERT INTO cycling.calendar (race_id, race_name, race_start_date, race_end_date) VALUES (200, 'placeholder', '2015-05-27', '2015-05-27') USING TTL 86400;
    ```

-   Extend the expiration period to three days by using the `UPDATE` command and change the race name.

    ```
    cqlsh> UPDATE cycling.calendar USING TTL 259200 
      SET race_name = 'Tour de France - Stage 12' 
      WHERE race_id = 200 AND race_start_date = '2015-05-27' AND race_end_date = '2015-05-27';
    ```

-   Delete a column's existing TTL by setting its value to zero.

    ```
    cqlsh> UPDATE cycling.calendar USING TTL 0 
      SET race_name = 'Tour de France - Stage 12' 
      WHERE race_id = 200 AND race_start_date = '2015-05-27' AND race_end_date = '2015-05-27';
    ```

    You can set a default TTL for an entire table by setting the table's [default\_time\_to\_live](../cql_reference/cqlCreateTable.md#cqlTableDefaultTTL) property. If you try to set a TTL for a specific column that is longer than the time defined by the table TTL, Cassandra returns an error.


**Parent topic:** [Expiring data with time-to-live](../../cql/cql_using/useExpire.md)

