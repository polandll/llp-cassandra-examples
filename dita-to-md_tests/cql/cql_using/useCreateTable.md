# Creating a table {#useCreateTable .concept}

How to create CQL tables.

In CQL, data is stored in tables containing rows of columns, similar to SQL definitions.

**Note:** The concept of rows and columns in the internal implementation of Cassandra are **not** the same. For more information, see [A thrift to CQL3 upgrade guide](https://www.datastax.com/dev/blog/thrift-to-cql3) or [CQL3 for Cassandra experts](https://www.datastax.com/dev/blog/cql3-for-cassandra-experts).

Tables can be created, dropped, and altered at runtime without blocking updates and queries. To create a table, you must define a primary key and other data columns. Add the optional `WITH` clause and keyword arguments to configure table properties \(caching, compaction, etc.\). See the [table\_options](../cql_reference/cqlCreateTable.md#) page for details.

## Create schema using cqlsh {#createSchema .section}

Create table schema using `cqlsh`. Cassandra does not support dynamic schema generation — collision can occur if multiple clients attempt to generate tables simultaneously. To recover from collisions, follow the instructions in [schema collision fix](useCreateTableCollisionFix.md).

## Primary Key { .section}

A [primary key](/en/glossary/doc/glossary/gloss_primary_key.html) identifies the location and order of stored data. The primary key is defined when the table is created and cannot be altered. If you must change the primary key, create a new table schema and write the existing data to the new table. See [ALTER TABLE](../cql_reference/cqlAlterTable.md) for details on altering a table after creation.

Cassandra is a partition row store. The first element of the primary key, the partition key, specifies which node will hold a particular table row. At the minimum, the primary key must consist of a [partition key](/en/glossary/doc/glossary/gloss_partition_key.html). You can define a compound partition key to split a data set so that related data is stored on separate partitions. A compound primary key includes [clustering columns](/en/glossary/doc/glossary/gloss_clustering_column.html) which order the data on a partition.

**Note:** In Cassandra3.0 and earlier, you cannot insert any value larger than 64K bytes into a clustering column.

The definition of a table's primary key is critical in Cassandra. Carefully model how data in a table will be inserted and retrieved before choosing which columns to define in the primary key. The size of the partitions, the order of the data within partitions, the distribution of the partitions among the nodes of the cluster — you must consider all of these when selecting the table's primary key.

## Table characteristics {#tableCharacteristics .section}

The name of a table can be a string of alphanumeric characters and underscores, but it must begin with a letter. Tips for the table name:

-   To specify the keyspace that contains the table, put the keyspace name followed by a period before the table name: keyspace\_name.table\_name. This allows you to create a new table in a keyspace that is different from the one set for the current session \(by the USE command, for example\).
-   To create a table in the current keyspace, just use the new table name.

## Column characteristics {#columnCharacteristics .section}

CQL supports several column types. You assign a [data type](../cql_reference/cql_data_types_c.md) to each column when you create a table. The table definition defines \(non-collection\) columns in a comma-delimited list of name and type pairs. The following example illustrates three data types, UUID, text and timestamp:

```
CREATE TABLE cycling.cyclist_alt_stats ( id UUID PRIMARY KEY, lastname text, birthday timestamp, nationality text, weight text, height text );
```

CQL supports the following collection column types: map, set, and list. A collection column is defined using the collection type, followed by another type, such as int or text, in angle brackets. The collrection column definition is included in the column list as described above. The following example illustrates each collection type, but is not designed for an actual query:

```
CREATE TABLE cycling.whimsey ( id UUID PRIMARY KEY, lastname text, cyclist_teams set<text>, events list<text>, teams map<int,text> );
```

Collection types cannot be nested. Collections can include frozen data types. For examples and usage, see [Collection type](../cql_reference/collection_type_r.md)

A column of type tuple holds a fixed-length set of typed positional fields. Use a tuple as an alternative to a user-defined type. A tuple can accommodate many fields \(32768\) — although it would not be a good idea to usse this many. A typical tuple holds 2 to 5 fields. Specify a tuple in a table definition, using angle brackets; within thesse, use a comma-delimited list to define each component type. Tuples can be nested. The following example illustrates a tuple type composed of a text field and a nested tuple of two float fields:

```
CREATE TABLE cycling.route (race_id int, race_name text, point_id int, lat_long tuple<text, tuple<float,float>>, PRIMARY KEY (race_id, point_id));
```

**Note:** Cassandra no longer requires the use of frozen for tuples:

```
frozen <tuple <int, tuple<text, double>>>
```

For more information, see ["Tuple type"](../cql_reference/tupleType.md).

Create a User-defined type \(UDTs\) as a data type of several fields, using [CREATE TYPE](../cql_reference/cqlCreateType.md). It is best to create a UDT for use with multiple table definitions. The user-defined column type \(UDT\) requires the frozen keyword. A frozen value serializes multiple components into a single value. Non-frozen types allow updates to individual fields. Cassandra treats the value of a frozen type as a blob. The entire value must be overwritten. The scope of a user-defined type is the keyspace in which you define it. Use dot notation to access a type from a keyspace outside its scope: keyspace name followed by a period followed the name of the type, for example: `test.myType` where `test` is the keyspace name and `myType` is the type name. Cassandra accesses the type in the specified keyspace, but does not change the current keyspace; otherwise, if you do not specify a keyspace, Cassandra accesses the type within the current keyspace. For examples and usage information, see ["Using a user-defined type"](useInsertUDT.md).

A counter is a special column used to store a number that is changed in increments. A counter can only be used in a dedicated table that includes a column of [counter data type](../cql_reference/counter_type.md). For more examples and usage information, see ["Using a counter"](useCountersConcept.md).

**Parent topic:** [Creating a table](../../cql/cql_using/useCreateTableTOC.md)

