# DROP TABLE {#cqlDropTable .reference}

Remove the named table.

Immediate, irreversible removal of a table, including all data contained in the table.

**Note:** The alias DROP COLUMNFAMILY has been deprecated.

**Restriction:** In Cassandra 3.0 and later, you must drop any [drop materialized view](cqlDropMatializedView.md) associated with the table before dropping the table.

## Synopsis {#synopsis .section}

```
DROP TABLE [IF EXISTS] keyspace\_name.table\_name
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

## Example {#example .section}

Attempting to drop a table with materialized views that are based on it:

```screen
DROP TABLE cycling.cyclist_mv ;
```

Error message lists the materialized views that are based on this table:

```
InvalidRequest: Error from server: code=2200 [Invalid query] message="Cannot drop table when materialized views still depend on it (cycling.{cyclist_by_age,cyclist_by_country})"
```

Drop the cyclist\_name table:

```screen
DROP TABLE cycling.cyclist_name;
```

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

