# nodetool compactionstats {#toolsCompactionStats .reference}

Provide statistics about a compaction.

Provide statistics about a compaction.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> compactionstats *-H*
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`-H`|`--human-readable`|Display bytes in human readable form: KiB \(kibibyte\), MiB \(mebibyte\), GiB \(gibibyte\), TiB \(tebibyte\).|

## Description {#description .section}

The total column shows the total number of uncompressed bytes of SSTables being compacted. The system log lists the names of the SSTables compacted.

## Example {#example .section}

```language-bash
nodetool compactionstats
```

```
pending tasks: 5
          compaction type        keyspace           table       completed           total      unit  progress
               Compaction       Keyspace1       Standard1       282310680       302170540     bytes    93.43%
               Compaction       Keyspace1       Standard1        58457931       307520780     bytes    19.01%
Active compaction remaining time :   0h00m16s
```

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

