# CREATE INDEX {#cqlCreateIndex .reference}

Define a new index on a single column of a table.

Define a new index on a single column of a table. If data already exists for the column, Cassandra indexes the data during the execution of this statement. After the index is created, Cassandra indexes new data for the column automatically when new data is inserted.

Cassandra supports creating an index on most columns, excluding counter columns but including a clustering column of a [compound primary key](../cql_using/useCompoundPrimaryKeyConcept.md) or on the partition \(primary\) key itself. Cassandra 2.1 and later supports creating an index on a collection or the key of a collection map. Cassandra rejects an attempt to create an index on both the collection key and value. Cassandra 3.4 \(and later\) supports indexing static columns.

Indexing can impact performance greatly. Before creating an index, be aware of when and [when not to create an index](../cql_using/useWhenIndex.md#when-no-index). In Cassandra 3.4 and later, a new [custom SASI index](cqlCreateCustomIndex.md) has been added .

## Synopsis {#synopsis .section}

```
CREATE INDEX *IF NOT EXISTS index\_name*
ON *keyspace\_name.*table_name (* KEYS* ( column_name ) )
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

index\_name is an identifier, enclosed or not enclosed in double quotation marks, excluding reserved words.

## Creating an index on a column {#creating-an-index-on-a-column .section}

Define a table and then create an index on two of its columns:

```
CREATE TABLE myschema.users (
   userID uuid,
   fname text,
   lname text,
   email text,
   address text,
   zip int,
   state text,
   PRIMARY KEY (userID)
 );

CREATE INDEX user_state
   ON myschema.users (state);

CREATE INDEX ON myschema.users (zip);
```

 index\_name
 :   Optional identifier for index. If no name is specified, Cassandra names the index: `table\_name_column\_name_idx`. Enclose in quotes to use special characters or preserve capitalization.

 ## Examples {#creating-an-index-on-a-clustering-column .section}

Creating an index on a clustering column

Define a table having a [composite partition key](cqlCreateTable.md#cqlPKcomposite), and then create an index on a clustering column.

```


CREATE TABLE mykeyspace.users (
   userID uuid,
   fname text,
   lname text,
   email text,
   address text,
   zip int,
   state text,
  PRIMARY KEY ((userID, fname), state)
);
      
CREATE INDEX ON mykeyspace.users (state);
```

Creating an index on a set or list collection

Create an index on a set or list collection column as you would any other column. Enclose the name of the collection column in parentheses at the end of the CREATE INDEX statement. For example, add a collection of phone numbers to the users table to index the data in the phones set.

```
ALTER TABLE users ADD phones set<text>;
CREATE INDEX ON users (phones);
```

If the collection is a map, Cassandra can create an [index on map values](../cql_using/useIndexColl.md). Assume the users table contains this map data from the [example of a todo map](cqlInsert.md#usingCollSetMap):

```
{'2014-10-2 12:10' : 'die' }
```

The map key, the timestamp, is located to the left of the colon, and the map value is located to the right of the colon, 'die'. Indexes can be created on both map keys and map entries .

Creating an index on map keys

In Cassandra 2.1 and later, you can create an index on [map collection keys](../cql_using/useIndexColl.md). If an index of the map values of the collection exists, drop that index before creating an index on the map collection keys.

To index map keys, you use the KEYS keyword and map name in nested parentheses. For example, index the collection keys, the timestamps, in the todo map in the users table:

```screen
CREATE INDEX todo_dates ON users (KEYS(todo));
```

To query the table, you can use [CONTAINS KEY](cqlSelect.md#filtering-on-collections)in `WHERE` clauses.

Creating an index on the map entries

In Cassandra 2.2 and later, you can create an index on map entries. An `ENTRIES` index can be created only on a map column of a table that doesn't have an existing index.

To index collection entries, you use the ENTRIES keyword and map name in nested parentheses. For example, index the collection entries in a list in a race table:

```screen
CREATE INDEX entries_idx ON race (ENTRIES(race_wins));
```

To query the table, you can use a `WHERE` clause.

Creating an index on a full collection

In Cassandra 2.2 and later, you can create an index on a full `FROZEN` collection. An `FULL` index can be created on a set, list, or map column of a table that doesn't have an existing index.

To index collection entries, you use the FULL keyword and collection name in nested parentheses. For example, index the list rnumbers.

```screen
CREATE INDEX rnumbers_idx 
ON cycling.race_starts (FULL(rnumbers));
```

To query the table, you can use a `WHERE` clause.

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

