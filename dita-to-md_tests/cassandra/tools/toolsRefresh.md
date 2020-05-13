# nodetool refresh {#toolsRefresh .reference}

Loads newly placed SSTables onto the system without a restart.

Loads newly placed SSTables onto the system without a restart.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> refresh *--* <keyspace> <table>
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

