# Moving data to or from other databases {#migrating .concept}

Solutions for migrating from other databases.

Cassandra offers several solutions for migrating from other databases:

-   The [COPY command](/en/cql-oss/3.3/cql/cql_reference/cqlshCopy.html), which mirrors what the PostgreSQL RDBMS uses for file/export import.
-   The [Cassandra bulk loader](../tools/toolsBulkloader.md) provides the ability to bulk load external data into a cluster.

## About the COPY command {#migrating-copy .section}

You can use COPY in CQL shell to load flat file data into Cassandra \(nearly all relational databases have unload utilities that allow table data to be written to OS files\) as well to write Cassandra data to CSV files.

## ETL Tools {#migrating-etl .section}

If you need more sophistication applied to a data movement situation \(more than just extract-load\), then you can use any number of extract-transform-load \(ETL\) solutions that now support Cassandra. These tools provide excellent transformation routines that allow you to manipulate source data in literally any way you need and then load it into a Cassandra target. They also supply many other features such as visual, point-and-click interfaces, scheduling engines, and more.

Many ETL vendors who support Cassandra supply community editions of their products that are free and able to solve many different use cases. Enterprise editions are also available that supply many other compelling features that serious enterprise data users need.

You can freely download and try ETL tools from Jaspersoft, Pentaho, and Talend that all work with Cassandra.

**Parent topic:** [Operations](../../cassandra/operations/operationsTOC.md)

