# nodetool invalidatekeycache {#toolsInvalidateKeyCache .reference}

Resets the global key cache parameter to the default, which saves all keys.

Resets the global key cache parameter to the default, which saves all keys.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> invalidatekeycache
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

By default the key\_cache\_keys\_to\_save is disabled in the cassandra.yaml. This command resets the parameter to the default.

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

