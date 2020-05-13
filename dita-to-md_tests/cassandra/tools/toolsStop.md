# nodetool stop {#toolsStop .reference}

Stops the compaction process.

Stops the compaction process.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> stop **--** <compaction_type>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|compaction type|Supported types are COMPACTION, VALIDATION, CLEANUP, SCRUB, VERIFY, INDEX\_BUILD.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

**Note:** 

-   For tarball installations, execute the command from the install\_location/bin directory.
-   If a username and password for RMI authentication are set explicitly in the cassandra-env.sh file for the host, then you must specify credentials.
-   `nodetool stop` operates on a single node in the cluster if `-h` is not used to identify one or more other nodes. If the node from which you issue the command is the intended target, you do not need the `-h` option to identify the target; otherwise, for remote invocation, identify the target node, or nodes, using `-h`.
-   Valid compaction types: COMPACTION, VALIDATION, CLEANUP, SCRUB, INDEX\_BUILD

## Description {#description .section}

Stops all compaction operations from continuing to run. This command is typically used to stop a compaction that has a negative impact on the performance of a node. After the compaction stops, Cassandra continues with the remaining operations in the queue. Eventually, Cassandra restarts the compaction.

In Cassandra 2.2 and later, a single compaction operation can be stopped with the `-id` option. Run `nodetool compactionstats` to find the compaction ID.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

