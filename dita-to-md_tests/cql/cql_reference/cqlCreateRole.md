# CREATE ROLE {#cqlCreateRole .reference}

Create roles for access control to database objects.

Create roles to manage access control to database resources, such as keyspaces, tables, functions. Use roles to:

-   Define a set of permissions that can be assigned to other roles and mapped to external users.
-   Create login accounts for [internal authentication](/en/cassandra-oss/3.0/cassandra/configuration/secureConfigNativeAuth.html). \(Not recommended for production environments.\)

**Warning:** A full access login account *cassandra* \(password *cassandra*\) is enabled by default; create your own full access role and drop the *cassandra* account.

## Synopsis {#synopsis .section}

```
CREATE ROLE [IF NOT EXISTS] role\_name 
[WITH SUPERUSER = true | false
 | LOGIN = true | false  
 | PASSWORD =  'password' 
 | OPTIONS = option\_map]
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

 role\_name
 :   Use a unique name for the role. Cassandra forces all names to lowercase; enclose in quotes to preserve case or use special characters in the name.

  SUPERUSER
 :   True automatically grants AUTHORIZE, CREATE and DROP permission on ALL ROLES.

    Superusers can only manage roles by default. To manage other resources, you must grant the permission set to that resource. For example, to allow access management for all keyspaces: `GRANT ALL PERMISSIONS ON ALL KEYSPACES TO role\_name`.

    Default: false.

  LOGIN
 :   True allows the role to log in. Use true to create login accounts for [internal authentication](/en/cassandra-oss/3.x/cassandra/configuration/secureConfigNativeAuth.html) PasswordAuthenticator.

    Default: false.

  PASSWORD
 :   Enclose the password in single quotes. Cassandra [internal authentication](/en/cassandra-oss/3.x/cassandra/configuration/secureConfigNativeAuth.html) requires a password.

    **Note:** Roles for users authenticated by an external directory must have login enabled with no password.

  OPTIONS = \{ option\_map \}
 :   Reserved for use with authentication plug-ins. Refer to the authenticator documentation for details.

 ## Examples {#creating-internal-user-accounts .section}

Creating a login account

1.  Create a login role for coach.

    ```screen
    CREATE ROLE coach 
    WITH PASSWORD = 'All4One2day!' 
    AND LOGIN = true;
    ```

    Internal authentication requires the role to have a password.

2.  Verify that the account works by logging in:

    ```screen
    LOGIN coach
    ```

3.  Enter the password at the prompt.

    ```
    Password: 
    ```

4.  The cqlsh prompt includes the role name:

    ```
    coach@cqlsh>
    ```


Creating a role

A best practice when using internal authentication is to create separate roles for permissions and login accounts. Once a role has been created it can be assigned as permission to another role, see GRANT for more details. Roles for externally authenticators users are mapped to the user's group name; LDAP mapping is case sensitive.

Create a role for the cycling *keyspace* administrator, that is a role that has full permission to only the cycling keyspace.

1.  Create the role:

    ```screen
    CREATE ROLE cycling_admin;
    ```

    At this point the role has no permissions. Manage permissions using GRANT and REVOKE.

    **Note:** A role can only modify permissions of another role and can only modify \(GRANT or REVOKE\) role permissions that it also has.

2.  Assign the role full access to the cycling keyspace:

    ```screen
    GRANT ALL PERMISSIONS on KEYSPACE cycling to cycling_admin;
    ```

3.  Now assign the role to the coach.

    ```
    GRANT cycling_admin TO coach;
    ```

    This allows you to manage the permissions of all cycling administrators by modifying the cycling\_admin role.

4.  View the coach's permissions.

    ```screen
    list all permissions of coach;
    ```

    ```
    
     role           | username       | resource           | permission
    ----------------+----------------+--------------------+------------
      cycling_admin |  cycling_admin | <keyspace cycling> |     CREATE
      cycling_admin |  cycling_admin | <keyspace cycling> |      ALTER
      cycling_admin |  cycling_admin | <keyspace cycling> |       DROP
      cycling_admin |  cycling_admin | <keyspace cycling> |     SELECT
      cycling_admin |  cycling_admin | <keyspace cycling> |     MODIFY
      cycling_admin |  cycling_admin | <keyspace cycling> |  AUTHORIZE
      cycling_admin |  cycling_admin |        <all roles> |  AUTHORIZE
    ```


Changing a password

A role can change the password to itself, or another role that it has permission to modify. A superuser can change the password of any role. Use ALTER to change a role's password:

```
ALTER ROLE coach WITH PASSWORD = 'NewPassword' 
```

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

