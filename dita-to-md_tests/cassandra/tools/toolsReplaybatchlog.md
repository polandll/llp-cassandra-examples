# nodetool replaybatchlog {#toolsReplaybatchlog .reference}

Replay batchlog and wait for finish.

Replay batchlog and wait for finish.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> replaybatchlog 
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description { .section}

`nodetool replaybatchlog` is intended to force a batchlog replay. It also blocks until the batches have been replayed.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

