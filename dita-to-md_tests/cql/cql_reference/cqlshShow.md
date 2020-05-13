# SHOW {#cqlshShow .reference}

Displays the Cassandra, CQL, and cqlsh versions, session host details, or tracing session details.

Use to display the Cassandra instance version, the session CQL and cqlsh versions, current session node information, and tracing session details captured in the past 24 hours.

## Synopsis {#synopsis .section}

```no-highlight
SHOW VERSION | HOST | SESSION tracing\_session\_id
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

|Option|Description|
|------|-----------|
|VERSION|The version, build number, and native protocol of the connected Cassandra instance, as well as the CQL specification version for cqlsh.|
|HOST|The node details for the cqlsh session host.|
|SESSION tracing\_session\_id|Request activity details for a specific query. Session ids are shown in the query results and are recorded to the system\_traces.sessions table.**Note:** All queries run from a TRACING enabled cqlsh session are captured in the session and events table and saved for 24 hours. After that time, the tracing information time-to-live expires.

|

## Examples {#Examples .section}

Show the version information.

```screen
SHOW VERSION
```

Reports the current versions for cqlsh, Cassandra, CQL and the native protocol.

```no-highlight
[cqlsh 5.0.1 | Cassandra 2.1.0 | CQL spec 3.3 | Native protocol v3]
```

Show the host information for the cqlsh session host.

```screen
SHOW HOST
```

Displays the host name, IP address, and port of the CQL shell session.

```no-highlight
Connected to Test Cluster at 127.0.0.1:9042.
```

Show the request activity details for a specific session.

```screen
SHOW SESSION d0321c90-508e-11e3-8c7b-73ded3cb6170
```

**Note:** Use a session id from the query results or from the system\_traces.sessions table.

Sample output of SHOW SESSION is:

```no-highlight
Tracing session: d0321c90-508e-11e3-8c7b-73ded3cb6170

 activity                                                                                                                                | timestamp    | source    | source_elapsed
-----------------------------------------------------------------------------------------------------------------------------------------+--------------+-----------+----------------
                                                                                                                      execute_cql3_query | 12:19:52,372 | 127.0.0.1 |              0
 Parsing CREATE TABLE emp (\n  empID int,\n  deptID int,\n  first_name varchar,\n  last_name varchar,\n  PRIMARY KEY (empID, deptID)\n); | 12:19:52,372 | 127.0.0.1 |            153
                                                                                                                        Request complete | 12:19:52,372 | 127.0.0.1 |            650
. . .
```

**Parent topic:** [CQL shell commands](../../cql/cql_reference/cqlshCommandsTOC.md)

