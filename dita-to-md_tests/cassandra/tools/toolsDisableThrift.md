# nodetool disablethrift {#toolsDisableThrift .reference}

Disables the Thrift server.

Disables the Thrift server.

## Synopsis {#synopsis .section}

```language-bash
nodetool [options] disablethrift
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
-   `nodetool disablethrift` operates on a single node in the cluster if -h is not used to identify one or more other nodes. If the node from which you issue the command is the intended target, you do not need the -h option to identify the target; otherwise, for remote invocation, identify the target node, or nodes, using -h.

## Description { .section}

`nodetool disablethrift` will disable thrift on a node preventing the node from acting as a coordinator. The node can still be a replica for a different coordinator and data read at consistency level ONE could be stale. To cause a node to ignore read requests from other coordinators, `nodetool disablegossip` would also need to be run. However, if both commands are run, the node will not perform repairs, and the node will continue to store stale data. If the goal is to repair the node, set the read operations to a consistency level of QUORUM or higher while you run repair. An alternative approach is to delete the node's data and restart the Cassandra process.

Note that the `nodetool` commands using the `-h` option will not work remotely on a disabled node until `nodetool enablethrift` and `nodetool enablegossip` are run locally on the disabled node.

## Examples { .section}

```language-bash
nodetool -u cassandra -pw cassandra disablethrift 192.168.100.1
```

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

