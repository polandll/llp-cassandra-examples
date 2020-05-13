# nodetool resetlocalschema {#toolsResetLocalSchema .reference}

Reset the node's local schema and resynchronizes.

Reset the node's local schema and resynchronizes.

## Synopsis {#synopsis .section}

```language-bash
nodetool [options] resetlocalschema [args]
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
-   `nodetool resetlocalschema` operates on a single node in the cluster if -h is not used to identify one or more other nodes. If the node from which you issue the command is the intended target, you do not need the -h option to identify the target; otherwise, for remote invocation, identify the target node, or nodes, using -h.

## Description {#description .section}

Normally, this command is used to rectify schema disagreements on different nodes. It can be useful if table schema changes have generated too many tombstones, on the order of 100,000s.

`nodetool resetlocalschema` drops the schema information of the local node and resynchronizes the schema from another node. To drop the schema, the tool truncates all the system schema tables. The node will temporarily lose metadata about the tables on the node, but will rewrite the information from another node. If the node is experiencing problems with too many tombstones, the truncation of the tables will eliminate the tombstones.

This command is useful when you have one node that is out of sync with the cluster. The system schema tables must have another node from which to fetch the tables. It is not useful when all or many of your nodes are in an incorrect state. If there is only one node in the cluster \(replication factor of 1\) – it does not perform the operation, because another node from which to fetch the tables does not exist. Run the command on the node experiencing difficulty.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

