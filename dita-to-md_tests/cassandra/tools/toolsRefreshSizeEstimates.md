# nodetool refreshsizeestimates {#toolsRefreshSizeEstimates .reference}

Refresh system.size\_estimates table.

Refreshes system.size\_estimates table. Use when huge amounts of data are inserted or truncated which can result in size estimates becoming incorrect.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> refreshsizeestimates
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

