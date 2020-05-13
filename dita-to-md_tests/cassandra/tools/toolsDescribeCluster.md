# nodetool describecluster {#toolsDescribeCluster .reference}

Provide the name, snitch, partitioner and schema version of a cluster

Provide the name, snitch, partitioner and schema version of a cluster

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> describecluster *--* <datacenter> 
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

Describe cluster is typically used to validate the schema after upgrading. If a schema disagreement occurs, check for and [resolve schema disagreements](/en/dse-trblshoot/doc/troubleshooting/schemaDisagree.html).

## Example {#example .section}

```language-bash
nodetool describecluster
```

```
Cluster Information:
	Name: Test Cluster
	Snitch: org.apache.cassandra.locator.DynamicEndpointSnitch
	Partitioner: org.apache.cassandra.dht.Murmur3Partitioner
	Schema versions:
		65e78f0e-e81e-30d8-a631-a65dff93bf82: [127.0.0.1]
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

