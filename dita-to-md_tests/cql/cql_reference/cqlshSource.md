# SOURCE {#cqlshSource .reference}

Executes a file containing CQL statements.

Executes a file containing CQL statements.

Specify the path of the file relative to the current directory \(that is the directory where cqlsh was started on the local host\). Enclose the file name in single quotation marks. Use tilde \(~\) for the user's home directory.

The output of each statements displays, including error messages, in STDOUT. You can use `IF NOT EXISTS` to suppress errors for some statements, such as `CREATE KEYSPACE`. All statements in the file execute, even if a no-operation error occurs.

**Tip:** The `DESC` command outputs an executable CQL statement.

## Synopsis {#synopsis .section}

```no-highlight
SOURCE 'file\_name'
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

## Examples {#examples .section}

Execute CQL statements from a file:

```screen
SOURCE '~/cycling_setup/create_ks_and_tables.cql'
```

**Note:** To execute a CQL file without starting a shell session use `bin/cqlsh --file 'file\_name'`.

**Parent topic:** [CQL shell commands](../../cql/cql_reference/cqlshCommandsTOC.md)

