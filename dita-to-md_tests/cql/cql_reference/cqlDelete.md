# DELETE {#cqlDelete .reference}

Removes data from one or more columns or removes the entire row.

Removes data from one or more selected columns \(data is replaced with null\) or removes the entire row when no column is specified. Cassandra deletes data in each selected partition atomically and in isolation.

Deleted data is not removed from disk immediately. Cassandra marks the deleted data with a tombstone and then removes it after the grace period.

CAUTION:

Using delete may impact performance.

## Synopsis {#synopsis .section}

```
DELETE [column_name (term)][, ...]
FROM [keyspace\_name.] table\_name 
[USING TIMESTAMP timestamp\_value]
WHERE PK\_column\_conditions 
[IF EXISTS | IF static\_column\_conditions]
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

 column\_name
 :   Set column to delete or use a comma separated list of columns. When no column is specified the entire row is deleted.

  term
 :   Element identifier for collection types, where:

        |list|Index number of item, where 0 is the first.|
    |map|Element key of item.|

  timestamp\_value
 :   Deletes values older than the timestamp\_value.

  PK\_column\_conditions
 :   Syntax to match PRIMARY KEY values. Separate multiple conditions with AND.

    **Restriction:** 

    -   Only equals \(=\) or IN are supported.
    -   Ranges \(IN\) are not supported when specifying a static column condition, see [IF condition](cqlDelete.md#cqlIfStaticColumn).
    -   When removing data from columns in matching rows, you must specify a condition for all primary keys.

  IF EXISTS
 :   Error when the statement results in no operation.

  IF condition
 :   Specify conditions for static fields to match. Separate multiple conditions with AND.

    **Restriction:** Modifies the primary key statement, all primary keys required.

 ## Examples {#deleting-columns-or-a-row .section}

Delete data from row

Delete the data in specific columns by listing them after the DELETE command, separated by commas. Change the data in first and last name colums to null.

```screen
DELETE firstname, lastname FROM cycling.cyclist_name 
WHERE id = e7ae5cf3-d358-4d99-b900-85902fda9bb0;
```

Delete an entire row

Entering no column names after DELETE, removes the entire matching row. Remove a cyclist entry from the cyclist\_name table and return an error if no rows match.

```screen
DELETE FROM cycling.cyclist_name 
WHERE id=e7ae5cf3-d358-4d99-b900-85902fda9bb0 IF EXISTS;
```

Delete row based on static column condition

`IF` limits the where clause, allowing selection based on values in non-PRIMARY KEY columns, such as first and last name; remove the cyclist record if the first and last name do not match.

```screen
DELETE FROM cycling.cyclist_name 
WHERE id =e7ae5cf3-d358-4d99-b900-85902fda9bb0 
if firstname='Alex' and lastname='Smith';
```

The results show all the data

```screen
 [applied] | firstname | lastname
-----------+-----------+----------
     False |      Alex |    FRAME
```

Conditionally deleting columns

In Cassandra 2.0.7 and later, you can conditionally delete columns using IF or IF EXISTS. Deleting a column is similar to making an insert or update conditionally.

Add IF EXISTS to the command to ensure that the operation is not performed if the specified row does not exist:

```
DELETE id FROM cyclist_id 
WHERE lastname = 'WELTEN' and firstname = 'Bram' 
IF EXISTS;
```

Without IF EXISTS, the command proceeds with no standard output. If IF EXISTS returns true \(if a row with this primary key does exist\), standard output displays a table like the following:

![Standard output if DELETE ... IF EXISTS returns TRUE](../images/screenshots/delete-if-exists-or-if-true.jpg)

If no such row exists, however, the conditions returns FALSE and the command fails. In this case, standard output looks like:

![Standard output if DELETE ... IS EXISTS returns FALSE](../images/screenshots/delete-if-exists-false.jpg)

Use IF condition to apply tests to one or more column values in the selected row:

```
DELETE id FROM cyclist_id 
WHERE lastname = 'WELTEN' AND firstname = 'Bram' 
IF age = 2000;
```

If all the conditions return TRUE, standard output is the same as if IF EXISTS returned true \(see above\). If any of the conditions fails, standard output displays `False` in the `[applied]` column and also displays information about the condition that failed:

![Standard output if DELETE ... IF returns FALSE](../images/screenshots/delete-if-false.jpg)

Conditional deletions incur a non-negligible performance cost and should be used sparingly.

Deleting old data using TIMESTAMP

The TIMESTAMP is an integer representing microseconds. You can identify the column for deletion using TIMESTAMP.

```
DELETE firstname, lastname
  FROM cycling.cyclist_name
  USING TIMESTAMP 1318452291034
  WHERE lastname = 'VOS';
```

Deleting more than one row

The WHERE clause specifies which row or rows to delete from the table.

```
DELETE FROM cycling.cyclist_name 
WHERE id = 6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47;
```

To delete more than one row, use the keyword IN and supply a list of values in parentheses, separated by commas:

```
DELETE FROM cycling.cyclist_name 
WHERE firstname IN ('Alex', 'Marianne');
```

In Cassandra 2.0 and later, CQL supports an empty list of values in the IN clause, useful in Java Driver applications.

Deleting from a collection set, list or map

To delete an element from a map that is stored as one column in a row, specify the column\_name followed by the key of the element in square brackets:

```
DELETE sponsorship ['sponsor_name'] FROM cycling.races 
WHERE race_name = 'Criterium du Dauphine';
```

To delete an element from a list, specify the column\_name followed by the list index position in square brackets:

```
DELETE categories[3] FROM cycling.cyclist_history 
WHERE lastname = 'TIRALONGO';
```

To delete all elements from a set, specify the column\_name by itself:

```
DELETE sponsorship FROM cycling.races 
WHERE race_name = 'Criterium du Dauphine';
```

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

