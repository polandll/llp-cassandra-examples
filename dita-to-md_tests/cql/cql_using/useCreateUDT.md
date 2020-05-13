# Creating a user-defined type \(UDT\) {#useCreateUDT .task}

User-Defined Types \(UDTs\) can be used to attach multiple data fields to a column.

In Cassandra 2.1 and later, user-defined types \(UDTs\) can attach multiple data fields, each named and typed, to a single column. The fields used to create a UDT may be any valid data type, including collections and other existing UDTs. Once created, UDTs may be used to define a column in a table.

-   Use the cycling keyspace.

    ```language-cql
    cqlsh> USE cycling;
    ```

-   Create a user-defined type named basic\_info.

    ```language-cql
    cqlsh> CREATE TYPE cycling.basic_info (
      birthday timestamp,
      nationality text,
      weight text,
      height text
    );
    ```

-   Create a table for storing cyclist data in columns of type basic\_info. Use the [frozen](../cql_reference/cql_data_types_c.md) keyword in the definition of the user-defined type column. In Cassandra 3.6 and later, the frozen keyword is not required for UDTs that contain only non-collection fields.

    When using the frozen keyword, you cannot update parts of a user-defined type value. The entire value must be overwritten. Cassandra treats the value of a frozen, user-defined type like a blob.

    ```language-cql
    cqlsh> CREATE TABLE cycling.cyclist_stats ( id uuid PRIMARY KEY, lastname text, basics FROZEN<basic_info>);  
    ```

-   A user-defined type can be nested in another column type. This example nests a UDT in a list.

    ```
    CREATE TYPE cycling.race (race_title text, race_date timestamp, race_time text);
    CREATE TABLE cycling.cyclist_races ( id UUID PRIMARY KEY, lastname text, firstname text, races list<FROZEN <race>> );
    ```


**Parent topic:** [Creating advanced data types in tables](../../cql/cql_using/useAdvancedDataTypesTOC.md)

