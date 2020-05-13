# nodetool sethintedhandoffthrottlekb {#toolsSetHHthrottle .reference}

Sets hinted handoff throttle in kb/sec per delivery thread.

Sets hinted handoff throttle in kb/sec per delivery thread.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> sethintedhandoffthrottlekb <value_in_kb/sec>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|value\_in\_kb/sec|Throttle time in kilobytes per second.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#toolsSetHHthrottleDesc .section}

When a node detects that a node for which it is holding hints has recovered, it begins sending the hints to that node. This setting specifies the maximum sleep interval per delivery thread in kilobytes per second after delivering each hint. The interval shrinks proportionally to the number of nodes in the cluster. For example, if there are two nodes in the cluster, each delivery thread uses the maximum interval; if there are three nodes, each node throttles to half of the maximum interval, because the two nodes are expected to deliver hints simultaneously.

## Example {#toolsSetHHthrottleEx .section}

```language-bash
nodetool sethintedhandoffthrottlekb 2048
```

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

