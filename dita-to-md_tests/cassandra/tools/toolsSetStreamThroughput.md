# nodetool setstreamthroughput {#toolsSetStreamThroughput .reference}

Sets the throughput capacity in Mb for outbound streaming in the system, or disables throttling.

Sets the throughput capacity in Mb \(megabits\) for streaming in the system, or disables throttling.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> setstreamthroughput *--* <value_in_mb>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|value\_in\_mb|Throughput capacity in megabits per second for streaming. To disable, set to 0.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

Set value\_in\_mb to 0 to disable throttling.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

