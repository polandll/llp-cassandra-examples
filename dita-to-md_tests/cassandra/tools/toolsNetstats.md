# nodetool netstats {#toolsNetstats .reference}

Provides network information about the host.

Provides network information about the host.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> netstats *-H*
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`_H`|`--human-readable`|Display bytes in human readable form: KiB \(kibibyte\), MiB \(mebibyte\), GiB \(gibibyte\), TiB \(tebibyte\).|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

The default host is the connected host if the user does not include a host name or IP address in the command. The output includes the following information:

-   JVM settings
-   Mode

    The operational mode of the node: JOINING, LEAVING, NORMAL, DECOMMISSIONED, CLIENT

-   Read repair statistics
-   Attempted

    The number of successfully completed [read repair operations](../dml/dmlClientRequestsRead.md)

-   Mismatch \(blocking\)

    The number of read repair operations since server restart that blocked a query.

-   Mismatch \(background\)

    The number of read repair operations since server restart performed in the background.

-   Pool name

    Information about client read and write requests by thread pool.

-   Active, pending, and completed number of commands and responses


## Example {#example .section}

Get the network information for a node 10.171.147.128:

```language-bash
nodetool -h 10.171.147.128 netstats
```

The output is:

```
Mode: NORMAL
Not sending any streams.
Read Repair Statistics:
Attempted: 0
Mismatch (Blocking): 0
Mismatch (Background): 0
Pool Name                    Active   Pending      Completed
Commands                        n/a         0           1156
Responses                       n/a         0           2750
```

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

