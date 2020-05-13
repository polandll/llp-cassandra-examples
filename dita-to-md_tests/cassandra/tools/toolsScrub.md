# nodetool scrub {#toolsScrub .reference}

Rebuild SSTables for one or more Cassandra tables.

Rebuild SSTables for one or more Cassandra tables.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> scrub <*keyspace*> *--*  *-ns \| --no-snapshot*   *-s \| --skip-corrupted*   <*table*>* ...* 
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`-s`|`--skip-corrupted`|Skip corrupted partitions even when scrubbing counter tables \(default false\).|
|`-n`|`--no-validate`|Do not validate columns using column validator.|
|`-ns`|`--no-snapshot`|Triggers a snapshot of the scrubbed table first assuming snapshots are not disabled \(default\).|
|keyspace|Name of keyspace.|
|table|One or more table names, separated by a space.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

Rebuilds SSTables on a node for the named tables and snapshots data files before rebuilding as a safety measure. If possible use [nodetool upgradesstables](toolsUpgradeSstables.md). While scrub rebuilds SSTables, it also discards data that it deems broken and creates a snapshot, which you have to remove manually. If the `--no-snapshot` option is specified, snapshot creation is disabled. If scrub can't validate the column value against the column definition's data type, it logs the partition key and skips to the next partition. Skipping corrupted partitions in tables having counter columns results in under-counting. By default the scrub operation stops if you attempt to skip such a partition. To force the scrub to skip the partition and continue scrubbing, re-run nodetool scrub using the `--skip-corrupted` option.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

