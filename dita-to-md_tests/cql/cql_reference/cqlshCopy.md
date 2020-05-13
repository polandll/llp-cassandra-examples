# COPY {#cqlshCopy .reference}

Imports and exports CSV data.

CQL shell commands that import and export CSV \(comma-separated values or delimited text files\).

-   COPY TO exports data from a table into a CSV file. Each row is written to a line in the target file with fields separated by the delimiter. All fields are exported when no column names are specified. To drop columns, specify a column list.
-   COPY FROM imports data from a CSV file into an existing table. Each line in the source file is imported as a row. All rows in the dataset must contain the same number of fields and have values in the PRIMARY KEY fields. The process verifies the PRIMARY KEY and updates existing records. If `HEADER = false` and no column names are specified, the fields are imported in deterministic order. When column names are specified, fields are imported in that order. Missing and empty fields are set to null. The source cannot have more fields than the target table, however it can have fewer fields.

**Note:** Only use COPY FROM to import datasets that have less than 2 million rows. To import large datasets, use the [Cassandra bulk loader](/en/cassandra-oss/3.x/cassandra/tools/toolsBulkloader.html).

## Synopsis {#synopsis .section}

```
COPY table\_name [( column\_list )]
FROM 'file\_name'[, 'file2\_name', ...] | STDIN
[WITH option = 'value' [AND ...]]

```

```
COPY table\_name [( column\_list )]
TO 'file\_name'[, 'file2\_name', ...] | STDOUT
[WITH option = 'value' [AND ...]]

```

**Note:** COPY supports a list of one or more comma-separated file names or python glob expressions.

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

## Setting copy options {#description .section}

Copy options set in the statement take precedence over `[cqlshrc](cqlshUsingCqlshrc.md)` file and the default settings. If an option is not set on the command line, the [cqlshrc](cqlshUsingCqlshrc.md) file takes precedence over the default settings.

|Command|Options|Description|
|-------|-------|-----------|
|TO/FROM|DELIMITER|Single character used to separate fields. Default value: ,.|
|TO/FROM|QUOTE|Single character that encloses field values. Default value: `"`.|
|TO/FROM|ESCAPE|Single character that escapes literal uses of the QUOTE character. Default value: `\`.|
|TO/FROM|HEADER|Boolean \(true \| false\) that indicates column names on the first line. True matches field names to column names on import \(FROM\) and inserts the column names in the first row of data on exports \(TO\). Default value: `false`.|
|TO/FROM|NULL|No value in field. Default value is an empty string \(\).|
|TO/FROM|DATETIMEFORMAT|Time format for reading or writing CSV time data. The timestamp uses the [strftime](http://strftime.org) format. If not set, the default value is set to the time\_format value in the cqlshrc file. Default format: `%Y-%m-%d %H:%M:%S%z`.|
|TO/FROM|MAXATTEMPTS|Maximum number of attempts for errors. Default value: `5`.|
|TO/FROM|REPORTFREQUENCY|Frequency with which status is displayed in seconds. Default value: `0.25`.|
|TO/FROM|DECIMALSEP|Separator for decimal values. Default value: period \(`.`\).|
|TO/FROM|THOUSANDSSEP|Separator for thousands digit groups. Default value: `None`.|
|TO/FROM|BOOLSTYLE|Boolean indicators for True and False. The values are case insensitive, for example: yes,no and YES,NO are the same. Default values: `True,False`.|
|TO/FROM|NUMPROCESSES|Number of worker processes. Maximum value is 16. Default value: `-1`.|
|TO/FROM|CONFIGFILE|Specify a cqlshrc configuration file to set WITH options. **Note:** Command line options always override the cqlshrc file.

|
|TO/FROM|RATEFILE|Print output statistics to this file.|
|FROM|CHUNKSIZE|Chunk size passed to worker processes. Default value: `1000`|
|FROM|INGESTRATE|Approximate ingest rate in rows per second. Must be greater than the chunk size. Default value:`100000`|
|FROM|MAXBATCHSIZE|Maximum size of an import batch. Default value:`20`|
|FROM|MINBATCHSIZE|Minimum size of an import batch. Default value:`2`|
|FROM|MAXROWS|Maximum number of rows. Use "-1" for no maximum. Default value:`-1`|
|FROM|SKIPROWS|Number of rows to skip. Default value:`0`|
|FROM|SKIPCOLS|Comma-separated list of column names to skip.|
|FROM|MAXPARSEERRORS|Maximum global number of parsing errors. Use "-1" for no maximum. Default value:`-1`|
|FROM|MAXINSERTERRORS|Maximum global number of insert errors. Use "-1" for no maximum. Default value:`-1`|
|FROM|ERRFILE|File to store all rows that are not imported. If no value is set, the information is stored in import\_ks\_table.err where ks is the keyspace and table is the table name.|
|FROM|TTL|Time to live in seconds. By default, data will not expire. Default value:`3600`|
|TO|ENCODING|Output string type. Default value: `UTF8`.|
|TO|PAGESIZE|Page size for fetching results. Default value: `1000`.|
|TO|PAGETIMEOUT|Page timeout for fetching results. Default value: `10`.|
|TO|BEGINTOKEN|Minimum token string for exporting data. Default value: ``.|
|TO|ENDTOKEN|Maximum token string for exporting data. |
|TO|MAXREQUESTS|Maximum number of requests each worker can process in parallel. Default value: `6`.|
|TO|MAXOUTPUTSIZE|Maximum size of the output file, measured in number of lines. When set, the output file is split into segment when the value is exceeded. Use "-1" for no maximum. Default value: `-1`.|

## Examples {#examples .section}

Create the sample dataset

Set up the environment used for the COPY command examples.

1.  Using CQL, create a cycling keyspace:

    ```screen
    CREATE KEYSPACE cycling
      WITH REPLICATION = { 
       'class' : 'NetworkTopologyStrategy', 
       'datacenter1' : 1 
      } ;
    ```

2.  Create the cycling.cyclist\_name table:

    ```screen
    CREATE TABLE cycling.cyclist_name ( 
       id UUID PRIMARY KEY, 
       lastname text, 
       firstname text 
    ) ;
    ```

3.  Insert data into cycling.cyclist\_name:

    ```screen
    INSERT INTO cycling.cyclist_name (id, lastname, firstname) 
       VALUES (5b6962dd-3f90-4c93-8f61-eabfa4a803e2, 'VOS','Marianne');
    INSERT INTO cycling.cyclist_name (id, lastname, firstname) 
       VALUES (e7cd5752-bc0d-4157-a80f-7523add8dbcd, 'VAN DER BREGGEN','Anna');
    INSERT INTO cycling.cyclist_name (id, lastname, firstname) 
       VALUES (e7ae5cf3-d358-4d99-b900-85902fda9bb0, 'FRAME','Alex');
    INSERT INTO cycling.cyclist_name (id, lastname, firstname) 
       VALUES (220844bf-4860-49d6-9a4b-6b5d3a79cbfb, 'TIRALONGO','Paolo');
    INSERT INTO cycling.cyclist_name (id, lastname, firstname)   
       VALUES (6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47, 'KRUIKSWIJK','Steven');
    INSERT INTO cycling.cyclist_name (id, lastname, firstname) 
       VALUES (fb372533-eb95-4bb4-8685-6ef61e994caa, 'MATTHEWS', 'Michael');
    ```


Export and import data from the cyclist\_name table

Round trip the cycling names data.

1.  Export only the id and lastname columns from the cyclist\_name table to a CSV file.

    ```screen
    COPY cycling.cyclist_name (id,lastname) 
    TO '../cyclist_lastname.csv' WITH HEADER = TRUE ;
    ```

    The cyclist\_lastname.csv file is created in the directory above the current working directory. If the file already exists it is overwritten.

    ```no-highlight
    Using 7 child processes
    
    Starting copy of cycling.cyclist_name with columns [id, lastname].
    Processed: 6 rows; Rate:      29 rows/s; Avg. rate:      29 rows/s
    6 rows exported to 1 files in 0.223 seconds.
    ```

2.  Copy the id and first name to a different CSV file.

    ```screen
    COPY cycling.cyclist_name (id,firstname) 
    TO '../cyclist_firstname.csv' WITH HEADER = TRUE ;
    ```

    The first name file is created.

    ```no-highlight
    Using 7 child processes
    
    Starting copy of cycling.cyclist_name with columns [id, firstname].
    Processed: 6 rows; Rate:      30 rows/s; Avg. rate:      30 rows/s
    6 rows exported to 1 files in 0.213 seconds.
    ```

3.  Remove all records from the cyclist name table.

    ```screen
    TRUNCATE cycling.cyclist_name ;
    ```

4.  Verify that there are no rows.

    ```screen
    SELECT * FROM cycling.cyclist_name ;
    ```

    Query results are empty.

    ```no-highlight
    id | firstname | lastname
    ----+-----------+----------
    
    (0 rows)
    ```

5.  Import the cyclist firstnames.

    ```
    COPY cycling.cyclist_name (id,firstname) FROM '../cyclist_firstname.csv' WITH HEADER = TRUE ;
    ```

    The rows are imported. Since the lastname was not in the dataset it is set to null for all rows.

    ```
    Using 7 child processes
    
    Starting copy of cycling.cyclist_name with columns [id, firstname].
    Processed: 6 rows; Rate:      10 rows/s; Avg. rate:      14 rows/s
    6 rows imported from 1 files in 0.423 seconds (0 skipped).
    ```

6.  Verify the new rows.

    ```
    SELECT * FROM cycling.cyclist_name ;
    ```

    The rows were created with null last names because the field was not in the imported data set.

    ```
    id                                   | firstname | lastname
    --------------------------------------+-----------+----------
     e7ae5cf3-d358-4d99-b900-85902fda9bb0 |      Alex |     null
     fb372533-eb95-4bb4-8685-6ef61e994caa |   Michael |     null
     5b6962dd-3f90-4c93-8f61-eabfa4a803e2 |  Marianne |     null
     220844bf-4860-49d6-9a4b-6b5d3a79cbfb |     Paolo |     null
     6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47 |    Steven |     null
     e7cd5752-bc0d-4157-a80f-7523add8dbcd |      Anna |     null
    
    (6 rows)
    ```

7.  Import the last names.

    ```
    COPY cycling.cyclist_name (id,lastname) FROM '../cyclist_lastname.csv' WITH HEADER = TRUE ;
    ```

    The records are imported but no new records get created.

    ```
    Using 7 child processes
    
    Starting copy of cycling.cyclist_name with columns [id, lastname].
    Processed: 6 rows; Rate:      10 rows/s; Avg. rate:      14 rows/s
    6 rows imported from 1 files in 0.422 seconds (0 skipped).
    ```

8.  Verify the that the records were updated.

    ```
    SELECT * FROM cycling.cyclist_name ;
    ```

    PRIMARY KEY, id, matched for all records and the last name is updated.

    ```
    id                                   | firstname | lastname
    --------------------------------------+-----------+-----------------
     e7ae5cf3-d358-4d99-b900-85902fda9bb0 |      Alex |           FRAME
     fb372533-eb95-4bb4-8685-6ef61e994caa |   Michael |        MATTHEWS
     5b6962dd-3f90-4c93-8f61-eabfa4a803e2 |  Marianne |             VOS
     220844bf-4860-49d6-9a4b-6b5d3a79cbfb |     Paolo |       TIRALONGO
     6ab09bec-e68e-48d9-a5f8-97e6fb4c9b47 |    Steven |      KRUIKSWIJK
     e7cd5752-bc0d-4157-a80f-7523add8dbcd |      Anna | VAN DER BREGGEN
    ```


Copy data from standard input to a table.

1.  Clear the data from the cyclist\_name table.

    ```
    TRUNCATE cycling.cyclist_name ;
    ```

2.  Start the copy input operation using STDIN option.

    ```no-highlight
    COPY cycling.cyclist_name FROM STDIN ;
    ```

    The line prompt changes to `[COPY]`.

    ```no-highlight
    Using 7 child processes
    
    Starting copy of cycling.cyclist_name with columns [id, firstname, lastname].
    [Use . on a line by itself to end input]
    [copy] 
    ```

3.  Next to prompt enter the field values in a common separated list; on the last line of data enter a period.

    ```no-highlight
    [copy] e7cd5752-bc0d-4157-a80f-7523add8dbcd,Anna,VAN DER BREGGEN
    [copy] .
    ```

4.  Press Return \(or Enter\) after inserting a period on the last line to begin processing the records.

    ```no-highlight
    Processed: 1 rows; Rate:       0 rows/s; Avg. rate:       0 rows/s
    1 rows imported from 1 files in 36.991 seconds (0 skipped).
    ```

5.  Verify that the records were imported.

    ```no-highlight
    select * FROM cycling.cyclist_name ;
    ```

    ```no-highlight
     id                                   | firstname | lastname
    --------------------------------------+-----------+-----------------
     e7cd5752-bc0d-4157-a80f-7523add8dbcd |      Anna | VAN DER BREGGEN
    
    (1 rows)
    ```


**Parent topic:** [CQL shell commands](../../cql/cql_reference/cqlshCommandsTOC.md)

