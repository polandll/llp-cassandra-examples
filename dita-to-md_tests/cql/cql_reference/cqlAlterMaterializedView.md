# ALTER MATERIALIZED VIEW {#cqlAlterMaterializedView .reference}

Changes the table properties of a materialized view, Cassandra 3.0 and later.

Changes materialized view table properties. The statement returns no results.

**Restriction:** Cassandra does not support changing the name or columns of the materialized view.

## Synopsis {#synopsis .section}

```screen
ALTER MATERIALIZED VIEW [keyspace\_name.] view\_name 
[WITH table\_options]
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

 keyspace\_name
 :   To alter a materialized view in a keyspace other than the current keyspace, put the keyspace name in front of the name of the materialized view, followed by a period.

  view\_name
 :   The name of the new materialized view.

  table\_options
 :   Table options are defined when the materialized view is created. Modify the [table property](cqlCreateTable.md#) in the WITH clause using the following syntax:

    -   Single value:

        ```no-highlight
        option\_name = 'string\_value'
        ```

        Enclose string values in single quotes.

    -   Specify options with multiple subproperties in simple JSON format:

        ```no-highlight
        option\_name = { 
           'subproperty\_name' : 'value', 
           'subproperty\_name' : 'value',
           'subproperty\_name' : 'value' [, ...] }
        ```

    -   Separate multiple options with AND:

        ```no-highlight
        ALTER MATERIALIZED VIEW keyspace\_name.table\_name 
        WITH option\_name = 'string_value'
        AND option\_name = { 
           'subproperty\_name' : 'string\_value', 
           'subproperty\_name' : numeric\_value[, ...] };
        ```


 ## Examples {#modifying-table-properties .section}

Modifying table properties

For an overview of properties that apply to materialized views, see [table\_options](cqlCreateTable.md#).

```no-highlight
ALTER MATERIALIZED VIEW cycling.cyclist_by_age 
WITH comment = 'A most excellent and useful view'
AND bloom_filter_fp_chance = 0.02;
```

Modifying compression and compaction

Use a property map to specify new properties for compression or compaction.

```no-highlight
ALTER MATERIALIZED VIEW cycling.cyclist_by_age 
WITH compression = { 
   'sstable_compression' : 'DeflateCompressor', 
   'chunk_length_kb' : 64 }
AND compaction = {
   'class': 'SizeTieredCompactionStrategy', 
   'max_threshold': 64};
```

Changing caching

You can create and change caching properties using a property map.

This example changes the keys property to `NONE` \(the default is `ALL`\) and changes the rows\_per\_partition property to `15`.

```no-highlight
ALTER MATERIALIZED VIEW cycling.cyclist_by_age 
WITH caching = { 
   'keys' : 'NONE', 
   'rows_per_partition' : '15' };
```

Viewing current materialized view properties

Use DESCRIBE MATERIALIZED VIEW to see all current properties.

```no-highlight
DESCRIBE MATERIALIZED VIEW cycling.cyclist_by_age
```

```no-highlight
CREATE MATERIALIZED VIEW cycling.cyclist_by_age AS
    SELECT age, cid, birthday, country, name
    FROM cycling.cyclist_mv
    WHERE age IS NOT NULL AND cid IS NOT NULL
    PRIMARY KEY (age, cid)
    WITH CLUSTERING ORDER BY (cid ASC)
    AND bloom_filter_fp_chance = 0.02
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = 'A most excellent and useful view'
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.DeflateCompressor'}
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

