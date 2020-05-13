# Configuring cqlsh from a file {#cqlshUsingCqlshrc .reference}

Customize the CQL shell configuration at start up from a properties file.

The cqlshrc file configures the cqlsh session when starting the utility. Use the file by default by saving it in the `~/.cassandra` directory on the local computer or specify the directory that the file is in with the `--cqlshrc` option. Only one cqlshrc per directory.

Pre-configure the following options:

-   [Automatically logging in and selecting a keyspace](cqlshUsingCqlshrc.md#cqlshrcAutomaticLogin)
-   [Changing the CQL shell display](cqlshUsingCqlshrc.md#cqlshrcDisplay)
-   [Forcing the CQL version](cqlshUsingCqlshrc.md#cqlshrcVersion)
-   [Connecting to a CQL host](cqlshUsingCqlshrc.md#cqlshrcConnection)
-   [Limiting the field size](cqlshUsingCqlshrc.md#cqlshrcLimitSize)
-   [Setting tracing timeout](cqlshUsingCqlshrc.md#cqlshrcTracing)
-   [Configuring SSL](cqlshUsingCqlshrc.md#cqlshrcSSL)
-   [Overriding SSL local settings](cqlshUsingCqlshrc.md#cqlshrcOverrideSSL)
-   [Setting common COPY TO and COPY FROM options](cqlshUsingCqlshrc.md#cqlshrcCopy)
-   [Setting COPY TO specific options](cqlshUsingCqlshrc.md#cqlshrcCopyTo)
-   [Setting COPY FROM specific options](cqlshUsingCqlshrc.md#cqlshrcCopyFrom)
-   [Setting table specific COPY TO/FROM options](cqlshUsingCqlshrc.md#cqlshrcTableSpecific)

## Synopsis {#synopsis .section}

```
./cqlsh CQLSHRC="~/directory\_name"
```

**Note:** Tilde \(~\) expands to the user's home directory; you can also specify the absolute path, for example `/Users/jdoe/cqlshprofiles/west`.

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

## Using the cqlshrc.sample {#cqlshrcSample .section}

A sample file is installed with Cassandra, cqlshrc.sample. The file contains all the available settings. Some settings are commented out using a single semi-colon.

To use this file:

1.  Copy the file to the home directory.
2.  Rename it cqlshrc.
3.  Remove the semi-colon to uncomment an option \(options must be in brackets\) and corresponding settings, for example to import all CSV without a header row, uncomment \[copy\] and header = false:

    ```no-highlight
    ;; Options that are common to both COPY TO and COPY FROM**
    \[copy\]
    **
    ;; The string placeholder for null values
    ; nullval = null
    
    ;; For COPY TO, controls whether the first line in the CSV output file will
    ;; contain the column names.  For COPY FROM, specifies whether the first
    ;; line in the CSV file contains column names.**
    header = false**
    ```

4.  Restart the CQL shell.

## Automatically logging in and selecting a keyspace {#cqlshrcAutomaticLogin .section .title2}

Set up credentials to automatically log in when CQL shell starts and/or choose a keyspace.

**Note:** Only set a user name and password for hosts that use Cassandra internal authentication, see [Encrypting Cassandra with SSL](/en/cassandra-oss/3.0/cassandra/configuration/secureSSLIntro.html).

:   **\[authentication\]**

 username
 :   Log in account name.

  password
 :   Log in password.

  keyspace
 :   Optional. Opens the specified keyspace. Equivalent to issuing a [USE](cqlUse.md) keyspace command immediately after starting cqlsh. \(Does not require internal Cassandra authentication\).

 ## Changing the CQL shell display {#cqlshrcDisplay .section .title2}

The cqlsh console display and COPY TO date parsing settings.

:   **\[ui\]**

 color
 :   Shows query results with color.

 :   `on` In color.

 :   `off` No color.

  datetimeformat
 :   Configure the format of timestamps using [Python strftime](https://docs.python.org/2/library/datetime.html#strftime-and-strptime-behavior) syntax.

  timezone
 :   Display timestamps in Etc/UTC.

  float\_precision, double\_precision
 :   Sets the number of digits displayed after the decimal point for single and double precision numbers.

    **Note:** Increasing this to large numbers can result in unusual values.

  completekey
 :   Set the key for automatic completion of a cqlsh shell entry. Default is the tab key.

  encoding
 :   The encoding used for characters. The default is UTF8.

  browser
 :   Sets the browser for cqlsh help. If the value is not specified, cqlsh uses the default browser. Available browsers are those supported by the Python [webbrowser module](https://docs.python.org/2/library/webbrowser.html). For example, to use Google Chrome:

    -   Mac OSX: `browser = open -a /Applications/Google\ Chrome.app %s`
    -   Linux: `browser = /usr/bin/google-chrome-stable %s`

    This setting can be overridden with the `--browser` command line option.

 ## Forcing the CQL version {#cqlshrcVersion .section .title2}

Use the specified version of CQL only.

:   **\[cql\]**

 version
 :   Only use the specified version of CQL.

 ## Connecting to a CQL host {#cqlshrcConnection .section .title2}

Specify the host and connection details for the CQL shell session.

:   **\[connection\]**

 hostname
 :   The host for the cqlsh connection.

  port
 :   The connection port. Default: `9042` \(native protocol\).

  ssl
 :   Always connect using SSL. Default: `false`.

  timeout
 :   Configures timeout in seconds when opening new connections.

  request\_timeout
 :   Configures the request timeout in seconds for executing queries. Set the number of seconds of inactivity.

 ## Limiting the field size {#cqlshrcLimitSize .section .title2}

:   **\[csv\]**

 field\_size\_limit
 :   Set to a particular field size, such as `field_size_limit = 1000000000`.

 ## Setting tracing timeout {#cqlshrcTracing .section .title2}

Specify the wait time for tracing.

:   **\[tracing\]**

 max\_trace\_wait
 :   The maximum number of seconds to wait for a trace to complete.

 ## Configuring SSL {#cqlshrcSSL .section .title2}

Specify connection SSL settings.

**Note:** For more information, see *Using cqlsh with SSL encryption* for your version:

-   [Apache Cassandra 3.0](/en/cassandra-oss/3.0/cassandra/configuration/secureCqlshSSL.html)
-   [Apache Cassandra 3.x](/en/cassandra-oss/3.x/cassandra/configuration/secureCqlshSSL.html)

:   **\[ssl\]**

 certfile
 :   The path to the cassandra certificate. See *Using cqlsh with SSL encryption* in the Cassandra documentation \([links above](cqlshUsingCqlshrc.md#internal-auth-note)\).

  validate
 :   Optional. Default: `true`.

  userkey
 :   Must be provided when `require_client_auth=true` in cassandra.yaml.

  usercert
 :   Must be provided when `require_client_auth=true` in cassandra.yaml.

 ## Overriding SSL local settings {#cqlshrcOverrideSSL .section .title2}

Overrides default `certfiles` in \[ssl\] section. Create an entry for each remote host.

:   **\[certfiles\]**

 remote\_host=path\_to\_cert
 :   Specify the IP address or remote host name and path to the certificate file on your local system.

 ## Setting common COPY TO and COPY FROM options {#cqlshrcCopy .section .title2}

Settings common to both `COPY TO` and `COPY FROM`.

Also see the [COPY](cqlshCopy.md#copyOptions) table.

:   **\[copy\]**

 nullval
 :   The string placeholder for null values.

  header
 :   For COPY TO, controls whether the first line in the CSV output file contains the column names.

 :   For COPY FROM, specifies whether the first line in the CSV file contains column names.

  decimalsep
 :   Separator for decimal values. Default value: period \(`.`\).

  thousandssep
 :   Separator for thousands digit groups. Default value: `None`. Default: empty string.

  boolstyle
 :   Boolean indicators for True and False. The values are case insensitive, for example: yes,no and YES,NO are the same. Default values: `True,False`.

  numprocesses
 :   Sets the number of child worker processes.

  maxattempts
 :   Maximum number of attempts for errors. Default value: `5`.

  reportfrequency
 :   Frequency with which status is displayed in seconds. Default value: `0.25`.

  ratefile
 :   Print output statistics to this file.

 ## Setting COPY TO specific options {#cqlshrcCopyTo .section .title2}

:   **\[copy-to\]**

 maxrequests
 :   Maximum number of requests each worker can process in parallel.

  pagesize
 :   Page size for fetching results.

  pagetimeout
 :   Page timeout for fetching results.

  begintoken
 :   Minimum token string for exporting data.

  endtoken
 :   Maximum token string for exporting data.

  maxoutputsize
 :   Maximum size of the output file, measured in number of lines. When set, the output file is split into segment when the value is exceeded. Use "-1" for no maximum.

  encoding
 :   The encoding used for characters. The default is UTF8.

 ## Setting COPY FROM specific options {#cqlshrcCopyFrom .section .title2}

:   **\[copy-from\]**

 ingestrate
 :   Approximate ingest rate in rows per second. Must be greater than the chunk size.

  maxrows
 :   Maximum number of rows. Use "-1" for no maximum.

  skiprows
 :   Number of rows to skip.

  skipcols
 :   Comma-separated list of column names to skip.

  maxparseerrors
 :   Maximum global number of parsing errors. Use "-1" for no maximum.

  maxinserterrors
 :   Maximum global number of insert errors. Use "-1" for no maximum.

  errfile
 :   File to store all rows that are not imported. If no value is set, the information is stored in import\_ks\_table.err where ks is the keyspace and table is the table name.

  maxbatchsize
 :   Maximum size of an import batch.

  minbatchsize
 :   Minimum size of an import batch.

  chunksize
 :   Chunk size passed to worker processes. Default value: `1000`

 ## Setting table specific COPY TO/FROM options {#cqlshrcTableSpecific .section}

Use these options to configure table specific settings; create a new entry for each table, for example to set the chunk size for cyclist names and rank:

```no-highlight
[copy:cycling.cyclist_names]
chunksize = 1000
```

```no-highlight
[copy:cycling.rank_by_year_and_name]
chunksize = 10000
```

:   **\[copy:keyspace\_name.table\_name\]**

 chunksize
 :   Chunk size passed to worker processes. Default value: `1000`

 :   **\[copy-from:keyspace\_name.table\_name\]**

 ingestrate
 :   Approximate ingest rate in rows per second. Must be greater than the chunk size.

 :   **\[copy-to:keyspace\_name.table\_name\]**

 pagetimeout
 :   Page timeout for fetching results.

 The location of the home directory depends on the type of installation:

|Linux installations|home/.cassandrawhere home is your home or client program directory.

|

The location of the cqlshrc.sample file depends on the type of installation:

|Package installations|/etc/cassandra/cqlshrc.sample|
|Tarball installations|install\_location/conf/cqlshrc.sample|

The location of the cassandra.yaml file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

**Parent topic:** [CQL shell commands](../../cql/cql_reference/cqlshCommandsTOC.md)

