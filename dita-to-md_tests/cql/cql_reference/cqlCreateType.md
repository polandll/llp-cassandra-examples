# CREATE TYPE {#cqlCreateType .reference}

Create a user-defined type in Cassandra 2.1 and later.

Create a user-defined type in Cassandra 2.1 and later. A [user-defined type](cqlRefUDType.md) contains one or more typed fields of related information, such as address information: street, city, and postal code.

## Synopsis {#synopsis .section}

```
CREATE TYPE [IF NOT EXISTS] 
keyspace\_name.type\_name(
field\_name cql\_datatype[,] 
[field\_name cql\_datatype] [,...]
)
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

 IF NOT EXISTS
 :   Suppresses the error if the type already exists in the keyspace. UDT scope is keyspace-wide.

  type\_name
 :   Unique name for the type, CQL types are reserved for a list see [type names](cql_data_types_c.md).

  field\_name cql\_datatype
 :   Define fields that are in the UDT in a comma separated list:

    ```
    field\_name cql\_datatype, field\_name cql\_datatype
    ```

    **Restriction:** UDTs cannot contain counter fields.

 ## Example {#createTypeEx .section}

This example creates a user-defined type `cycling.basic_info` that consists of personal data about an individual cyclist.

```screen
CREATE TYPE cycling.basic_info (
  birthday timestamp,
  nationality text,
  weight text,
  height text
);
```

After defining the UDT, you can create a table that has columns with the UDT. CQL collection columns and other columns support the use of user-defined types, as shown in [Using CQL examples](../cql_using/useInsertUDT.md).

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

