# nodetool truncatehints {#toolsTruncateHints .reference}

Truncates all hints on the local node, or truncates hints for the one or more endpoints.

Truncates all hints on the local node, or truncates hints for the one or more endpoints.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> truncatehints **--**  *<endpoint\> ...* 
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|endpoint|One or more endpoint IP addresses or host names designating which hints to deleted.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

