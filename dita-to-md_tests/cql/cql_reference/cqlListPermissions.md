# LIST PERMISSIONS {#cqlListPermissions .reference}

Lists role permissions on resources.

Lists all permissions on all resources, a roles permissions on all resources or for a specified resource.

**Restriction:** 

-   Only superusers can list all permissions.
-   Requires `DESCRIBE` permission on the target resources and roles.

## Synopsis {#synopsis .section}

```
LIST privilege
[ON resource\_name]
[OF role\_name] 
[NORECURSIVE]
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

**Tip:** Omit `ON resource\_name to display all related resources` or `OF role\_name` to display all related roles.

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

  role\_name
 :   Selects a role. If the role name has capital letters or special characters enclose it in single quotes.

  NORECURSIVE
 :   Only display permissions granted to the role. By default permissions checks are recursive; it shows direct and inherited permissions.

 ## Example {#example .section}

List all permissions given to coach:

```screen
LIST ALL 
OF coach;
```

Output is:

```
 rolename | resource           | permission
----------+--------------------+------------
    coach | <keyspace field>   |     MODIFY

```

List permissions given to all the roles:

```screen
LIST ALL;
```

Output is:

```
 rolename | resource             | permission
----------+----------------------+------------
    coach |     <keyspace field> |     MODIFY
    manager | <keyspace cyclist> |      ALTER
    manager | <table cyclist.name> |     CREATE
    manager | <table cyclist.name> |      ALTER
    manager | <table cyclist.name> |       DROP
    manager | <table cyclist.name> |     SELECT
    manager | <table cyclist.name> |     MODIFY
    manager | <table cyclist.name> |  AUTHORIZE
    coach |      <all keyspaces> |     SELECT
      
```

List all permissions on the cyclist.name table:

```screen
LIST ALL 
ON cyclist.name;
```

Output is:

```
 username | resource             | permission
----------+----------------------+------------
    manager | <table cyclist.name> |     CREATE
    manager | <table cyclist.name> |      ALTER
    manager | <table cyclist.name> |       DROP
    manager | <table cyclist.name> |     SELECT
    manager | <table cyclist.name> |     MODIFY
    manager | <table cyclist.name> |  AUTHORIZE
    coach |      <all keyspaces> |     SELECT

```

List all permissions on the cyclist.name table and its parents:

```screen
LIST ALL 
ON cyclist.name 
NORECURSIVE;
```

Output is:

```
 username | resource             | permission
----------+----------------------+------------
    manager | <table cyclist.name> |     CREATE
    manager | <table cyclist.name> |      ALTER
    manager | <table cyclist.name> |       DROP
    manager | <table cyclist.name> |     SELECT
    manager | <table cyclist.name> |     MODIFY
    manager | <table cyclist.name> |  AUTHORIZE
    
```

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

