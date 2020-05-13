# TRUNCATE {#cqlTruncate .reference}

Remove all data from a table.

Removes all data from the specified table immediately and irreversibly, and removes all data from any materialized views derived from that table.

## Synopsis {#synopsis .section}

```
TRUNCATE [TABLE] [keyspace\_name.table\_name]
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

## Examples {#examples .section}

To remove all data from a table without dropping the table:

1.  If necessary, use the cqlsh [CONSISTENCY](cqlshConsistency.md) command to set the consistency level to `ALL`.
2.  Use [nodetool status](/en/cassandra-oss/3.0/cassandra/tools/toolsStatus.html) or some other tool to make sure all nodes are up and receiving connections.
3.  Use TRUNCATE or TRUNCATE TABLE, followed by the table name. For example:

    ```screen
    TRUNCATE cycling.user_activity;
    ```

    ```screen
    TRUNCATE TABLE cycling.user_activity;
    ```


**Note:** TRUNCATE sends a JMX command to all nodes, telling them to delete SSTables that hold the data from the specified table. If any of these nodes is down or doesn't respond, the command fails and outputs a message like the following:

```
truncate cycling.user_activity;
Unable to complete request: one or more nodes were unavailable.
```

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

