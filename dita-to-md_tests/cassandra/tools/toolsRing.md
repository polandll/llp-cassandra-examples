# nodetool ring {#toolsRing .reference}

Provides node status and information about the ring.

Provides node status and information about the ring.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> ring ( *-r *| *--resolve-ip *) *--* <keyspace>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`-r`|`--resolve-ip`|Provide node names instead of IP addresses.|
|keyspace |Name of keyspace.|
|`--` |Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

Displays node status and information about the ring as determined by the node being queried. This information can give you an idea of the load balance and if any nodes are down. If your cluster is not properly configured, different nodes may show a different ring. Check that the node appears the same way in the ring.If you use virtual nodes \(vnodes\), use nodetool status for succinct output.

-   Address

    The node's URL.

-   DC \(datacenter\)

    The datacenter containing the node.

-   Rack

    The rack or, in the case of Amazon EC2, the availability zone of the node.

-   Status - Up or Down

    Indicates whether the node is functioning or not.

-   State - N \(normal\), L \(leaving\), J \(joining\), M \(moving\)

    The state of the node in relation to the cluster.

-   Load - updates every 90 seconds

    The amount of file system data under the cassandra data directory after excluding all content in the snapshots subdirectories. Because all SSTable data files are included, any data that is not cleaned up, such as TTL-expired cell or tombstoned data\) is counted.

-   Token

    The end of the token range up to and including the value listed. For an explanation of token ranges, see [Data Distribution in the Ring](/en/archived/cassandra/1.1/docs/cluster_architecture/partitioning.html#data-distribution-in-the-ring) .

-   Owns

    The percentage of the data owned by the node per datacenter times the replication factor. For example, a node can own 33% of the ring, but show100% if the replication factor is 3.

-   Host ID

    The network ID of the node.


**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

