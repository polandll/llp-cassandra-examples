# DROP MATERIALIZED VIEW {#cqlDropMatializedView .reference}

Remove the named materialized view in Cassandra 3.0 and later.

Immediate, irreversible removal of a materialized view, including all data it contains. This operation has no effect on the base table.

**Restriction:** Drop all materialized views associated with a base table before dropping the table.

## Synopsis {#synopsis .section}

```
DROP MATERIALIZED VIEW [IF EXISTS] [keyspace\_name.] view\_name
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

 IF EXISTS
 :   Cassandra checks on whether the specified materialized view exists. If the materialized view does not exist, the operation fails. Optional.

  keyspace\_name
 :   To drop a materialized view in a keyspace other than the current keyspace, put the keyspace name in front of the materialized view name, followed by a period.

  view\_name
 :   The name of the materialized view to drop

 ## Example {#example .section}

```screen
DROP MATERIALIZED VIEW cycling.cyclist_by_age;
```

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

**Related information**  


[Creating a materialized view](../cql_using/useCreateMV.md)

[CREATE MATERIALIZED VIEW](cqlCreateMaterializedView.md)

[ALTER MATERIALIZED VIEW](cqlAlterMaterializedView.md)

