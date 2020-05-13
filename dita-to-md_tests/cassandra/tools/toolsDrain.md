# nodetool drain {#toolsDrain .reference}

Drains the node.

Drains the node.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> drain
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

Flushes all memtables from the node to SSTables on disk. Cassandra stops listening for connections from the client and other nodes. You need to restart Cassandra after running nodetool drain. You typically use this command before upgrading a node to a new version of Cassandra. To simply flush memtables to disk, use nodetool flush.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

