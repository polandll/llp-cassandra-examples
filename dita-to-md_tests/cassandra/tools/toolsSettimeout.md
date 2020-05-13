# nodetool settimeout {#toolsSettimeout .reference}

Set the specified timeout in milliseconds, or 0 to disable timeout.

Set the specified timeout in milliseconds, or 0 to disable timeout. \(Cassandra 3.4 and later\).

## Synopsis { .section}

```language-bash
nodetool [options] settimeout [--] <timeout_type> <timeout_in_ms>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|timeout\_type|Type of timeout. Type should be one of read, range, write, counterwrite, cascontention, truncate, streamingsocket, misc \(general rpc\_timeout\_in\_ms\).|
|timeout\_in\_ms|Timeout in in milliseconds. To disable socket streaming, set to 0.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

**Note:** 

-   For tarball installations, execute the command from the install\_location/bin directory.
-   If a username and password for RMI authentication are set explicitly in the cassandra-env.sh file for the host, then you must specify credentials.
-   -- separates an option and argument that could be mistaken for a option.
-   The timeout type:
    -   read
    -   range
    -   write
    -   counterwrite
    -   cascontention
    -   truncate
    -   streamingsocket
    -   misc, such as general rpc\_timeout\_in\_ms

## Description { .section}

The `nodetool gettimeout` command sets the specified timeout in milliseconds. Use "0" to disable a timeout. Several timeouts are available.

## Examples { .section}

```language-bash
nodetool -u cassandra -pw cassandra settimeout read 100
```

The location of the cassandra-env.sh file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-env.sh|
|Tarball installations|install\_location/conf/cassandra-env.sh|

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

