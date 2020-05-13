# ALTER TYPE {#cqlAlterType .reference}

Modify a user-defined type. Cassandra 2.1 and later.

Modify an existing user-defined type \(UDT\). Cassandra 2.1 and later.

**Restriction:** Modifying UDTs used in primary keys or index columns is not supported.

## Synopsis {#synopsis .section}

```
ALTER TYPE field\_name 
[ALTER field\_name TYPE new\_cql\_datatype
| ADD (field\_name cql\_datatype[,...])
| RENAME field\_name TO new\_field\_name[AND ...]]
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

To make multiple changes to the UDT, use AND between the clauses.

 ALTER field\_name TYPE new\_cql\_datatype
 :   Change the data type of a field. Specify the field name and the new cql datatype.

  ADD \(field\_name cql\_datatype\[,...\]\)
 :   Add fields by entering a field name followed by the data type in a comma separated list; the values for existing rows is set to null.

  RENAME field\_name TO new\_field\_name
 :   Enter the old name and new name of the field.

 ## Examples {#examples .section}

Changing the data type

To change the type of a field, the field must already exist and be compatible with the new type[CQL type compatibility](cql_data_types_c.md#cql_data_type_compatibility).

**Tip:** Carefully choose the data type for each column at the time of table creation.

Change the birthday timestamp to a blob.

```screen
ALTER TABLE cycling.cyclist_alt_stats 
ALTER birthday TYPE  blob;
```

Adding a field

To add a new field to a user defined type, use ALTER TYPE and the ADD keyword. For existing UDTs, the field value is null.

```screen
ALTER TYPE fullname ADD middlename text ;
```

Changing a field name

To change the name of a field in a user-defined type, use the RENAME old\_name TO new\_name syntax. Rename multiple fields by separating the directives with AND.

Remove name from all the field names the cycling.fullname UDT.

```screen
ALTER TYPE cycling.fullname 
RENAME middlename TO middle 
AND lastname to last 
AND firstname to first;
```

Verify the changes using describe:

```screen
desc type cycling.fullname
```

The new field names appear in the description.

```
CREATE TYPE cycling.fullname (
    first text,
    last text,
    middle text
);
```

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

