# Data modeling analysis {#dataModelingAnalysis .concept}

How to analyze a logical data model.

You've created a conceptual model of the entities and their relationships. From the conceptual model, you've used the expected queries to create table schema. The last step in data model involves completing an analysis of the logical design to discover modifications that might be needed. These modifications can arise from understanding partition size limitations, cost of data consistency, and performance costs due to a number of design choices still to be made.

For efficient operation, partitions must be sized within certain limits. Two measures of partition size are the number of values in a partition and the partition size on disk. The maximum number of rows per partition is not theoretically limited, although practical limits can be found with experimentation. Sizing the disk space is more complex, and involves the number of rows and the number of columns, primary key columns and static columns in each table. Each application will have different efficiency parameters, but a good rule of thumb is to keep the maximum number of values below 100,000 items and the disk size under 100MB.

Data redundancy must be considered as well. Two redundancies that are a consequence of Cassandra's distributed design are duplicate data in tables and multiple partition replicates.

Data is generally duplicated in multiple tables, resulting in performance latency during writes and requires more disk space. Consider storing a cyclist's name and id in more than one data, along with other items like race categories, finished races, and cyclist statistics. Storing the name and id in multiple tables results in linear duplication, with two values stored in each table. Table design must take into account the possibility of higher order duplication, such as unlimited keywords stored in a large number of rows. A case of *n* keywords stored in *m* rows is not a good table design. You should rethink the table schema for better design, still keeping the query foremost.

Cassandra replicates partition data based on the replication factor, using more disk space. Replication is a necessary aspect of distributed databases and sizing disk storage correctly is important.

Application-side joins can be a performance killer. In general, you should analyze your queries that require joins and consider pre-computing and storing the join results in an additional table. In Cassandra, the goal is to use one table per query for performant behavior. Lightweight transactions \(LWT\) can also affect performance. Consider whether or not the queries using LWT are necessary and remove the requirement if it is not strictly needed.

**Parent topic:** [CQL data modeling](../../cql/ddl/ddlCQLDataModelingTOC.md)

**Previous topic:** [Data modeling concepts](../../cql/ddl/dataModelingApproach.md)

**Next topic:** [Using CQL](../../cql/cql_using/useAboutCQL.md)

