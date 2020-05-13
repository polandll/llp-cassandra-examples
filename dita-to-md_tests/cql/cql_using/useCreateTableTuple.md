# Creating a table with a tuple {#useCreateTableTuple .task}

How to create a table using the tuple data type.

[Tuples](../cql_reference/tupleType.md) are a data type that allow two or more values to be stored together in a column. A user-defined type can be used, but for simple groupings, a tuple is a good choice.

-   Create a table cycling.route using a tuple to store each waypoint location name, latitude, and longitude.

    ```
    cqlsh> CREATE TABLE cycling.route (race_id int, race_name text, point_id int, lat_long tuple<text, tuple<float,float>>, PRIMARY KEY (race_id, point_id));
    ```

-   Create a table cycling.nation\_rankusing a tuple to store the rank, cyclist name, and points total for a cyclist and the country name as the primary key.

    ```
    CREATE TABLE cycling.nation_rank ( nation text PRIMARY KEY, info tuple<int,text,int> );
    ```

-   The table cycling.nation\_rank is keyed to the country as the primary key. It is possible to store the same data keyed to the rank. Create a table cycling.popular using a tuple to store the country name, cyclist name and points total for a cyclist and the rank as the primary key.

    ```
    CREATE TABLE cycling.popular (rank int PRIMARY KEY, cinfo tuple<text,text,int> );
    ```


**Parent topic:** [Creating advanced data types in tables](../../cql/cql_using/useAdvancedDataTypesTOC.md)

