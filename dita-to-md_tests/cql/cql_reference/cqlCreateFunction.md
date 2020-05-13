# CREATE FUNCTION {#cqlCreateFunction .reference}

Creates custom function that execute user provided code in Cassandra.

Executes user-provided code in Cassandra in SELECT, INSERT and UPDATE statements. The UDF scope is keyspace-wide. By default, UDF includes support for Java generic methods and Javascript.

See [User Defined Functions in Cassandra 3.0](https://www.datastax.com/blog/2014/08/user-defined-functions-cassandra-30) to add support for additional JSR-223 compliant scripting languages, such as Python, Ruby, and Scala.

**Note:** Before creating user-defined functions, set `enable_user_defined_functions=true` and if implementing Javascript also set `enable_scripted_user_defined_functions=true` in the cassandra.yaml.

## Synopsis {#synopsis .section}

```
CREATE [OR REPLACE] FUNCTION [IF NOT EXISTS] 
[keyspace\_name.]function\_name ( 
    var\_name var\_type [,...] )
[CALLED | RETURNS NULL] ON NULL INPUT 
RETURNS cql\_data\_type 
LANGUAGE language\_name AS 
'code\_block'; 
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

 CREATE \[OR REPLACE\] FUNCTION function\_name \[IF NOT EXISTS\]
 :   Use the following options:

    -   CREATE function\_name: Creates a new function and errors if it already exists, use with IF NOT EXITS to suppress error.
    -   CREATE OR REPLACE: Creates a new function and overwrites it if it already exists.
    -   Only use either *OR REPLACE* or *IF NOT EXISTS*.

  var\_name var\_type
 :   The variable name and data type passed from request to the code block for execution. Use a comma separated list to declare multiple variables.

    You can also use complex types, such as collections, tuple and use-defined types as argument. Tuple types and user-defined types are handled by the DataStax Java Driver.

    Arguments for functions can be literals or terms. Prepared statement placeholders can be used, too.

 :   For example:

    ```
    column text, num int
    ```

  CALLED ON NULL INPUT
 :   Executes the user-provided code block even if the input value is null or missing.

  RETURNS NULL ON NULL INPUT
 :   Does not execute the user-provided code block on null values; returns null.

  RETURNS cql\_data\_type
 :   Map the expected output from the code block to a compatible CQL data type.

  LANGUAGE language\_name
 :   Supported types are Java and Javascript. See [User Defined Functions in Cassandra 3.0](https://www.datastax.com/blog/2014/08/user-defined-functions-cassandra-30) to add support for additional JSR-223 compliant scripting languages, such as Python, Ruby, and Scala.

  'code\_block' \| $$ code\_block $$
 :   Enclose the code block in single quotes or if the code block contains any special characters enclose it in double dollar signs \($$\). The code is wrapped as a function and applied to the target variables.

    UDFs are susceptible to all of the normal issues that may occur with the chosen programming language. Safe guard against exceptions, such as null pointer exceptions, illegal arguments, or any other potential sources. An exception during function execution results in the entire statement failing.

 ## Examples {#examples .section}

Overwrite or create the fLog function that computes the logarithm of an input value. `CALLED ON NULL INPUT` ensures that the function will always be executed.

```
CREATE OR REPLACE FUNCTION cycling.fLog (input double) 
CALLED ON NULL INPUT 
RETURNS double LANGUAGE java AS
'return Double.valueOf(Math.log(input.doubleValue()));';
```

Create a function that returns the first N characters from a text field in Javascript. RETURNS NULL ON NULL INPUT ensures that if the input value is null then the function is not executed.

```
CREATE FUNCTION IF NOT EXISTS cycling.left (column TEXT,num int) 
RETURNS NULL ON NULL INPUT 
RETURNS text 
LANGUAGE javascript AS 
$$ column.substring(0,num) $$;
```

Use the function in requests:

```screen
SELECT left(firstname,1), lastname from cycling.cyclist_name;
```

```
 cycling.left(firstname, 1) | lastname
----------------------------+-----------------
                          A |           FRAME
                          A |         PIETERS
                          M |        MATTHEWS
                          M |             VOS
                          P |       TIRALONGO
                          S |      KRUIKSWIJK
                          A | VAN DER BREGGEN
```

**Parent topic:** [CQL commands](../../cql/cql_reference/cqlCommandsTOC.md)

