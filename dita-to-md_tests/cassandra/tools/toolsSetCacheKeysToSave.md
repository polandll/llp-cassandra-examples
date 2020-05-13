# nodetool setcachekeystosave {#toolsSetCacheKeysToSave .reference}

Sets the number of keys saved by each cache for faster post-restart warmup.

Sets the number of keys saved by each cache for faster post-restart warmup.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> setcachekeystosave *--* <key-cache-keys-to-save> <row-cache-keys-to-save>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|key-cache-keys-to-save|The number of keys from the key cache to save to the saved caches directory. To disable, set to 0.|
|row-cache-keys-to-save|The number of keys from the row cache to save to the saved caches directory. To disable, set to 0.|
|counter-cache-keys-to-save|The number of keys from the counter cache to saved to the saved caches directory. To disable, set to 0.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

This command saves the specified number of key and row caches to the saved caches directory, which you specify in the cassandra.yaml. The key-cache-keys-to-save argument corresponds to the key\_cache\_keys\_to\_save in the cassandra.yaml, which is disabled by default, meaning all keys will be saved. The row-cache-keys-to-save argument corresponds to the row\_cache\_keys\_to\_save in the cassandra.yaml, which is disabled by default.

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

