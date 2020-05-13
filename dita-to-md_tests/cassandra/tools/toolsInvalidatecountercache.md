# nodetool invalidatecountercache {#toolsInvalidatecountercache .reference}

Resets the global counter cache parameter, counter\_cache\_keys\_to\_save, to the default \(not set\), which saves all keys.

Invalidates the counter cache, and resets the global counter cache parameter, counter\_cache\_keys\_to\_save, to the default \(not set\), which saves all keys..

## Synopsis { .section}

```language-bash
nodetool [options] invalidatecountercache
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

**Note:** 

-   For tarball installations, execute the command from the install\_location/bin directory.
-   If a username and password for RMI authentication are set explicitly in the cassandra-env.sh file for the host, then you must specify credentials.
-   `nodetool invalidatecountercache` operates on a single node in the cluster if -h is not used to identify one or more other nodes. If the node from which you issue the command is the intended target, you do not need the -h option to identify the target; otherwise, for remote invocation, identify the target node, or nodes, using -h.

## Description { .section}

The `nodetool invalidatecountercache` command will invalidate the counter cache, and the system will start saving all counter keys.

## Examples { .section}

```language-bash
nodetool -u cassandra -pw cassandra invalidatecountercache
```

The location of the cassandra-env.sh file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-env.sh|
|Tarball installations|install\_location/conf/cassandra-env.sh|

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

