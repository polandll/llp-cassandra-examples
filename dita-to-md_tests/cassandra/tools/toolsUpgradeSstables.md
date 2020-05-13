# nodetool upgradesstables {#toolsUpgradeSstables .reference}

Rewrites SSTables for tables that are not running the current version of Cassandra.

Rewrites SSTables for tables that are not running the current version of Cassandra.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> upgradesstables
 ( *-a *| *--include-all-sstables *) 
 *--* *<keyspace\>*  *<table\> ...* 
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|-a|--include-all-sstables|Snapshot name.|
|keyspace|Name of keyspace.|
|table|One or more table names, separated by a space.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

Rewrites SSTables on a node that are incompatible with the current version. Use this command when upgrading your server or changing compression options.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

