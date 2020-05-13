# ALTER ROLE {#cqlAlterRole .reference}

Changes password, and set superuser or login options.

Changes password, and set superuser or login options.

## Synopsis {#synopsis .section}

```
ALTER ROLE role\_name 
[WITH [PASSWORD = 'password']
   [LOGIN = true | false] 
   [SUPERUSER = true | false] 
   [OPTIONS = map\_literal]]
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

 PASSWORD
 :   Change the password of the logged in role. Superusers \(and roles with ALTER PERMISSION to a role\) can also change the password of other roles.

  SUPERUSER
 :   Enable or disable superuser status for another role, that is any role other than the one that is currently logged in. Setting superuser to false, revokes permission to create new roles; disabling does not automatically revoke the AUTHORIZE, ALTER, and DROP permissions that may already exist.

  LOGIN
 :   Enable or disable log in for roles other than currently logged in role.

  OPTIONS
 :   Reserved for external authenticator plug-ins.

 ## Example {#examples .section}

Change the password for coach:

```
ALTER ROLE coach WITH PASSWORD='bestTeam';
```

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

