# cqlshExpand {#cqlshExpand .reference}

Formats query output vertically.

For each row, lists column values vertically; use to read wide data.

## Synopsis {#synopsis .section}

```
cqlshExpand [ ON | OFF ]
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

View rows vertically.

```screen
cqlshExpand ON 
```

The view is enabled.

```no-highlight
Now printing cqlshExpanded output
```

Select all from race winners table.

```screen
select * from cycling.race_winners ;
```

Each field is shown in a vertical row table.

```no-highlight
@ Row 1
---------------+--------------------------------------------------
 race_name     | National Championships South Africa WJ-ITT (CN)
 race_position | 1
 cyclist_name  | {firstname: 'Frances', lastname: 'DU TOUT'}

@ Row 2
---------------+--------------------------------------------------
 race_name     | National Championships South Africa WJ-ITT (CN)
 race_position | 2
 cyclist_name  | {firstname: 'Lynette', lastname: 'BENSON'}

@ Row 3
---------------+--------------------------------------------------
 race_name     | National Championships South Africa WJ-ITT (CN)
 race_position | 3
 cyclist_name  | {firstname: 'Anja', lastname: 'GERBER'}

@ Row 4
---------------+--------------------------------------------------
 race_name     | National Championships South Africa WJ-ITT (CN)
 race_position | 4
 cyclist_name  | {firstname: 'Ame', lastname: 'VENTER'}

@ Row 5
---------------+--------------------------------------------------
 race_name     | National Championships South Africa WJ-ITT (CN)
 race_position | 5
 cyclist_name  | {firstname: 'Danielle', lastname: 'VAN NIEKERK'}

(5 rows)
```

**Parent topic:** [CQL shell commands](../../cql/cql_reference/cqlshCommandsTOC.md)

