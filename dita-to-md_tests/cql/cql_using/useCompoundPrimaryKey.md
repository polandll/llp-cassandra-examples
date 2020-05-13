# Using a compound primary key {#useCompoundPrimaryKey .task}

Use a compound primary key to create columns that you can query to return sorted results.

Use a compound primary key to create multiple columns that you can use to query and return sorted results. If our pro cycling example was designed in a relational database, you would create a cyclists table with a foreign key to the races. In Cassandra, you denormalize the data because joins are not performant in a distributed system. Later, other schema are shown that improve Cassandra performance. Collections and indexes are two data modeling methods. This example creates a cyclist\_category table storing a cyclist's last name, ID, and points for each type of race category. The table uses category for the partition key and points for a single clustering column. This table can be queried to retrieve a list of cyclists and their points in a category, sorted by points.

A compound primary key table can be created in two different ways, as shown.

-   To create a table having a compound primary key, use two or more columns as the primary key. This example uses an additional clause `WITH CLUSTERING ORDER BY` to order the points in descending order. Ascending order is more efficient to store, but descending queries are faster due to the nature of the storage engine.

    ```language-cql
    cqlsh> USE cycling;
    CREATE TABLE cyclist_category ( 
    category text, 
    points int, 
    id UUID, 
    lastname text,     
    PRIMARY KEY (category, points)
    ) WITH CLUSTERING ORDER BY (points DESC);
    ```

    **Note:** The combination of the category and points uniquely identifies a row in the cyclist\_category table. More than one row with the same category can exist as long as the rows contain different pointsvalues.

-   The keyspace name can be used to identify the keyspace in the `CREATE TABLE` statement instead of the `USE` statement.

    ```
    cqlsh> CREATE TABLE cycling.cyclist_category ( 
    category text, 
    points int, 
    id UUID, 
    lastname text,     
    PRIMARY KEY (category, points)
    ) WITH CLUSTERING ORDER BY (points DESC);
    ```

    **Note:** In both of these examples, points is defined as a clustering column. In Cassandra3.0 and earlier, you cannot insert any value larger than 64K bytes into a clustering column.


**Parent topic:** [Compound Primary Key](../../cql/cql_using/useCompoundPrimaryKeyConcept.md)

