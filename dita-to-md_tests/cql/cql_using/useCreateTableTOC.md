# Creating a table {#useCreateTableTOC}

How to create tables to store data.

In CQL, data is stored in tables containing rows of columns.

-   **[Creating a table](../../cql/cql_using/useCreateTable.md)**  
How to create CQL tables.
-   **[Using the keyspace qualifier](../../cql/cql_using/useKSQualifier.md)**  
To simplify tracking multiple keyspaces, use the keyspace qualifier instead of the USE statement.
-   **[Simple Primary Key](../../cql/cql_using/useSimplePrimaryKeyConcept.md#)**  
A simple primary key consists of only the partition key which determines which node stores the data.
-   **[Composite Partition Key](../../cql/cql_using/useCompositePartitionKeyConcept.md#)**  
A partition key can have a partition key defined with multiple table columns which determines which node stores the data.
-   **[Compound Primary Key](../../cql/cql_using/useCompoundPrimaryKeyConcept.md)**  
A compound primary key consists of a partition key that determines which node stores the data and of clustering column\(s\) which determine the order of the data on the partition.
-   **[Creating a counter table](../../cql/cql_using/useCountersConcept.md)**  
 A counter is a special column for storing a number that is changed in increments.
-   **[Create table with COMPACT STORAGE](../../cql/cql_using/useCompactStorage.md)**  
Create a table that is compatible with the legacy \(Thrift\) storage engine format.
-   **[Table schema collision fix](../../cql/cql_using/useCreateTableCollisionFix.md)**  
How to fix schema collision problems.

**Parent topic:** [Using CQL](../../cql/cql_using/useAboutCQL.md)

