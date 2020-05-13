# Starting cqlsh {#cqlsh .reference}

Starts the CQL shell interactive terminal with specified options.

Execute the `cqlsh` Cassandra python script to start the CQL shell; CQL shell is a python-based command line client for executing [CQL commands](cqlCommandsTOC.md) interactively. CQL shell supports tab completion.

## Synopsis {#synopsis .section}

On a Linux host:

```
bin/cqlsh [options] [host [port]]
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

|Short|Long|Description|
|-----|----|-----------|
| |--version|cqlsh version number.|
|-h|--help|Help message.|
|-C|--color|Always use color output.|
| |--no-color|Never use color output.|
| |--browser="launch\_browser\_cmd %s"|Browser to display the CQL command help. See [Web Browser Control](https://docs.python.org/2/library/webbrowser.html) for a list of supported browsers. Replace the URL in the command with `%s`.|
| |--ssl|Use SSL.|
|-u user\_name|--username="user\_name"|Connect with the user account.|
|-p password|--password="password"|User's password.|
|-k keyspace\_name|--keyspace=keyspace\_name|Automatically switch to the keyspace.|
|-f file\_name|--file=file\_name|Execute commands from a CQL file, then exit.**Note:** After starting cqlsh, use the [SOURCE](cqlshSource.md) command and the path to the file on the cqlsh command line.

|
| |--debug|Show additional debugging information.|
| |--encoding="output\_encoding"|Output encoding. Default encoding: `utf8`.|
| |--cqlshrc="/folder\_name"|Folder that contains the cqlshrc file. Use tilde \(~\) for paths relative to the user's home directory.|
| |--cqlversion="version\_number"|CQL version to use. Version displays after starting cqlsh.|
|-e "cql\_statement"|--execute="cql\_statement"|Execute the CQL statement and exit. To direct the command output to a file see [saving CQL output](cqlsh.md#cqlshSavingoutput).|
| |--connect-timeout="timeout"|Connection timeout in seconds; default: `5`.|
| |--request-timeout="timeout"|CQL request timeout in seconds; default: `10`.|
|-t|--tty|Force time-to-live \(tty\) mode.|

## Connecting to a specific host or IP address {#remoteHostConnection .section}

Specifying a hostname or IP address after the cqlsh command \(and options\) connects the CQL session to a specified Cassandra node. By default, CQL shell launches a session with the local host on 127.0.0.1. You can only connect CQL shell to remote hosts that have a higher or equal version than the local copy. When no port is specified, the connection uses the default port: 9042.

## Examples {#examples .section}

Starting the CQL shell

On startup, cqlsh shows the name of the cluster, IP address, and connection port. The cqlsh prompt initially is cqlsh\>. After you specify a keyspace, it's added to the prompt.

1.  Start the CQL shell:

    ```screen
    bin/cqlsh
    ```

    The host information appears.

    ```no-highlight
    Connected to Test Cluster at 127.0.0.1:9042.
    [cqlsh 5.0.1 | Cassandra 3.3.0 | CQL spec 3.4.0 | Native protocol v4]
    Use HELP for help.
    ```

2.  Switch to the `cycling` keyspace:

    ```screen
    USE cycling;
    ```

    The prompt now includes the keyspace name.

    ```no-highlight
    cqlsh:cycling>
    ```


Querying using CQL commands

At the cqlsh prompt, type CQL commands. Use a semicolon to terminate a command. A new line does not terminate a command, so commands can be spread over several lines for clarity.

```screen
SELECT * FROM calendar 
WHERE race_id = 201 ;
```

The results display in standard output.

```no-highlight
 race_id | race_start_date                 | race_end_date                   | race_name
---------+---------------------------------+---------------------------------+-----------------------------
     201 | 2015-02-18 08:00:00.000000+0000 | 2015-02-22 08:00:00.000000+0000 | Women's Tour of New Zealand
```

The [lexical structure of commands](cql_lexicon_c.md) includes how upper- and lower-case literals are treated in commands, when to use quotation marks in strings, and how to enter exponential notation.

Saving CQL output in a file

Using the -e option to the cqlsh command followed by a CQL statement, enclosed in quotation marks, accepts and executes the CQL statement. For example, to save the output of a SELECT statement to myoutput.txt:

```screen
bin/cqlsh -e "SELECT * FROM mytable" > myoutput.txt
```

Setting the CQL help browser

Set the browser to display the CQL help to Chrome on Mac OS X:

```screen
bin/cqlsh --browser="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome %s"
```

```no-highlight
[cqlsh 5.0.1 | Cassandra 3.9 | CQL spec 3.4.2 | Native protocol v4]
Use HELP for help.
```

```screen
HELP UPDATE
```

```no-highlight
2016-11-11 13:59:22.068 Google Chrome[89120:2909863] NSWindow warning: adding an unknown subview: <FullSizeContentView: 0x7fa35ae9af40>. Break on NSLog to debug.
2016-11-11 13:59:22.069 Google Chrome[89120:2909863] Call stack:
(
    "+callStackSymbols disabled for performance reasons"
)
```

**Note:** cqlsh help displays in the terminal. CQL help is only available online in HTML.

Connecting to a remote node

Specify a remote node IP address:

```screen
bin/cqlsh 10.0.0.30
```

```no-highlight
Connected to West CS Cluster at 10.0.0.30:9042.
[cqlsh 5.0.1 | Cassandra 3.3.0 | CQL spec 3.4.0 | Native protocol v4]
Use HELP for help.
```

**Parent topic:** [CQL shell commands](../../cql/cql_reference/cqlshCommandsTOC.md)

