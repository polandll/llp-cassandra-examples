# nodetool disablehintsfordc {#toolsDisablehintsfordc .reference}

Disable hints for a datacenter.

Disable hints for a datacenter.

## Synopsis { .section}

```language-bash
nodetool [options] disablehintsfordc [--] <datacenter>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|datacenter|The data center to disable.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

**Note:** 

-   For tarball installations, execute the command from the install\_location/bin directory.
-   If a username and password for RMI authentication are set explicitly in the cassandra-env.sh file for the host, then you must specify credentials.
-   `nodetool disablehintsfordc` operates on a single node in the cluster if -h is not used to identify one or more other nodes. If the node from which you issue the command is the intended target, you do not need the -h option to identify the target; otherwise, for remote invocation, identify the target node, or nodes, using -h.
-   \[--\] can be used to separate command-line options from the list of arguments, when the list might be mistaken for options.

## Description { .section}

The `nodetool disablehintsfordc` command is used to turn off hints for a datacenter. This can be useful if there is a downed datacenter, but hints should continue on other datacenters. Another common case is during datacenter failover, when hints will put unnecessary pressure on the datacenter.

## Examples { .section}

```language-bash
nodetool -u cassandra -pw cassandra disablehintsfordc DC2 
```

The location of the cassandra-env.sh file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-env.sh|
|Tarball installations|install\_location/conf/cassandra-env.sh|

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

