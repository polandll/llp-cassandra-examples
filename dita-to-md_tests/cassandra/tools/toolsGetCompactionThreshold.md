# nodetool getcompactionthreshold {#toolsGetCompactionThreshold .reference}

Provides the minimum and maximum compaction thresholds in megabytes for a table.

Provides the minimum and maximum compaction thresholds in megabytes for a table.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> getcompactionthreshold *--* <*keyspace*> <*table*>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|keyspace|Name of keyspace.|
|table|Name of table.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

