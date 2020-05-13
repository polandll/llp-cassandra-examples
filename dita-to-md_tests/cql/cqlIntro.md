# Introduction to Cassandra Query Language {#cqlIntro .concept}

Cassandra Query Language \(CQL\) is a query language for the Cassandra database.

## About this document {#welcome .section}

Welcome to the CQL documentation provided by DataStax. To ensure that you get the best experience in using this document, take a moment to look at the [Tips for using DataStax documentation](/en/landing_page/doc/landing_page/docTips.html).

The [landing pages](/en) provide information about supported platforms, product compatibility, planning and testing cluster deployments, recommended production settings, troubleshooting, third-party software, resources for additional information, administrator and developer topics, and earlier documentation.

## Overview of the Cassandra Query Language {#cql-overview .section}

Cassandra Query Language \(CQL\) is a query language for the Cassandra database. This release of CQL works with Cassandra 3.x.

The Cassandra Query Language \(CQL\) is the primary language for communicating with the Cassandra database. The most basic way to interact with Cassandra is using the CQL shell, cqlsh. Using cqlsh, you can create keyspaces and tables, insert and query tables, plus much more. If you prefer a graphical tool, you can use [DataStax DevCenter](/en/archived/developer/devcenter/doc/devcenter/features.html). For production, DataStax supplies a number of [drivers](/en/developer/driver-matrix/doc/common/driverMatrix.html) so that CQL statements can be passed from client to cluster and back.

**Important:** This document assumes you are familiar with the [Cassandra 3.x documentation](/en/cassandra-oss/3.x/cassandra/cassandraAbout.html).

| New CQL features

 | -   [JSON support](cql_using/useInsertJSON.md)for CQL3
-   [User Defined Functions](cql_using/useCreateUDF.md) \(UDFs\)
-   [User Defined Aggregates](cql_using/useCreateUDA.md) \(UDAs\)
-   [Role Based Access Control](cql_using/useSecureRoles.md) \(RBAC\)
-   Native Protocol v.4
-   [Materialized Views](cql_using/useCreateMV.md)
-   Addition of [CLEAR](cql_reference/cqlshClear.md) command for cqlsh
-   In Cassandra 3.4 and later, [SSTable Attached Secondary Indexes \(SASI\)](cql_using/useSASIIndex.md) have been introduced for queries that previously required the use of `ALLOW FILTERING`.

 |
| Improved CQL features

 | -   Additional [COPY](cql_reference/cqlshCopy.md) command options
-   New [WITH ID](cql_reference/cqlCreateTable.md#) option with `CREATE TABLE` command
-   Support [IN clause](cql_using/useQueryIN.md) on any partition key column or clustering column
-   Accept [Dollar Quoted Strings](cql_reference/escape_char_r.md)
-   Allow Mixing Token and Partition Key Restrictions
-   Support [Indexing Key/Value Entries on Map Collections](cql_using/useIndexColl.md)
-   [Date data type](cql_reference/timeuuid_functions_r.md) added and improved time/date conversion functions
-   [Tinyint and smallint](cql_reference/cql_data_types_c.md) data types added
-   Change to CREATE TABLE [syntax for compression options](cql_reference/cqlCreateTable.md#)
-   In Cassandra 3.4 and later, static columns can be indexed.
-   In Cassandra 3.6 and later, [clustering columns can be used in WHERE clause without secondary index](cql_using/useQueryColumnsSort.md).
-   In Cassandra 3.6 and later, [individual subfields of a user-defined type \(UDT\) can be updated and deleted](cql_using/useInsertUDT.md) if non-collection fields are used.
-   In Cassandra 3.6 and later, a query can be limited to return results from each partition, such as a "Top 3" listing using [PER PARTITION LIMIT](cql_using/useQueryColumnsSort.md#section_n5f_pgg_gw).
-   In Cassandra 3.10 and later, a [materialized view can be restricted using non-primary key columns](cql_using/useCreateMV.md) in the filtering clause on creation.

 |
| Removed CQL features

 | -   Removal of CQL2
-   Removal of cassandra-cli

 |
| Native protocol

 | -   The Native Protocol has been updated to version 4, with implications for CQL use in the DataStax drivers.

 |

