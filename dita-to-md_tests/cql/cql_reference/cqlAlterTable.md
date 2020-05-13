# ALTER TABLE {#cqlAlterTable .reference}

Modifies the columns and properties of a table.

Changes the datatype of a columns, add new columns, drop existing columns, renames columns, and change table properties. The command returns no results.

**Restriction:** Altering PRIMARY KEY columns is not supported. Altering columns in a table that has a materialized view is not supported.

**Note:** `ALTER COLUMNFAMILY` is deprecated.

## Synopsis {#synopsis .section}

```
ALTER TABLE [keyspace\_name.] table\_name 
[ALTER column\_name TYPE cql\_type]
[ADD (column\_definition\_list)]
[DROP (column\_list)]
[RENAME column\_name TO column\_name]
[WITH table\_properties];
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

 ALTER column\_name TYPE cql\_type
 :   column\_name

    Name of column to alter.

    cql\_type

    Change column data type to a compatible type.

    **Note:** Cassandra does not support changing the type of collections \(lists, sets and maps\) and counters.

    |CQL Type|Constants supported|Description|
    |--------|-------------------|-----------|
    |ascii|strings|US-ASCII character string|
    |bigint|integers|64-bit signed long|
    |blob|blobs|Arbitrary bytes \(no validation\), expressed as hexadecimal|
    |boolean|booleans|true or false|
    |counter|integers|Distributed counter value \(64-bit long\)|
    |date|strings|Value is a date with no corresponding time value; Cassandra encodes date as a 32-bit integer representing days since epoch \(January 1, 1970\). Dates can be represented in queries and inserts as a string, such as 2015-05-03 \(yyyy-mm-dd\)|
    |decimal|integers, floats|Variable-precision decimalJava type

**Note:** When dealing with currency, it is a best practice to have a currency class that serializes to and from an int or use the Decimal form.

|
    |double|integers, floats|64-bit IEEE-754 floating pointJava type

|
    |float|integers, floats|32-bit IEEE-754 floating pointJava type

|
    |frozen|user-defined types, collections, tuples|A frozen value serializes multiple components into a single value. Non-frozen types allow updates to individual fields. Cassandra treats the value of a frozen type as a blob. The entire value must be overwritten.**Note:** Cassandra no longer requires the use of frozen for tuples:

    ```
frozen <tuple <int, tuple<text, double>>>
    ```

|
    |inet|strings|IP address string in IPv4 or IPv6 format, used by the python-cql driver and CQL native protocols|
    |int|integers|32-bit signed integer|
    |list|n/a|A collection of one or more ordered elements: \[literal, literal, literal\]. CAUTION:

Lists have limitations and specific performance considerations. Use a frozen list to decrease impact. In general, use a [set](http://cassandra.apache.org/doc/latest/cql/types.html#sets) instead of list.

|
    |map|n/a|A JSON-style array of literals: \{ literal : literal, literal : literal ... \}|
    |set|n/a|A collection of one or more elements: \{ literal, literal, literal \}|
    |smallint|integers|2 byte integer|
    |text|strings|UTF-8 encoded string|
    |time|strings|Value is encoded as a 64-bit signed integer representing the number of nanoseconds since midnight. Values can be represented as strings, such as 13:30:54.234.|
    |timestamp|integers, strings|Date and time with millisecond precision, encoded as 8 bytes since epoch. Can be represented as a string, such as 2015-05-03 13:30:54.234.|
    |timeuuid|uuids|Version 1 UUID only|
    |tinyint|integers|1 byte integer|
    |tuple|n/a|Cassandra 2.1 and later. A group of 2-3 fields.|
    |uuid|uuids|A UUID in [standard UUID](http://en.wikipedia.org/wiki/Universally_unique_identifier) format|
    |varchar|strings|UTF-8 encoded string|
    |varint|integers|Arbitrary-precision integerJava type

|

  ADD \(column\_definition\_list\)
 :   Add one or more columns and set the data type, enter the name followed by the data types. The value is automatically set to null. To add multiple columns, use a comma separated list.

    ```
    column\_name cql\_type [,]
    [column\_name cql\_type [, ...]
    ```

    **Restriction:** Adding PRIMARY KEYs is not supported once a table has been created.

  DROP \(column\_list\)
 :   Comma separated list of columns to drop. The values contained in the row are also dropped and not recoverable.

  RENAME column\_name TO column\_name
 :   Changes the name of a column and preserves the existing values.

  table\_properties
 :   After a table has been created, you can modify the properties. There are two types of properties, a single option that is set equal to a value:

```
option\_name = value [AND ...]
```

For example, `speculative_retry = '10ms'`. Enclose the value for a string property in single quotation marks.

    Some table properties are defined as a map in simple JSON format:

    ```
    option_name = { subproperty\_name : value [, ...]}
    ```

    See [table\_options](cqlCreateTable.md#) for more details.

 ## Examples {#section_examples .section}

Specifying the table and keyspace

You can qualify the table name by prepending the name of its keyspace. For example, to specify the `teams` table in the `cycling` keyspace:

```
ALTER TABLE cycling.teams ALTER ID TYPE uuid;
```

Changing the type of a column

Change the column data type to a [compatible](cql_data_types_c.md#cql_data_type_compatibility) type.

Change the birthday timestamp column to type blob.

```screen
ALTER TABLE cycling.cyclist_alt_stats 
ALTER birthday TYPE  blob;
```

You can only change the datatype of a column when the column already exists. When a column's datatype changes, the bytes stored in values for that column remain unchanged. If existing data cannot be deserialized to conform to the new datatype, the CQL driver or interface returns errors.

**Warning:** 

Altering the type of a column after inserting data can confuse CQL drivers/tools if the new type is incompatible with the data just inserted.

## Adding a column {#adding-a-column .section}

To add a column \(other than a column of a collection type\) to a table, use the ADD instruction:

```screen
ALTER TABLE cycling.cyclist_races 
ADD firstname text;
```

To add a column of a collection type:

```screen
ALTER TABLE cycling.upcoming_calendar 
ADD events list<text>;
```

This operation does not validate the existing data.

You cannot use the ADD instruction to add:

-   A column with the same name as an existing column
-   A static column

## Dropping a column {#dropping-a-column .section}

To remove a column from the table, use the DROP instruction:

```screen
ALTER TABLE cycling.basic_info 
DROP birth_year;
```

DROP removes the column from the table definition and marks the column values with [tombstones](/en/glossary/doc/glossary/gloss_tombstone.html). The column becomes unavailable for queries immediately after it is dropped. Cassandra drops the column data during the next compaction. To force the removal of dropped columns before compaction occurs, use ALTER TABLE to update the metadata, and then run [nodetool upgradesstables](/en/cassandra-oss/3.0/cassandra/tools/toolsUpgradeSstables.html) to put the drop into effect.

**Restriction:** 

-   If you drop a column then re-add it, Cassandra does not restore the values written before the column was dropped.
-   Do not re-add a dropped column that contained timestamps generated by a client; you can re-add columns with timestamps generated by Cassandra's [write time](../cql_using/useWritetime.md) facility.
-   You cannot drop columns from tables defined with the [COMPACT STORAGE](cqlCreateTable.md#cql-compact-storage) option.

## Renaming a column {#renaming-a-column .section}

The main purpose of RENAME is to change the names of CQL-generated primary key and column names that are missing from a [legacy table](../cql_using/useLegacyTables.md). The following restrictions apply to the RENAME operation:

-   You can only rename clustering columns, which are part of the primary key.
-   You cannot rename the partition key.
-   You can index a renamed column.
-   You cannot rename a column if an index has been created on it.
-   You cannot rename a static column, since you cannot use a static column in the table's primary key.

## Modifying table properties {#modifying-table-properties .section}

To change the table storage properties set when the table was created, use one of the following formats:

-   Use ALTER TABLE and a WITH instruction that introduces the property name and value.
-   Use ALTER TABLE WITH and a property map, as shown in the [next section on compression and compaction](cqlAlterTable.md#alter-compression).

This example uses the WITH instruction to modify the read\_repair\_chance property, which configures [read repair](/en/cassandra-oss/3.0/cassandra/operations/opsRepairNodesReadRepair.html) for tables that use for a non-quorum consistency and how to change multiple properties using AND:

```screen
ALTER TABLE cyclist_mv
  WITH comment = 'ID, name, birthdate and country'
     AND read_repair_chance = 0.2;
```

Enclose a text property value in single quotation marks. You cannot modify properties of a table that uses [COMPACT STORAGE](cqlCreateTable.md#cql-compact-storage).

## Modifying compression and compaction {#alter-compression .section}

Use a property map to alter a table's compression or compaction setting:

```screen
ALTER TABLE cycling_comments 
WITH compression = { 
   'sstable_compression' : 'DeflateCompressor', 
   'chunk_length_kb' : 64 };
```

Enclose the name of each key in single quotes. If the value is a string, enclose this in quotes as well.

CAUTION:

If you change the compaction strategy of a table with existing data, Cassandra rewrites all existing SSTables using the new strategy. This can take hours, which can be a major problem for a production system. For strategies to minimize this disruption, see [How to change Cassandra compaction strategy on a production cluster](http://blog.alteroot.org/articles/2015-04-20/change-cassandra-compaction-strategy-on-production-cluster.html) and [Impact of Changing Compaction Strategy](https://groups.google.com/forum/#!topic/nosql-databases/iYPoy-06Qvs).

## Changing caching {#alter-caching .section}

Create and change the caching options using a property map to optimize queries that return 10.

```screen
ALTER TABLE cycling.events 
   WITH caching = {
    'keys': 'NONE', 
    'rows_per_partition': 10 };
```

## Reviewing the table definition {#reviewTableDef .section}

Use DESCRIBE to view the table definition.

```screen
cqlsh:cycling> desc table cycling.events ;
```

The details including the column names is returned.

```
CREATE TABLE cycling.events (
    month int,
    end timestamp,
    class text,
    title text,
    location text,
    start timestamp,
    type text,
    PRIMARY KEY (month, end, class, title)
) WITH CLUSTERING ORDER BY (end ASC, class ASC, title ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'NONE', 'rows_per_partition': '10'}
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

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

