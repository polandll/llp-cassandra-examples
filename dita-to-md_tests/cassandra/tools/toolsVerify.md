# nodetool verify {#toolsVerify .reference}

Verify \(check data checksum for\) one or more tables.

Verify \(check data checksum for\) one or more tables.

## Synopsis { .section}

```language-bash
nodetool [options] verify ﻿[(-e | --extended-verify)] [--] [<keyspace> <tables>...]
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`-e`|`--extended-verify`|Verify each cell data, beyond simply checking SSTable checksums.|
|`keyspace`|Name of keyspace.|
|table|One or more table names, separated by a space.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

**Note:** 

-   For tarball installations, execute the command from the install\_location/bin directory.
-   If a username and password for RMI authentication are set explicitly in the cassandra-env.sh file for the host, then you must specify credentials.
-   `nodetool verify` operates on a single node in the cluster if -h is not used to identify one or more other nodes. If the node from which you issue the command is the intended target, you do not need the -h option to identify the target; otherwise, for remote invocation, identify the target node, or nodes, using -h.

## Description { .section}

The `nodetool verify` command checks the data checksum for one or more specified tables. An optional argument, `-e` or -`-extended-verify`, will verify each cell data, whereas without the option, only the SSTable checksums are verified.

## Examples { .section}

```language-bash
nodetool -u cassandra -pw cassandra verify cycling cyclist_name 
```

The location of the cassandra-env.sh file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-env.sh|
|Tarball installations|install\_location/conf/cassandra-env.sh|

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

