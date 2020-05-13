# REVOKE {#cqlRevoke .reference}

Remove privileges on database objects from roles.

Remove privileges on database objects, resources, from a role.

## Synopsis {#synopsis .section}

```
REVOKE privilege 
ON resource\_name
FROM role\_name
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

 privilege
 :   Permissions granted on a resource to a role; grant a privilege at any level of the resource hierarchy.

    The full set of available privileges is:

    -   ALL PERMISSIONS
    -   ALTER
    -   AUTHORIZE
    -   CREATE
    -   DESCRIBE
    -   DROP
    -   EXECUTE
    -   MODIFY
    -   SELECT

  resource\_name
 :   Cassandra database objects to which permissions are applied.

    The full list of available objects is:

    -   ALL FUNCTIONS
    -   ALL FUNCTIONS IN KEYSPACE keyspace\_name
    -   FUNCTION function\_name
    -   ALL KEYSPACES
    -   KEYSPACE keyspace\_name
    -   TABLE table\_name
    -   ALL MBEANS
    -   MBEAN mbean\_name
    -   MBEANS pattern
    -   ALL ROLES
    -   ROLE role\_name

 ## Example {#example .section}

```screen
REVOKE SELECT 
ON cycling.name 
FROM manager;
```

The role manager can no longer perform `SELECT` queries on the cycling.name table. Exceptions: Because of inheritance, the user can perform `SELECT` queries on cycling.name if one of these conditions is met:

-   The user is a superuser.
-   The user has `SELECT` on `ALL KEYSPACES` permissions.
-   The user has `SELECT` on the cycling keyspace.

```screen
REVOKE ALTER 
ON ALL ROLES 
FROM coach;
```

The role coach can no longer perform `GRANT`, `ALTER` or `REVOKE` commands on all roles.

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

