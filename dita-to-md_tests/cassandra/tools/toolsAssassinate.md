# nodetool assassinate {#toolsAssassinate .reference}

Forcefully removes a dead node without re-replicating any data. It is a last resort tool if you cannot successfully use nodetool removenode.

Forcefully removes a dead node without re-replicating any data. It is a last resort tool if you cannot successfully use [nodetool removenode](toolsRemoveNode.md).

## Synopsis { .section}

```language-bash
nodetool [options] assassinate <ip_address>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|ip\_address|IP address of the endpoint to assassinate.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

**Note:** 

-   For tarball installations, execute the command from the install\_location/bin directory.
-   If a username and password for RMI authentication are set explicitly in the cassandra-env.sh file for the host, then you must specify credentials.
-   `nodetool assassinate` operates on a single node in the cluster if -h is not used to identify one or more other nodes. If the node from which you issue the command is the intended target, you do not need the -h option to identify the target; otherwise, for remote invocation, identify the target node, or nodes, using -h.

## Description { .section}

The `nodetool assassinate` command is a tool of last resort. Only use this tool to remove a node from a cluster when `removenode` is not successful.

## Examples { .section}

```language-bash
nodetool -u cassandra -pw cassandra assassinate 192.168.100.2
```

The location of the cassandra-env.sh file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-env.sh|
|Tarball installations|install\_location/conf/cassandra-env.sh|

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

