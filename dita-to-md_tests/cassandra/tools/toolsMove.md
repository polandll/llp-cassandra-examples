# nodetool move {#toolsMove .reference}

Moves the node on the token ring to a new token.

Moves the node on the token ring to a new token.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> move *--* <new token>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`new token`|Number in partition range. For Murmur3Partitioner \(default\): -263 to +263-1.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

Escape negative tokens using \\\\ . For example: move \\\\-123. This command moves a node from one token value to another. This command is generally used to shift tokens slightly.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

