# Using a CQL legacy table query {#useCQL3QueryLegacyTables .concept}

Using CQL to query a legacy table.

Using CQL, you can query a legacy table. A legacy table managed in CQL includes an implicit WITH COMPACT STORAGE directive. When you use CQL to query legacy tables with no column names defined for data within a partition, Cassandra generates the names \(column1 and value1\) for the data. Using the [RENAME](../cql_reference/cqlAlterTable.md#renaming-a-column)clause, you can change the default column name to a more meaningful name.

```
ALTER TABLE users RENAME userid to user_id;
```

CQL supports [dynamic tables](/en/archived/cassandra/1.1/docs/ddl/column_family.html#dynamic-column-families) created in the Thrift API, CLI, and earlier CQL versions. For example, a dynamic table is represented and queried like this:

```
CREATE TABLE clicks (
  userid uuid,
  url text,
  timestamp date,
  PRIMARY KEY  (userid, url ) ) WITH COMPACT STORAGE;

INSERT INTO clicks (userid, url,timestamp) VALUES (148e9150-1dd2-11b2-0000-242d50cf1fff,'http://google.com', '2016-02-03');

SELECT url, timestamp FROM clicks WHERE  userid = 148e9150-1dd2-11b2-0000-242d50cf1fff;

SELECT timestamp FROM clicks WHERE  userid = 148e9150-1dd2-11b2-0000-242d50cf1fff AND url = 'http://google.com';

SELECT timestamp FROM clicks WHERE  userid = 148e9150-1dd2-11b2-0000-242d50cf1fff AND url > 'http://google.com';
```

**Parent topic:** [Legacy tables](../../cql/cql_using/useLegacyTableTOC.md)

