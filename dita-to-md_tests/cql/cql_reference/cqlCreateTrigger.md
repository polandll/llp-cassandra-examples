# CREATE TRIGGER {#cqlCreateTrigger .reference}

Registers a trigger on a table.

The implementation of triggers includes the capability to register a trigger on a table using the familiar CREATE TRIGGER syntax. The Trigger API is semi-private and subject to change.

```
CREATE TRIGGER myTrigger
  ON myTable
  USING 'org.apache.cassandra.triggers.AuditTrigger'
```

You need to enclose trigger names that use uppercase characters in double quotation marks. The logic comprising the trigger can be written in any Java \(JVM\) language and exists outside the database. The Java class in this example that implements the trigger is named org.apache.cassandra.triggers and defined in an [Apache repository](https://github.com/apache/cassandra/blob/trunk/examples/triggers/src/org/apache/cassandra/triggers/AuditTrigger.java). The trigger defined on a table fires before a requested DML statement occurs to ensures the atomicity of the transaction.

Place the custom trigger code \(JAR\) in the triggers directory on every node. The custom JAR loads at startup. The location of triggers directory depends on the installation:

-   Cassandra 2.2 and 3.x tarball: install\_location/conf/triggers
-   Cassandra 2.2 and 3.x /etc/cassandra/triggers

Cassandra supports lightweight transactions for creating a trigger. Attempting to create an existing trigger returns an error unless the IF NOT EXISTS option is used. If the option is used, the statement is a no-op if the table already exists.

## Synopsis {#synopsis .section}

```
CREATE TRIGGER *IF NOT EXISTS* trigger_name ON table_name
USING 'java_class'
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

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

