# DROP USER \(Deprecated\) {#cqlDropUser .reference}

Remove a user.

Remove a user.

**Note:** `DROP USER` is supported for backwards compatibility. Authentication and authorization for Cassandra 2.2 and later are based on `ROLES`, and use `DROP ROLE`.

## Synopsis { .refsyn}

```
DROP USER [IF EXISTS] user\_name 
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

## Description {#description .section}

`DROP USER` removes an existing user. Attempting to drop a user that does not exist results in an invalid query condition unless the `IF EXISTS` option is used. If the option is used, the statement will be a no-op if the user does not exist. A user must have appropriate permission to issue a DROP USER statement. Users cannot drop themselves.

Enclose the user name in single quotation marks only if it contains non-alphanumeric characters.

## Examples {#examples .section}

Drop a user if the user exists:

```screen
DROP USER IF EXISTS boone;
```

Drop a user:

```screen
DROP USER montana;
```

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

