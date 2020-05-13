# nodetool invalidaterowcache {#toolsInvalidateRowCache .reference}

Resets the global key cache parameter, row\_cache\_keys\_to\_save, to the default \(not set\), which saves all keys.

Resets the global key cache parameter, row\_cache\_keys\_to\_save, to the default \(not set\), which saves all keys.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> invalidaterowcache
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

