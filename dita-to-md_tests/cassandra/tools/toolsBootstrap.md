# nodetool bootstrap {#toolsBootstrap .reference}

Monitor and manage a node's bootstrap process.

Monitor and manage a node's bootstrap process.

## Synopsis { .section}

```language-bash
nodetool [options] bootstrap [resume]
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
-   `nodetool bootstrap` operates on a single node in the cluster if -h is not used to identify one or more other nodes. If the node from which you issue the command is the intended target, you do not need the -h option to identify the target; otherwise, for remote invocation, identify the target node, or nodes, using -h.

## Description { .section}

The `nodetool bootstrap` command can be used to monitor and manage a node's bootstrap process. If no argument is defined, the help information is displayed. If the argument `resume` is used, bootstrap streaming is resumed.

## Examples { .section}

```language-bash
nodetool -u cassandra -pw cassandra bootstrap resume
```

The location of the cassandra-env.sh file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-env.sh|
|Tarball installations|install\_location/conf/cassandra-env.sh|

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

