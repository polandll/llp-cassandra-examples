# nodetool status {#toolsStatus .reference}

Provide information about the cluster, such as the state, load, and IDs.

Provide information about the cluster, such as the state, load, and IDs.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> status ( *-r *| *--resolve-ip *) *--* *<keyspace\>*
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`-r`|`--resolve-ip`|Show node names instead of IP addresses.|
|keyspace|Name of keyspace.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

The status command provides the following information:

-   Status - U \(up\) or D \(down\)

    Indicates whether the node is functioning or not.

-   State - N \(normal\), L \(leaving\), J \(joining\), M \(moving\)

    The state of the node in relation to the cluster.

-   Address

    The node's URL.

-   Load - updates every 90 seconds

    The amount of file system data under the cassandra data directory after excluding all content in the snapshots subdirectories. Because all SSTable data files are included, any data that is not cleaned up, such as TTL-expired cell or tombstoned data\) is counted.

-   Tokens

    The number of tokens set for the node.

-   Owns

    The percentage of the data owned by the node per datacenter times the replication factor. For example, a node can own 33% of the ring, but show 100% if the replication factor is 3.

    **Attention:** If your cluster uses keyspaces having different replication strategies or replication factors, specify a keyspace when you run nodetool status to get meaningful ownership information.

-   Host ID

    The network ID of the node.

-   Rack

    The rack or, in the case of Amazon EC2, the availability zone of the node.


Example

This example shows the output from running nodetool status.

```language-bash
nodetool status mykeyspace

Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address    Load       Tokens  Owns    Host ID                               Rack
UN  127.0.0.1  47.66 KB   1       33.3%   aaa1b7c1-6049-4a08-ad3e-3697a0e30e10  rack1
UN  127.0.0.2  47.67 KB   1       33.3%   1848c369-4306-4874-afdf-5c1e95b8732e  rack1
UN  127.0.0.3  47.67 KB   1       33.3%   49578bf1-728f-438d-b1c1-d8dd644b6f7f  rack1
```

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

