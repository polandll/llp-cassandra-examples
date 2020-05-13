# nodetool viewbuildstatus {#toolsViewBuildStatus .reference}

Shows the progress of a materialized view build.

Shows the progress of a materialized view build.

## Synopsis { .section}

```language-bash
nodetool viewbuildstatus <keyspace> <view> | <keyspace.view>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`keyspace` |The name of the keyspace.|
|`view`|The name of the view.You can also use keyspace.view.

|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description { .section}

Shows the progress of a materialized view build.

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

