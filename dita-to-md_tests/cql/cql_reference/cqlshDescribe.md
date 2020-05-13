# DESCRIBE {#cqlshDescribe .reference}

Provides information about the connected Cassandra cluster and objects within the cluster.

DESCRIBE \(shorthand: DESC\) outputs detailed information in CQL format that you can run.

CAUTION:

Verify all settings before executing the full output, some options may be cluster specific in the WITH statement.

## Synopsis {#synopsis .section}

```
DESCRIBE [FULL]  SCHEMA  | CLUSTER 
| KEYSPACES | KEYSPACE keyspace\_name
| TABLES | TABLE [keyspace\_name.]table\_name
| TYPES | TYPE [keyspace\_name.]udt\_name
| FUNCTIONS | FUNCTION [keyspace\_name.]udf\_name
| AGGREGATES | AGGREGATE [keyspace\_name.]uda\_name
| INDEX [keyspace\_name.]index\_name
| MATERIALIZED VIEW [keyspace\_name.]view\_name
```

|Syntax conventions|Description|
|------------------|-----------|
|UPPERCASE|Literal keyword.|
|Lowercase|Not literal.|
|`Italics`|Variable value. Replace with a user-defined value.|
|`[]`|Optional. Square brackets \(`[]`\) surround optional command arguments. Do not type the square brackets.|
|`( )`|Group. Parentheses \( `( )` \) identify a group to choose from. Do not type the parentheses.|
|`|`|Or. A vertical bar \(`|`\) separates alternative elements. Type any one of the elements. Do not type the vertical bar.|
|`...`|Repeatable. An ellipsis \( `...` \) indicates that you can repeat the syntax element as often as required.|
|`'Literal string'`|Single quotation \(`'`\) marks must surround literal strings in CQL statements. Use single quotation marks to preserve upper case.|
|`{ key : value }`|Map collection. Braces \(`{ }`\) enclose map collections or key value pairs. A colon separates the key and the value.|
|`<datatype1,datatype2>`|Set, list, map, or tuple. Angle brackets \( `< >` \) enclose data types in a set, list, map, or tuple. Separate the data types with a comma.|
|`cql\_statement;`|End CQL statement. A semicolon \(`;`\) terminates all CQL statements.|
|`[--]`|Separate the command line options from the command arguments with two hyphens \( `--` \). This syntax is useful when arguments might be mistaken for command line options.|
|`' <schema\> ... </schema\> '`|Search CQL only: Single quotation marks \(`'`\) surround an entire XML schema declaration.|
|`@xml\_entity='xml\_entity\_type'`|Search CQL only: Identify the entity and literal value to overwrite the XML element in the schema and solrConfig files.|

**Note:** On Linux systems object names, such as keyspace names, table names, and so forth are case sensitive. By default, CQL converts names to lowercase unless enclosed in double quotes.

|Options|Description|
|-------|-----------|
|CLUSTER|Cluster information including cluster name, partitioner, and snitch and for non-system keyspaces, the endpoint-range ownership information is also shown.|
|FULL SCHEMA|Details for all objects in the cluster.|
|SCHEMA|Details for all non-system objects in the cluster.|
|KEYSPACES|List of all keyspace names on the cluster.|
|KEYSPACE keyspace\_name|Details for the specified keyspace and objects it contains.|
|TABLES|List of tables in the current keyspace or all tables in the cluster when no keyspace is selected.|
|TABLE keyspace\_name.table\_name|Details on the specified table.**Note:** To [query the system tables](../cql_using/useQuerySystemTable.md), use SELECT.

|
|INDEX keyspace.table|Details on the specified index.|
|TYPES|List of user-defined types in the current keyspace or all user-defined types in the cluster when no keyspace is selected.|
|TYPE keyspace\_name.type\_name|Details on the specified user-defined type.|
|FUNCTIONS|List of user-defined functions in the current keyspace or all user-defined functions in the cluster when no keyspace is selected.|
|FUNCTION keyspace\_name.function\_name|Details on the specified user-defined function.|
|AGGREGATES|List of user-defined aggregates in the current keyspace or all user-defined aggregates in the cluster when no keyspace is selected.|
|AGGREGATE keyspace\_name.aggregate\_name|Details on the specified user-defined aggregate.|
|MATERIALIZED VIEW keyspace\_name.view\_name|Details on the specified materialized view.|

## Examples {#examples .section}

Show all keyspaces:

```screen
DESC keyspaces
```

All the keyspaces on the cluster are listed.

```no-highlight
test_cycling   system_auth       test
cycling    system_schema  system       system_distributed  system_traces
```

Show details for the Cycling Calendar table:

```screen
DESC cycling.calendar
```

A complete table description in CQL that can be used to recreated the table is returned.

```no-highlight
CREATE TABLE cycling.calendar (
    race_id int,
    race_start_date timestamp,
    race_end_date timestamp,
    race_name text,
    PRIMARY KEY (race_id, race_start_date, race_end_date)
) WITH CLUSTERING ORDER BY (race_start_date ASC, race_end_date ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99PERCENTILE';
```

**Parent topic:** [CQL shell commands](../../cql/cql_reference/cqlshCommandsTOC.md)

