# Inserting tuple data into a table {#useInsertTuple .task}

Tuples are used to group small amounts of data together that are then stored in a column.

-   Insert data into the table cycling.route which has tuple data. The tuple is enclosed in parentheses. This tuple has a tuple nested inside; nested parentheses are required for the inner tuple, then the outer tuple.

    ```
    cqlsh> INSERT INTO cycling.route (race_id, race_name, point_id, lat_long) VALUES (500, '47th Tour du Pays de Vaud', 2, ('Champagne', (46.833, 6.65)));
    ```

-   Insert data into the table cycling.nation\_rank which has tuple data. The tuple is enclosed in parentheses. The tuple called info stores the rank, name, and point total of each cyclist.

    ```
    cqlsh> INSERT INTO cycling.nation_rank (nation, info) VALUES ('Spain', (1,'Alejandro VALVERDE' , 9054));
    ```

-   Insert data into the table popular which has tuple data. The tuple called cinfo stores the country name, cyclist name, and points total.

    ```
    cqlsh> INSERT INTO cycling.popular (rank, cinfo) VALUES (4, ('Italy', 'Fabio ARU', 163));
    ```


**Parent topic:** [Inserting and updating data](../../cql/cql_using/useInsertDataTOC.md)

