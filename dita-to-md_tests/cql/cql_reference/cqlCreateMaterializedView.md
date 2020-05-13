# CREATE MATERIALIZED VIEW {#cqlCreateMaterializedView .reference}

Create a materialized view in Cassandra 3.0 and later.

Create a materialized view in Cassandra 3.0 and later. Creates a query only table from a base table; when changes are made to the base table the materialized view is automatically updated. Use materialized views to more efficiently query the same data in different ways, see [Creating a materialized view](../cql_using/useCreateMV.md).

**Restriction:** 

-   Use all base table primary keys in the materialized view as primary keys.
-   Optionally, add one non-PRIMARY KEY column from the base table to the materialized view's PRIMARY KEY.
-   [Static columns](/en/glossary/doc/glossary/gloss_static_col.html) are not supported as a PRIMARY KEY.

## Synopsis {#synopsis .section}

```screen
CREATE MATERIALIZED VIEW [IF NOT EXISTS] [keyspace\_name.] view\_name
AS SELECT column\_list
FROM [keyspace\_name.] base\_table\_name
WHERE column\_name IS NOT NULL [AND column\_name IS NOT NULL ...] 
      [AND relation...] 
PRIMARY KEY ( column\_list )
[WITH [table\_properties]
      [AND CLUSTERING ORDER BY (cluster_column_name order\_option )]]
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

**Create MATERIALIZED VIEW clause**
 IF NOT EXISTS
 :   Optional. Suppresses the error message when attempting to create a materialized view that already exists. Use to continuing executing commands, such as in a `SOURCE` command. The option only validates that a materialized view with the same name exists; columns, primary keys, properties and other settings can differ.

  keyspace\_name.
 :   Optional. When no keyspace is selected or to create the view in another keyspace, enter keyspace name before the materialized view name.

    **Note:** Base tables and materialized views are always in the same keyspace.

  view\_name
 :   Materialized view names can only contain alpha-numeric characters and underscores. The view name must begin with a number or letter and can be up to 49 characters long.

 :   **AS SELECT column\_list**

 column\_list
 :   Comma separated list of non-PRIMARY KEY columns from the base table to include in the materialized view. All primary key columns are automatically included.

    Static columns, even when specified, are not included in the materialized view.

 :   **FROM \[keyspace\_name\].\]base\_table\_name**

 keyspace\_name.
 :   Keyspace where the base table is located. Only required when creating a materialized view in a different keyspace than the current keyspace.

  base\_table\_name
 :   Name of the table that the materialized view is based on.

 :   **WHERE PRIMARY\_KEY\_column\_name IS NOT NULL \[AND PK\_column\_name IS NOT NULL …\]**

 PK\_column\_name IS NOT NULL
 :   Test all primary key columns for null values in the where clause. Separate each condition with `AND`. Rows with null values in the primary key are not inserted into the materialized view table.

  AND relation
 :   Other relations that target the specific data needed. See the [relation](cqlSelect.md#ref_select_relation) section of the CQL SELECT documentation.

 :   **PRIMARY KEY \( column\_list\)**

 column\_list
 :   Comma separated list of columns used to partition and cluster the data. You can add a single non-primary key column from the base table. Reorder the primary keys as needed to query the table more efficiently, including changing the partitioning and clustering keys.

 :   List the partition key first, followed by the clustering keys. Create a compound partition key by enclosing column names in parenthesis, for example:

    ```
    PRIMARY KEY (
       (PK\_column1[, PK\_column2...]),
       clustering\_column1[, clustering\_column2...])
    ```

    **Note:** [Static columns](/en/glossary/doc/glossary/gloss_static_col.html) are not supported in materialized views.

 :   **WITH table\_properties**

 table\_properties
 :   Optional. Specify table properties if different than default. Separate table property definitions with an AND.

    **Note:** The base table properties are not copied.

 ## Example {#examples .section}

Creates the materialized view `cyclist_by_age` based on the source table `cyclist_mv`. The `WHERE` clause ensures that only rows whose `age` and `cid` columns are non-NULL are added to the materialized view.

```no-highlight
CREATE MATERIALIZED VIEW cycling.cyclist_by_age 
AS SELECT age, name, country 
FROM cycling.cyclist_mv 
WHERE age IS NOT NULL AND cid IS NOT NULL 
PRIMARY KEY (age, cid)
WITH caching = { 'keys' : 'ALL', 'rows_per_partition' : '100' }
   AND comment = 'Based on table cyclist' ;
```

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

