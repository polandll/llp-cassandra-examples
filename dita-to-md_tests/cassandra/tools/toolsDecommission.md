# nodetool decommission {#toolsDecommission .reference}

Deactivates a node by streaming its data to another node.

Deactivates a node by streaming its data to another node.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> decommission
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

Causes a live node to decommission itself, streaming its data to the next node on the ring. Use [netstats](toolsNetstats.md) to monitor the progress, as described on [http://wiki.apache.org/cassandra/NodeProbe\#Decommission](http://wiki.apache.org/cassandra/NodeTool#Decommission) and [http://wiki.apache.org/cassandra/Operations\#Removing\_nodes\_entirely](http://wiki.apache.org/cassandra/Operations#Removing_nodes_entirely).

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

