# nodetool removenode {#toolsRemoveNode .reference}

Provides the status of current node removal, forces completion of pending removal, or removes the identified node.

Provides the status of current node removal, forces completion of pending removal, or removes the identified node.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> removenode *--* <status> | <force> | <ID>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|status|Status of current node removal.|
|force|Forces completion of the pending removal.|
|ID |Host ID, in UUID format.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

This command removes a node, shows the status of a removal operation, or forces the completion of a pending removal. When the node is down and `nodetool decommission` cannot be used, use `nodetool removenode`. Run this command only on nodes that are down. If the cluster does not use vnodes, before running the `nodetool removenode` command, [adjust the tokens](../operations/opsRemoveNode.md).

## Examples {#examples .section}

Determine the UUID of the node to remove by running nodetool status. Use the UUID of the node that is down to remove the node.

```language-bash
nodetool status
```

```
Datacenter: DC1
===============
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address        Load       Tokens  Owns (effective)  Host ID                               Rack
UN  192.168.2.101  112.82 KB  256     31.7%             420129fc-0d84-42b0-be41-ef7dd3a8ad06  RAC1
DN  192.168.2.103  91.11 KB   256     33.9%             d0844a21-3698-4883-ab66-9e2fd5150edd  RAC1
UN  192.168.2.102  124.42 KB  256     32.6%             8d5ed9f4-7764-4dbd-bad8-43fddce94b7c  RAC1
```

```
$ nodetool removenode d0844a21-3698-4883-ab66-9e2fd5150edd
```

View the status of the operation to remove the node:

```language-bash
nodetool removenode status
```

```
RemovalStatus: No token removals in process.
```

Confirm that the node has been removed.

```language-bash
nodetool removenode status
```

```
Datacenter: DC1
===============
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address        Load       Tokens  Owns (effective)  Host ID                               Rack
UN  192.168.2.101  112.82 KB  256     37.7%             420129fc-0d84-42b0-be41-ef7dd3a8ad06  RAC1
UN  192.168.2.102  124.42 KB  256     38.3%             8d5ed9f4-7764-4dbd-bad8-43fddce94b7c  RAC1
```

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

