# Create table with COMPACT STORAGE {#useCompactStorage .concept}

Create a table that is compatible with the legacy \(Thrift\) storage engine format.

Use WITH COMPACT STORAGE to create a table that is compatible with clients written to work with the legacy \(Thrift\) storage engine format.

```
CREATE TABLE sblocks (
  block_id uuid,
  subblock_id uuid,
  data blob,
  PRIMARY KEY (block_id, subblock_id)
)
WITH COMPACT STORAGE;
```

Using the WITH COMPACT STORAGE directive prevents you from defining more than one column that is not part of a compound primary key. A compact table with a primary key that is not compound can have multiple columns that are not part of the primary key.

A compact table that uses a compound primary key must define at least one clustering column. Columns cannot be added nor removed after creation of a compact table. Unless you specify WITH COMPACT STORAGE, CQL creates a table with non-compact storage.

Collections and static columns cannot be used with COMPACT STORAGE tables.

**Parent topic:** [Creating a table](../../cql/cql_using/useCreateTableTOC.md)

