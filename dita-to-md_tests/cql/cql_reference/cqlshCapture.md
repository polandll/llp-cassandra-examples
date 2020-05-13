# CAPTURE {#cqlshCapture .reference}

Appends query results to a file.

Appends the query results to a file in exponential notation format. Results do not appear in standard output; however error messages and cqlsh commands output displays in STDOUT.

## Synopsis {#synopsis .section}

```
CAPTURE ['file\_name' | OFF]
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

## Options {#description .section}

|Option|Description|
|------|-----------|
| |Shows status.|
|OFF|Stops capture|
|'file\_name'|Starts capture for CQL queries. Results of queries that run after capture begins are appended to the specified file; when you run the first query after beginning the capture, the file is created if it does not already exist. Use a relative path from the current working directory or specify tilde \(~\) for the user's HOME directory. Absolute paths are not supported.|

## Examples {#examples .section}

Begin capturing results to the winners text file:

```language-cql
CAPTURE '~/results/winners.txt'
```

**Note:** The folder must exist in the user's home directory, but the file is created if it does not exist.

```no-highlight
Now capturing query output to '/Users/local\_system\_user/results/winners.txt'.
```

Execute a query that selects all winners:

```screen
select * from cycling.race_winners;
```

Results are written to end of the capture file and do not display in the terminal window.

**Parent topic:** [CQL shell commands](../../cql/cql_reference/cqlshCommandsTOC.md)

