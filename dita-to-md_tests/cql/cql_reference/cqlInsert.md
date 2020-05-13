# INSERT {#cqlInsert .reference}

Inserts an entire row or upserts data into existing rows.

Inserts an entire row or upserts data into an existing row, using the full [primary key](/en/glossary/doc/glossary/gloss_primary_key.html). Requires a value for each component of the primary key, but not for any other columns. Missing values are set to null.

INSERT returns no results unless IF NOT EXISTS is used.

**Restriction:** 

-   Insert does not support counter columns use [UPDATE](cqlUpdate.md) instead.
-   A [PRIMARY KEY](../cql_using/useCompoundPrimaryKeyConcept.md) consists of a the [partition key](/en/glossary/doc/glossary/gloss_partition_key.html) followed by the clustering columns. In Cassandra 3.0 and earlier, you can only insert values smaller than 64 kB into a clustering column.

## Synopsis {#synopsis .section}

```
INSERT INTO [keyspace\_name.] table\_name (column\_list) 
VALUES (column\_values) 
[IF NOT EXISTS] 
[USING TTL seconds | TIMESTAMP epoch\_in\_microseconds] 
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

 column\_list
 :   Comma separated list of columns. All PRIMARY KEY fields are required. Nulls are inserted into any static columns that are excluded.

  column\_values
 :   For each column, enter the corresponding list of values. Use the same order as the [column\_list](cqlInsert.md#cql-insert-parameters).

    Enter data using the following syntax:

    -   a [literal](valid_literal_r.md)
    -   a collection:

        |Type|Description|
        |----|-----------|
        |set|Enter values between curly braces:        ```
{ literal [, ...] }
        ```

|
        |list|Enter values between square brackets:        ```
[literal [, ...]]
        ```

|
        |map|Enter values between curly braces:        ```
{ key : value [, ...] }
        ```

|


  TTL seconds
 :   Set [TTL](/en/glossary/doc/glossary/gloss_ttl.html) in seconds. After TTL expires, inserted data is automatically marked as deleted \(with a tombstone\). The TTL settings applies only to the inserted data, not the entire column. Any subsequent updates to the column resets the TTL. By default, values never expire.

    You can set a default TTL for an entire table by setting the table's [default\_time\_to\_live](cqlCreateTable.md#cqlTableDefaultTTL) property. If you try to set a TTL for a specific column that is longer than the time defined by the table TTL, Cassandra returns an error.

  IF NOT EXISTS
 :   Inserts a new row of data if no rows match the PRIMARY KEY values.

  TIMESTAMP epoch\_in\_microseconds
 :   Marks inserted data \(write time\) with TIMESTAMP. Enter the time since epoch \(January 1, 1970\) in microseconds. By default, Cassandra uses the actual time of write.

    **Restriction:** INSERT does not support IF NOT EXISTS and USING TIMESTAMP in the same statement.

 ## Examples {#timestamp_ttl .section}

Specifying TTL and TIMESTAMP

Insert a cyclist name using both a TTL and timestamp.

```screen
INSERT INTO cycling.cyclist_name (id, lastname, firstname)
  VALUES (6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47, 'KRUIKSWIJK','Steven')
  USING TTL 86400 AND TIMESTAMP 123456789;
```

-   Time-to-live \([TTL](/en/glossary/doc/glossary/gloss_ttl.html)\) in seconds
-   Timestamp in microseconds since epoch

Inserting values into a collection \(set and map\)

To insert data into a collection, enclose values in curly brackets. Set values must be unique. Example: insert a list of categories for a cyclist.

```screen
INSERT INTO cycling.cyclist_categories (id,lastname,categories)
  VALUES(
    '6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47', 
    'KRUIJSWIJK', 
    {'GC', 'Time-trial', 'Sprint'});
```

Insert a map named `teams` that lists two recent team memberships for the user VOS.

```screen
INSERT INTO cycling.cyclist_teams (id,lastname,teams)
  VALUES(
    5b6962dd-3f90-4c93-8f61-eabfa4a803e2, 
    'VOS', 
    { 2015 : 'Rabobank-Liv Woman Cycling Team', 
      2014 : 'Rabobank-Liv Woman Cycling Team' });
```

The size of one item in a collection is limited to 64K.

To insert data into a collection column of a user-defined type, enclose components of the type in parentheses within the curly brackets, as shown in ["Using a user-defined type."](../cql_using/useInsertUDT.md)

Inserting a row only if it does not already exist

Add IF NOT EXISTS to the command to ensure that the operation is not performed if a row with the same primary key already exists:

```screen
INSERT INTO cycling.cyclist_name (id, lastname, firstname) 
   VALUES (c4b65263-fe58-4846-83e8-f0e1c13d518f, 'RATTO', 'Rissella') 
IF NOT EXISTS; 
```

Without IF NOT EXISTS, the command proceeds with no standard output. If IF NOT EXISTS returns true \(if there is no row with this primary key\), standard output displays a table like the following:

```
 [applied]
-----------
      True
```

If, however, the row does already exist, the command fails, and standard out displays a table with the value `false` in the `[applied]` column, and the values that were not inserted, as in the following example:

```
 [applied] | id                                   | firstname | lastname
-----------+--------------------------------------+-----------+----------
     False | c4b65263-fe58-4846-83e8-f0e1c13d518f |  Rissella |    RATTO
```

**Note:** Using IF NOT EXISTS incurs a performance hit associated with using Paxos internally. For information about Paxos, see [Cassandra 3.0 documentation](/en/cassandra-oss/3.0/cassandra/dml/dmlAboutDataConsistency.html).

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

