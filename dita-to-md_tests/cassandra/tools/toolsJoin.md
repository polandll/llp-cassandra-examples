# nodetool join {#toolsJoin .reference}

Causes the node to join the ring.

Causes the node to join the ring.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> join
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

Causes the node to join the ring, assuming the node was initially *not* started in the ring using the [-Djoin\_ring=false](toolsCUtility.md) cassandra utility option. The joining node should be properly configured with the desired options for seed list, initial token, and auto-bootstrapping.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

