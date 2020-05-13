# nodetool setcachecapacity {#toolsSetCacheCapacity .reference}

Set global key and row cache capacities in megabytes.

Set global key and row cache capacities in megabytes.

## Synopsis {#synopsis .section}

```language-bash
nodetool <*options*> setcachecapacity *--* <key-cache-capacity> <row-cache-capacity>
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|key-cache-capacity|Maximum size in MB of the key cache in memory.|
|row-cache-capacity|Maximum size in MB of the row cache in memory.|
|counter-cache-capacity|Maximum size in MB of the counter cache in memory.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

The key-cache-capacity argument corresponds to the [key\_cache\_size\_in\_mb](../configuration/configCassandra_yaml.md#key_cache_size_in_mb) parameter in the cassandra.yaml. Each key cache hit saves one seek and each row cache hit saves a minimum of two seeks. Devoting some memory to the key cache is usually a good tradeoff considering the positive effect on the response time. The default value is empty, which means a minimum of five percent of the heap in MB or 100 MB.

The row-cache-capacity argument corresponds to the [row\_cache\_size\_in\_mb](../configuration/configCassandra_yaml.md#row_cache_size_in_mb) parameter in the cassandra.yaml. By default, row caching is zero \(disabled\).

The counter-cache-capacity argument corresponds to the [counter\_cache\_size\_in\_mb](../configuration/configCassandra_yaml.md#counter_cache_size_in_mb) in the cassandra.yaml. By default, counter caching is a minimum of 2.5% of Heap or 50MB.

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

