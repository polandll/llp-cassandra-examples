# Inserting data using COPY and a CSV file {#useInsertCopyCSV .task}

Inserting data with the cqlsh command COPY from a CSV file is common for testing queries.

In a production database, inserting columns and column values programmatically is more practical than using cqlsh, but often, testing queries using this SQL-like shell is very convenient. A comma-delimited file, or CSV file, is useful if several records need inserting. While not strictly an `INSERT` command, it is a common method for inserting data.

1.  Locate your CSV file and [check options to use](../cql_reference/cqlshCopy.md).

    ```
    category|point|id|lastname
    GC|1269|2003|TIRALONGO
    One-day-races|367|2003|TIRALONGO
    GC|1324|2004|KRUIJSWIJK
    ```

2.  To insert the data, using the `COPY` command with CSV data.

    ```
    $ COPY cycling.cyclist_catgory FROM 'cyclist_category.csv' WITH DELIMITER='|' AND HEADER=TRUE
    ```


**Parent topic:** [Expiring data with time-to-live](../../cql/cql_using/useExpire.md)

