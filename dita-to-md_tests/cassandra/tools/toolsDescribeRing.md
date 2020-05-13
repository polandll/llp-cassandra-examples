# nodetool describering {#toolsDescribeRing .reference}

Provides the partition ranges of a keyspace.

Provides the partition ranges of a keyspace.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> describering *--* <keyspace>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|keyspace|Name of keyspace.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Example {#example .section}

This example shows the sample output of the command on a three-node cluster.

```language-bash
nodetool describering demo_keyspace
```

```
Schema Version:1b04bd14-0324-3fc8-8bcb-9256d1e15f82
TokenRange: 
	TokenRange(start_token:3074457345618258602, end_token:-9223372036854775808, 
         endpoints:[127.0.0.1, 127.0.0.2, 127.0.0.3], 
         rpc_endpoints:[127.0.0.1, 127.0.0.2, 127.0.0.3], 
         endpoint_details:[EndpointDetails(host:127.0.0.1, datacenter:datacenter1, rack:rack1), 
         EndpointDetails(host:127.0.0.2, datacenter:datacenter1, rack:rack1), 
         EndpointDetails(host:127.0.0.3, datacenter:datacenter1, rack:rack1)])
	TokenRange(start_token:-3074457345618258603, end_token:3074457345618258602, 
         endpoints:[127.0.0.3, 127.0.0.1, 127.0.0.2], 
         rpc_endpoints:[127.0.0.3, 127.0.0.1, 127.0.0.2], 
         endpoint_details:[EndpointDetails(host:127.0.0.3, 
         datacenter:datacenter1, rack:rack1), 
         EndpointDetails(host:127.0.0.1, datacenter:datacenter1, rack:rack1), 
         EndpointDetails(host:127.0.0.2, datacenter:datacenter1, rack:rack1)])
	TokenRange(start_token:-9223372036854775808, end_token:-3074457345618258603, 
         endpoints:[127.0.0.2, 127.0.0.3, 127.0.0.1], 
         rpc_endpoints:[127.0.0.2, 127.0.0.3, 127.0.0.1], 
         endpoint_details:[EndpointDetails(host:127.0.0.2, datacenter:datacenter1, rack:rack1), 
         EndpointDetails(host:127.0.0.3, datacenter:datacenter1, rack:rack1), 
         EndpointDetails(host:127.0.0.1, datacenter:datacenter1, rack:rack1)])
```

If a schema disagreement occurs, the last line of the output includes information about unreachable nodes.

```language-bash
nodetool describecluster
```

```
Cluster Information:
	Name: Production Cluster
       Snitch: org.apache.cassandra.locator.DynamicEndpointSnitch
       Partitioner: org.apache.cassandra.dht.Murmur3Partitioner
       Schema versions:
              UNREACHABLE: 1176b7ac-8993-395d-85fd-41b89ef49fbb: [10.202.205.203]
```

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

