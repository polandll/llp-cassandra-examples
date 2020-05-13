# CREATE USER \(Deprecated\) {#cqlCreateUser .reference}

Create a new user.

`CREATE USER` is supported for backwards compatibility only. Authentication and authorization for Cassandra 2.2 and later are based on `ROLES`, and use `CREATE ROLE` instead.

`CREATE USER` defines a new database user account. By default users accounts do not have [superuser](/en/glossary/doc/glossary/gloss_superuser.html) status. Only a superuser can issue `CREATE USER` requests. See [CREATE ROLE](cqlCreateRole.md) for more information about `SUPERUSER` and `NOSUPERUSER`.

User accounts are required for logging in under [internal authentication](/en/cassandra-oss/3.0/cassandra/configuration/secureConfigNativeAuth.html) and authorization.

Enclose the user name in single quotation marks if it contains non-alphanumeric characters. You cannot recreate an existing user. To change the superuser status or password, use [ALTER USER](cqlAlterUser.md).

## Synopsis { .refsyn}

```
CREATE USER [IF NOT EXISTS] user\_name 
WITH PASSWORD 'password' 
[SUPERUSER | NOSUPERUSER]
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

## Examples {#creating-internal-user-accounts .section}

Creating internal user accounts

Use `WITH PASSWORD` to create a user account for internal authentication. Enclose the password in single quotation marks.

```
CREATE USER spillman WITH PASSWORD 'Niner27';
CREATE USER akers WITH PASSWORD 'Niner2' SUPERUSER;
CREATE USER boone WITH PASSWORD 'Niner75' NOSUPERUSER;
```

If internal authentication has not been set up, `WITH PASSWORD` is not required.

```
CREATE USER test NOSUPERUSER;
```

Creating a user account conditionally

In Cassandra 2.0.9 and later, you can test that the user does not have an account before attempting to create one. Attempting to create an existing user results in an invalid query condition unless the IF NOT EXISTS option is used. If the option is used, the statement will be a no-op if the user exists.

```
$ bin/cqlsh -u cassandra -p cassandra
Connected to Test Cluster at 127.0.0.1:9042.
[cqlsh 5.0.1 | Cassandra 2.1.0 | CQL spec 3.3.0 | Native protocol v3]
Use HELP for help.

cqlsh> CREATE USER newuser WITH PASSWORD 'password';

cqlsh> CREATE USER newuser WITH PASSWORD 'password';
code=2200 [Invalid query] message="User newuser already exists"

cqlsh> CREATE USER IF NOT EXISTS newuser WITH PASSWORD 'password';
cqlsh> 
```

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

