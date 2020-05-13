# nodetool rebuild\_index {#toolsRebuildIndex .reference}

Performs a full rebuild of the index for a table

Performs a full rebuild of the index for a table

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> rebuild_index *--*  <keyspace> <table> <*indexName*> ...  
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|keyspace|Name of keyspace.|
|table|One or more table names, separated by a space.|
|indexName|List of index names separated by a space.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

The keyspace and table name followed by a list of index names. For example: `Standard3.IdxName Standard3.IdxName1`

## Description {#description .section}

Fully rebuilds one or more indexes for a table.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

