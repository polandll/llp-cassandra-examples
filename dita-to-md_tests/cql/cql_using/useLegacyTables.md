# Working with legacy applications {#useLegacyTables .concept}

Internally, CQL does not change the row and column mapping from the Thrift API mapping. CQL and Thrift use the same storage engine.

Internally, CQL does not change the row and column mapping from the Thrift API mapping. CQL and Thrift use the same storage engine. CQL supports the same query-driven, denormalized data modeling principles as Thrift. Existing applications do not have to be upgraded to CQL. The CQL abstraction layer makes CQL easier to use for new applications. For an in-depth comparison of Thrift and CQL, see ["A Thrift to CQL Upgrade Guide"](https://www.datastax.com/dev/blog/thrift-to-cql3) and [CQL for Cassandra experts](https://www.datastax.com/dev/blog/cql3-for-cassandra-experts).

## Creating a legacy table {#creating-a-legacy-table .section}

You can create legacy \(Thrift/CLI-compatible\) tables in CQL using the COMPACT STORAGE directive. The directive used with the CREATE TABLE command provides backward compatibility with older Cassandra applications; new applications should generally avoid it.

Compact storage stores an entire row in a single column on disk instead of storing each non-primary key column in a column that corresponds to one column on disk. Using compact storage prevents you from adding new columns that are not part of the PRIMARY KEY.

**Parent topic:** [Legacy tables](../../cql/cql_using/useLegacyTableTOC.md)

