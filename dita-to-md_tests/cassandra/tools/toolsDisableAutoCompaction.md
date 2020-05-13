# nodetool disableautocompaction {#toolsDisableAutoCompaction .reference}

Disables autocompaction for a keyspace and one or more tables.

Disables autocompaction for a keyspace and one or more tables.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> disableautocompaction *--* <*keyspace*> ( <*table*> *...* )
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|keyspace|Keyspace name.|
|table|One or more table names, separated by a space.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

The keyspace can be followed by one or more tables.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

