# nodetool relocatesstables {#toolsRelocateSSTables .reference}

Rewrites any SSTable that contains tokens that should be in another data directory.

In Cassandra 3.2 and later, rewrites any SSTable that contains tokens that should be in another data directory for JBOD disks. Basically, this commands relocates SSTables to the correct disk.

## Synopsis {#synopsis .section}

```screen
$ nodetool <*options*>﻿relocatesstables *--* <keyspace> <table> 
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

## Description { .section}

This `nodetool` command can be used to manually rewrite the location of SSTables on disk. It is for use with JBOD disk storage. The command can also be used if you change the replication factor for the cluster stored on JBOD or if you add a new disk. If all the token are correctly stored in the data directories, `nodetool relocatesstables` will have no effect.

## Examples { .section}

Text

```
$ nodetool relocatesstables cycling
```

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

