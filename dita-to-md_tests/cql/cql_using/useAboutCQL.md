# Using CQL {#useAboutCQL .concept}

CQL provides an API to Cassandra that is simpler than the Thrift API.

CQL provides an API to Cassandra that is simpler than the Thrift API. The Thrift API and legacy versions of CQL expose the internal storage structure of Cassandra. CQL adds an abstraction layer that hides implementation details of this structure and provides native syntaxes for collections and other common encodings.

## Accessing CQL {#accessing-cql .section}

Common ways to access CQL are:

-   Start [`cqlsh`](startCqlLinuxMac.md), the Python-based command-line client, on the command line of a Cassandra node.
-   Use [`DataStax DevCenter`](https://www.datastax.com/what-we-offer/products-services/devcenter), a graphical user interface.
-   For developing applications, you can use one of the official DataStax C\#, Java, or Python [open-source drivers](https://www.datastax.com/download#dl-datastax-drivers).
-   Use the set\_cql\_version Thrift method for programmatic access.

This document presents examples using `cqlsh`.

-   **[Starting the CQL shell \(cqlsh\)](../../cql/cql_using/useStartingCqlshTOC.md)**  
How to start the CQL shell \(cqlsh\).
-   **[Creating and updating a keyspace](../../cql/cql_using/useCreateKeyspace.md)**  
Creating a keyspace is the CQL counterpart to creating an SQL database.
-   **[Creating a table](../../cql/cql_using/useCreateTableTOC.md)**  
How to create tables to store data.
-   **[Creating a materialized view](../../cql/cql_using/useCreateMV.md)**  
How to create CQL materialized views.
-   **[Creating advanced data types in tables](../../cql/cql_using/useAdvancedDataTypesTOC.md)**  
How to create collections and user defined types \(UDTs\) in tables.
-   **[Creating functions](../../cql/cql_using/useCreateFunctionsTOC.md)**  
How to create functions.
-   **[Inserting and updating data](../../cql/cql_using/useInsertDataTOC.md)**  
How to insert data into a table with either regular or JSON data.
-   **[Batching data insertion and updates](../../cql/cql_using/useBatchTOC.md)**  
How to batch insert or update data into a table.
-   **[Querying tables](../../cql/cql_using/useQueryDataTOC.md)**  
How to query data from tables.
-   **[Indexing tables](../../cql/cql_using/useCreateQueryIndexes.md)**  
How to query data from tables using indexes.
-   **[Altering a table](../../cql/cql_using/useAlterTableTOC.md#)**  
How to alter a table to add or delete columns or change table properties.
-   **[Altering a materialized view](../../cql/cql_using/useAlterMV.md)**  
Altering the properties of a materialized view with the ALTER MATERIALIZED VIEW command.
-   **[Altering a user-defined type](../../cql/cql_using/useAlterType.md)**  
Adding columns to a user-defined type with the ALTER TYPE command.
-   **[Removing a keyspace, schema, or data](../../cql/cql_using/useRemoveData.md)**  
Using the DROP and DELETE commands.
-   **[Securing a table](../../cql/cql_using/useSecureTOC.md)**  
How to secure a table.
-   **[Tracing consistency changes](../../cql/cql_using/useTracing.md)**  
This tutorial shows the difference between these consistency levels and the number of replicas that participate to satisfy a request.
-   **[Displaying rows from an unordered partitioner with the TOKEN function](../../cql/cql_using/useToken.md)**  
 How to use CQL to display rows from an unordered partitioner.
-   **[Determining time-to-live \(TTL\) for a column](../../cql/cql_using/useTTL.md)**  
How to insert and retrieve data pertaining to TTL for columns.
-   **[Determining the date/time of a write](../../cql/cql_using/useWritetime.md)**  
Using the WRITETIME function in a SELECT statement to determine when the date/time that the column was written to the database.
-   **[Legacy tables](../../cql/cql_using/useLegacyTableTOC.md)**  
How to work with legacy tables.

