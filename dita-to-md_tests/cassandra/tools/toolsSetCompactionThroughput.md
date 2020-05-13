# nodetool setcompactionthroughput {#toolsSetCompactionThroughput .reference}

Sets the throughput capacity for compaction in the system, or disables throttling.

Sets the throughput capacity for compaction in the system, or disables throttling.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> setcompactionthroughput *--* <value_in_mb>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|value\_in\_mb|The throughput capacity in MB per second for compaction. To disable throttling, set to 0.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

Set value\_in\_mb to 0 to disable throttling.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

