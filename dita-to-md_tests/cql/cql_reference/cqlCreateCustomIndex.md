# CREATE CUSTOM INDEX \(SASI\) {#cqlCreateCustomIndex .reference}

Generates a SASI index on a single table column.

In Cassandra 3.4 and later, generate SSTable Attached Secondary Index \(SASI\) on a table column. SASI indexing and querying for queries that previously required the use of `ALLOW FILTERING`. SASI uses significantly using fewer memory, disk, and CPU resources. It enables querying with PREFIX and CONTAINS on strings, similar to the SQL implementation of `LIKE = "foo*"` or `LIKE = "*foo*"`.

For more information about SASI, see [Using SASI](../cql_using/useSASIIndex.md).

## Synopsis {#synopsis .section}

```
CREATE CUSTOM INDEX [IF NOT EXISTS] [index\_name]
ON [keyspace\_name.]table\_name ( column\_name )
USING 'org.apache.cassandra.index.sasi.SASIIndex' 
[WITH OPTIONS = { option\_map }]
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

 index\_name
 :   Optional identifier for index. If no name is specified, Cassandra names the index: `table\_name_column\_name_idx`. Enclose in quotes to use special characters or preserve capitalization.

  OPTIONS
 :   Define options in JSON simple format. Specifying an analyzer allows:

-   Analyzing and indexing text column data
-   Using word stemming for indexing
-   Specifying words that can be skipped
-   Applying localization based on a specified language
-   Case normalization, like the non-tokening analyzer

    Analyzer class option

    The Cassandra SASI indexer has two analyzer classes \(analyzer\_class\):

    -   \(Default\) org.apache.cassandra.index.sasi.analyzer.StandardAnalyzer
    -   org.apache.cassandra.index.sasi.analyzer.NonTokenizingAnalyzer

    Specify the class:

    ```
    'class' : 'org.apache.cassandra.index.sasi.analyzer.NonTokenizingAnalyzer'
    ```

    There are [global options](cqlCreateCustomIndex.md#sasiGlobal) that apply to both and class specify options, [Standard Analyzer](cqlCreateCustomIndex.md#sasiStandardAnalyzer) and [Non-tokenizing Analyzer](cqlCreateCustomIndex.md#sasiNonTokenizingAnalyzer).

    Global options

    The following options apply to all analyzer classes:

    |Option|Description|
    |------|-----------|
    |analyzed|True indicates if the literal column is analyzed using the specified analyzer.|
    |is\_literal|Designates a column as literal.|
    |max\_compaction\_flush\_memory\_in\_mb|Enter the size.|

    Standard analyzer options

    Default analyzer class. The following options are available for the `org.apache.cassandra.index.sasi.analyzer.StandardAnalyzer`.

    |Option|Description|
    |------|-----------|
    |tokenization\_enable\_stemming|Reduce words to their base form, for example "stemmer", "stemming", "stemmed" are based on "stem". Default: `false`.|
    |tokenization\_skip\_stop\_words|Comma separate list of words to ignore, for example 'and, the, or'.|
    |tokenization\_locale|Language code of the column, see [List of localization codes](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes). Default: `en`.|
    |tokenization\_normalize\_lowercase|Use lowercase. Default `false`.|
    |tokenization\_normalize\_uppercase|Use uppercase. Default: `false`.|

    Non-tokenizing analyzer options

    The following options are available for the `org.apache.cassandra.index.sasi.analyzer.NonTokenizingAnalyzer`.

    |Option|Description|
    |------|-----------|
    |normalize\_lowercase|Index all strings as lowercase. Default: `false`.|
    |normalize\_uppercase|Index all strings as uppercase. Default: `false`.|
    |case\_sensitive|Ignore case in matching. Default is case-sensitive indexing, setting: `true`.|

 ## Examples {#creating-an-index-on-a-column .section}

Creating a SASI PREFIX index on a column

Define a table and then create an SASI index on the column `firstname`:

```
CREATE TABLE cycling.cyclist_name ( 
  id UUID PRIMARY KEY, 
  lastname text, 
  firstname text
);

CREATE CUSTOM INDEX  fn_prefix ON cyclist_name (firstname) USING 'org.apache.cassandra.index.sasi.SASIIndex';

```

The SASI mode `PREFIX` is the default, and does not need to be specified.

Creating a SASI CONTAINS index on a column

Define a table and then create an SASI index on the column `firstname`:

```
CREATE CUSTOM INDEX  fn_contains ON cyclist_name (firstname) 
USING 'org.apache.cassandra.index.sasi.SASIIndex'
WITH OPTIONS = { 'mode': 'CONTAINS' };
```

The SASI mode `CONTAINS` must be specified.

Creating a SASI SPARSE index on a column

Define a table and then create an SASI index on the column `age`:

```
CREATE CUSTOM INDEX  fn_contains ON cyclist_name (age) 
USING 'org.apache.cassandra.index.sasi.SASIIndex'
WITH OPTIONS = { 'mode': 'SPARSE' };
```

The SASI mode `SPARSE` must be specified. This mode is used for dense number columns that store timestamps or millisecond sensor readings.

Creating a SASI PREFIX index on a column using the non-tokenizing analyzer

Define a table, then create an SASI index on the column `age`:

```
CREATE CUSTOM INDEX  fn_contains ON cyclist_name (age) 
USING 'org.apache.cassandra.index.sasi.SASIIndex'
WITH OPTIONS = { 
   'analyzer_class': 'org.apache.cassandra.index.sasi.analyzer.NonTokenizingAnalyzer',
   'case_sensitive': 'false'};
```

Using the non-tokenizing analyzer is a method to specify case sensitivity or character case normalization without analyzing the specified column.

Creating a SASI analyzing index on a column

Define a table and then create an SASI index on the column `age`:

```
CREATE CUSTOM INDEX stdanalyzer_idx ON cyclist_name (comments) USING 'org.apache.cassandra.index.sasi.SASIIndex'
WITH OPTIONS = {
'mode': 'CONTAINS',
'analyzer_class': 'org.apache.cassandra.index.sasi.analyzer.StandardAnalyzer',
'analyzed': 'true',
'tokenization_skip_stop_words': 'and, the, or',
'tokenization_enable_stemming': 'true',
'tokenization_normalize_lowercase': 'true',
'tokenization_locale': 'en'
};
```

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

