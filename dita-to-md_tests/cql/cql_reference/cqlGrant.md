# GRANT {#cqlGrant .reference}

Defines resource authorization.

Assigns privileges to roles on database resources, such as keyspaces, tables, functions.

**Important:** Permissions apply immediately, even to active client sessions.

## Synopsis {#synopsis .section}

```
GRANT priviledge
ON resource\_name
TO role\_name
```

**Note:** Enclose the role name in single quotation marks if it contains special characters or capital letters.

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

 Access control matrix

Cassandra resources have modelled hierarchy. Grant permissions on a resource higher in the chain to automatically grant that same permission on all resources lower down.

-   **Data resources**: ALL KEYSPACES \> KEYSPACE \> TABLE table\_name.
-   **Functions**: Includes user defined functions and aggregates, ALL FUNCTIONS \> KEYSPACE \> FUNCTION function\_name.
-   **Roles**: ALL ROLES \> ROLE role\_name.
-   **JMX ObjectNames**: ALL MBEANS \> MBEAN pattern \> MBEAN 

**Note:** Types also belong to keyspaces but there are no privileges specific to user defined types.

Not all privileges apply to every type of resource. For instance, `EXECUTE` is only relevant in the context of functions and mbeans. Attempting to grant privileges on a resource that the permission is not applicable results in an error.

The following table shows the relationship between privileges and resources, and describes the resulting permissions.

|Privilege|Resource|Permissions|
|---------|--------|-----------|
|ALL|resource\_name|All operations that are applicable to the resource and its ancestors.|
|CREATE|ALL KEYSPACES|CREATE KEYSPACE and CREATE TABLE in any keyspace.|
|CREATE|KEYSPACE keyspace\_name|CREATE TABLE in specified keyspace.|
|CREATE|ALL FUNCTIONS|CREATE FUNCTION in any keyspace and CREATE AGGREGATE in any keyspace.|
|CREATE|ALL FUNCTIONS IN KEYSPACE keyspace\_name|CREATE FUNCTION and CREATE AGGREGATE in specified keyspace.|
|CREATE|ALL ROLES|CREATE ROLE|
|ALTER|ALL KEYSPACES|ALTER KEYSPACE and ALTER TABLE in any keyspace.|
|ALTER|KEYSPACE keyspace\_name|ALTER KEYSPACE and ALTER TABLE in specified keyspace.|
|ALTER|TABLE table\_name|ALTER TABLE specified table.|
|ALTER|ALL FUNCTIONS|CREATE FUNCTION and CREATE AGGREGATE, also replace existing.|
|ALTER|ALL FUNCTIONS IN KEYSPACE keyspace\_name|CREATE FUNCTION and CREATE AGGREGATE: , also replace existing in specified keyspace|
|ALTER|FUNCTION function\_name|CREATE FUNCTION and CREATE AGGREGATE, also replace existing.|
|ALTER|ALL ROLES|ALTER ROLE on any role|
|ALTER|ROLE role\_name|ALTER ROLE specified role.|
|DROP|ALL KEYSPACES|DROP KEYSPACE and DROP TABLE in any keyspace|
|DROP|KEYSPACE keyspace\_name|DROP TABLE in specified keyspace|
|DROP|TABLE table\_name|DROP TABLE specified.|
|DROP|ALL FUNCTIONS|DROP FUNCTION and DROP AGGREGATE in any keyspace.|
|DROP|ALL FUNCTIONS IN KEYSPACE keyspace\_name|DROP FUNCTION and DROP AGGREGATE in specified keyspace.|
|DROP|FUNCTION function\_name|DROP FUNCTION specified function.|
|DROP|ALL ROLES|DROP ROLE on any role.|
|DROP|ROLE role\_name|DROP ROLE specified role.|
|SELECT|ALL KEYSPACES|SELECT on any table.|
|SELECT|KEYSPACE keyspace\_name|SELECT on any table in specified keyspace.|
|SELECT|TABLE table\_name|SELECT on specified table.|
|SELECT|ALL MBEANS|Call getter methods on any mbean.|
|SELECT|MBEANS pattern|Call getter methods on any mbean matching a wildcard pattern.|
|SELECT|MBEAN mbean\_name|Call getter methods on named mbean.|
|MODIFY|ALL KEYSPACES|INSERT, UPDATE, DELETE and TRUNCATE on any table.|
|MODIFY|KEYSPACE keyspace\_name|INSERT, UPDATE, DELETE and TRUNCATE on any table in specified keyspace.|
|MODIFY|TABLE table\_name|INSERT, UPDATE, DELETE and TRUNCATE on specified table.|
|MODIFY|ALL MBEANS|Call setter methods on any mbean.|
|MODIFY|MBEANS pattern|Call setter methods on any mbean matching a wildcard pattern.|
|MODIFY|MBEAN mbean\_name|Call setter methods on named mbean.|
|AUTHORIZE|ALL KEYSPACES|GRANT PERMISSION and REVOKE PERMISSION on any table.|
|AUTHORIZE|KEYSPACE keyspace\_name|GRANT PERMISSION and REVOKE PERMISSION on any table in specified keyspace.|
|AUTHORIZE|TABLE table\_name|GRANT PERMISSION and REVOKE PERMISSION on specified table.|
|AUTHORIZE|ALL FUNCTIONS|GRANT PERMISSION and REVOKE PERMISSION on any function.|
|AUTHORIZE|ALL FUNCTIONS IN KEYSPACE keyspace\_name|GRANT PERMISSION and REVOKE PERMISSION in specified keyspace.|
|AUTHORIZE|FUNCTION function\_name|GRANT PERMISSION and REVOKE PERMISSION on specified function.|
|AUTHORIZE|ALL MBEANS|GRANT PERMISSION and REVOKE PERMISSION on any mbean.|
|AUTHORIZE|MBEANS pattern|GRANT PERMISSION and REVOKE PERMISSION on any mbean matching a wildcard pattern.|
|AUTHORIZE|MBEAN mbean\_name|GRANT PERMISSION and REVOKE PERMISSION on named mbean|
|AUTHORIZE|ALL ROLES|GRANT ROLE and REVOKE ROLE on any role.|
|AUTHORIZE|ROLES|GRANT ROLE and REVOKE ROLE on specified roles|
|DESCRIBE|ALL ROLES|LIST ROLES on all roles or only roles granted to another, specified role.|
|DESCRIBE|ALL MBEANS|Retrieve metadata about any mbean from the platform's MBeanServer.|
|DESCRIBE|MBEANS pattern|Retrieve metadata about any mbean matching a wildcard patter from the platform's MBeanServer.|
|DESCRIBE|MBEAN mbean\_name|Retrieve metadata about a named mbean from the platform'ss MBeanServer.|
|EXECUTE|ALL FUNCTIONS|SELECT, INSERT and UPDATE using any function, and use of any function in CREATE AGGREGATE.|
|EXECUTE|ALL FUNCTIONS IN KEYSPACE keyspace\_name|SELECT, INSERT and UPDATE using any function in specified keyspace and use of any function in keyspace in CREATE AGGREGATE.|
|EXECUTE|FUNCTION function\_name|SELECT, INSERT and UPDATE using specified function and use of the function in CREATE AGGREGATE.|
|EXECUTE|ALL MBEANS|Execute operations on any mbean.|
|EXECUTE|MBEANS pattern|Execute operations on any mbean matching a wildcard patter.|
|EXECUTE|MBEAN mbean\_name|Execute operations on named mbean.|
|role\_name|resource\_name|Roles are a collection of privileges; grant all the privileges in a role on a any resource.|

## Examples {#examples .section}

In most environments, user authentication is handled by a plug-in that verifies users credentials against an external directory service such as LDAP. The CQL role is mapped to the external group by matching the role name to a group name. For simplicity, these examples use internal users.

Give the role coach permission to perform `SELECT` queries on all tables in all keyspaces:

```
GRANT SELECT ON ALL KEYSPACES TO coach;
```

Give the role manager permission to perform `INSERT`, `UPDATE`, `DELETE` and `TRUNCATE` queries on all tables in the field keyspace.

```
GRANT MODIFY ON KEYSPACE field TO manager;
```

Give the role coach permission to perform `ALTER KEYSPACE` queries on the cycling keyspace, and also `ALTER TABLE`, `CREATE INDEX` and `DROP INDEX` queries on all tables in cycling keyspace:

```
GRANT ALTER ON KEYSPACE cycling TO coach;
```

Give the role coach permission to run all types of queries on cycling.name table.

```
GRANT ALL PERMISSIONS ON cycling.name TO coach;
```

Create an administrator role with full access to cycling.

```
GRANT ALL ON KEYSPACE cycling TO cycling_admin;
```

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

