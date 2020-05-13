# User-defined type {#cqlRefUDType .concept}

A user-defined type facilitates handling multiple fields of related information in a table.

A user-defined type facilitates handling multiple fields of related information in a table. Applications that required multiple tables can be simplified to use fewer tables by using a user-defined type to represent the related fields of information instead of storing the information in a separate table. The [address type](../cql_using/useInsertUDT.md) example demonstrates how to use a user-defined type.

You can create, alter, and drop a user-defined type using these commands:

-   [CREATE TYPE](cqlCreateType.md)
-   [ALTER TYPE](cqlAlterType.md)
-   [DROP TYPE](cqlDropType.md)

The cqlsh utility includes these commands for describing a user-defined type or listing all user-defined types:

-   [DESCRIBE TYPE](cqlshDescribe.md)
-   [DESCRIBE TYPES](cqlshDescribe.md)

The scope of a user-defined type is the keyspace in which you define it. Use dot notation to access a type from a keyspace outside its scope: keyspace name followed by a period followed the name of the type, for example: `test.myType` where `test` is the keyspace name and `myType` is the type name. Cassandra accesses the type in the specified keyspace, but does not change the current keyspace; otherwise, if you do not specify a keyspace, Cassandra accesses the type within the current keyspace.

**Parent topic:** [CQL data types](../../cql/cql_reference/cql_data_types_c.md)

