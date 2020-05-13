# nodetool listsnapshots {#toolsListSnapShots .reference}

Lists snapshot names, size on disk, and true size.

Lists snapshot names, size on disk, and true size.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> listsnapshots
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Example {#toolsListSnapShotEx .section}

```
Snapshot Details: 
Snapshot Name  Keyspace   Column Family  True Size   Size on Disk 

1387304478196  Keyspace1  Standard1      0 bytes     308.66 MB
1387304417755  Keyspace1  Standard1      0 bytes     107.21 MB
1387305820866  Keyspace1  Standard2      0 bytes      41.69 MB                   
               Keyspace1  Standard1      0 bytes     308.66 MB
```

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

