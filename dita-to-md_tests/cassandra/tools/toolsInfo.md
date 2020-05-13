# nodetool info {#toolsInfo .reference}

Provides node information, such as load and uptime.

Provides node information, such as load and uptime.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> info  *-T* | *--tokens* 
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`-T`|`--tokens`|Show all tokens.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

Provides node information including the token and on disk storage \(load\) information, times started \(generation\), uptime in seconds, and heap memory usage.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

