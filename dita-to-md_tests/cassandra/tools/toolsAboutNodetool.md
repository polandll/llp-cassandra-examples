# About the nodetool utility {#toolsAboutNodetool .reference}

A command line interface for managing a cluster.

The nodetool utility is a command line interface for managing a cluster.

## Command formats {#command-format .section}

```language-bash
nodetool [options] command [args]
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|

**Note:** 

-   For tarball installations, execute the command from the install\_location/bin directory.
-   If a username and password for RMI authentication are set explicitly in the cassandra-env.sh file for the host, then you must specify credentials.
-   The repair and rebuild commands can affect multiple nodes in the cluster.
-   Most nodetool commands operate on a single node in the cluster if -h is not used to identify one or more other nodes. If the node from which you issue the command is the intended target, you do not need the -h option to identify the target; otherwise, for remote invocation, identify the target node, or nodes, using -h.

Example

```language-bash
nodetool -u cassandra -pw cassandra describering demo_keyspace
```

The location of the cassandra-env.sh file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-env.sh|
|Tarball installations|install\_location/conf/cassandra-env.sh|

## Getting nodetool help {#getting-nodetool-help .section}

 `nodetool help`
 :   Provides a listing of nodetool commands.

  `nodetool help command name`
 :   Provides help on a specific command. For example:

    ```language-bash
    nodetool help upgradesstables
    ```

    For more information, see [nodetool help](toolsHelp.md)

 **Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

