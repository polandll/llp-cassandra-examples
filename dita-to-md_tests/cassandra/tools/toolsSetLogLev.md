# nodetool setlogginglevel {#toolsSetLogLev .reference}

Set the log level for a service.

Set the log level for a service.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> setlogginglevel *--* <class> <level>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|class|The class for changing the level, a fully qualified domain name such as org.apache.cassandra.service.StorageProxy.|
|level |Logging level, for example DEBUG.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#toolsSetLogLevDescrip .section}

You can use this command to set logging levels for services instead of modifying the logback-text.xml file. The following values are valid for the logger class qualifier:

-   org.apache.cassandra
-   org.apache.cassandra.db
-   org.apache.cassandra.service.StorageProxy

The possible log levels are:

-   ALL
-   TRACE
-   DEBUG
-   INFO
-   WARN
-   ERROR
-   OFF

If both class qualifier and level arguments to the command are empty or null, the command resets logging to the initial configuration.

## Example {#toolsSetLogLevExample .section}

This command sets the StorageProxy service to debug level.

```language-bash
nodetool setlogginglevel org.apache.cassandra.service.StorageProxy DEBUG
```

**Note:** Cassandra 3.0 and later support extended logging for Compaction. This utility must be configured as part of the table configuration. The extended compaction logs are stored in a separate file. For details, see [Enabling extended compaction logging](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#compactSubprop__enabling-extended-compaction-logging).

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

