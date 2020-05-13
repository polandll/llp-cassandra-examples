# SERIAL CONSISTENCY {#cqlshSerialConsistency .reference}

Sets consistency for lightweight transactions \(LWT\).

Sets consistency for lightweight transaction. LWT use IF EXISTS and IF NOT EXISTS. Valid values are: `SERIAL` and `LOCAL_SERIAL`.

**Tip:** To set the consistency level of non-lightweight transaction, see [CONSISTENCY](cqlshConsistency.md).

## Synopsis {#synopsis .section}

```
SERIAL CONSISTENCY [level]
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

## Examples {#example .section}

Display current `SERIAL CONSISTENCY` status.

```screen
SERIAL CONSISTENCY
```

Reports the current setting.

```no-highlight
Current serial consistency level set to SERIAL.
```

Set the serial consistency level with a value.

```screen
SERIAL CONSISTENCY LOCAL_SERIAL
```

Confirms the level is set.

```no-highlight
Serial consistency level set to LOCAL_SERIAL.
```

**Note:** Trace transactions to compare the difference between INSERT statements with and without IF EXISTS.

Write data using IF NOT EXISTS.

```screen
INSERT INTO cycling.cyclist_name (id, firstname , lastname ) 
   VALUES (e7ae5cf3-d358-4d99-b900-85902fda9bb0,'Alex','FRAME' ) 
   IF NOT EXISTS ;
```

Since the record already exists, the insert is not applied.

```no-highlight
[applied] | id                                   | firstname | lastname
-----------+--------------------------------------+-----------+----------
     False | e7ae5cf3-d358-4d99-b900-85902fda9bb0 |      Alex |    FRAME
```

**Parent topic:** [CQL shell commands](../../cql/cql_reference/cqlshCommandsTOC.md)

