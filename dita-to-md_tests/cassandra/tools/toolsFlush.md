# nodetool flush {#toolsFlush .reference}

Flushes one or more tables from the memtable.

Flushes one or more tables from the memtable.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> flush *--* <*keyspace*> ( <*table*> ... )
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|keyspace|Name of keyspace.|
|table|One or more table names, separated by a space.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

You can specify a keyspace followed by one or more tables that you want to flush from the memtable to SSTables on disk.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

