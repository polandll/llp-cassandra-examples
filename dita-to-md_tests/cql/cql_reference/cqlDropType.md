# DROP TYPE {#cqlDropType .reference}

Drop a user-defined type. Cassandra 2.1 and later.

Immediately and irreversibly removes a UDT \(user-defined type\).

**Restriction:** Dropping a user-defined type that is in use by a table or another type is not supported.

## Synopsis {#synopsis .section}

```
DROP TYPE [IF EXISTS] keyspace\_name.type\_name
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

Attempting to drop a type that is in use by a table:

```screen
DROP TYPE cycling.basic_info ;
```

Error message with the table names that contain the type:

```
InvalidRequest: Error from server: code=2200 [Invalid query] message="Cannot drop user type cycling.basic_info as it is still used by table cycling.cyclist_stats"
```

Drop the table:

```screen
DROP TABLE cycling.cyclist_stats ;
```

Drop the type:

```screen
DROP TYPE cycling.basic_info ;
```

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

