# Monitoring and adjusting caching {#opsMonitoringCache .concept}

Use nodetool to make changes to cache options and then monitor the effects of each change.

Make changes to cache options in small, incremental adjustments, then monitor the effects of each change using the [nodetool utility](../tools/toolsNodetool.md). The output of the nodetool info command shows the following row cache and key cache setting values, which are configured in the cassandra.yaml file:

-   Cache size in bytes
-   Capacity in bytes
-   Number of hits
-   Number of requests
-   Recent hit rate
-   Duration in seconds after which Cassandra saves the key cache.

For example, on start-up, the information from nodetool info might look something like this:

```
ID               : 387d15ba-7103-491b-9327-1a691dbb504a
Gossip active    : true
Thrift active    : true
Native Transport active: true
Load             : 65.87 KB
Generation No    : 1400189757
Uptime (seconds) : 148760
Heap Memory (MB) : 392.82 / 1996.81
datacenter      : datacenter1
Rack             : rack1
Exceptions       : 0
Key Cache        : entries 10, size 728 (bytes), capacity 103809024 (bytes), 93 hits, 102 requests, 0.912 recent hit rate, 14400 save period in seconds
Row Cache        : entries 0, size 0 (bytes), capacity 0 (bytes), 0 hits, 0 requests, NaN recent hit rate, 0 save period in seconds
Counter Cache    : entries 0, size 0 (bytes), capacity 51380224 (bytes), 0 hits, 0 requests, NaN recent hit rate, 7200 save period in seconds
Token            : -9223372036854775808
```

In the event of high memory consumption, consider tuning data caches.

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

**Parent topic:** [Data caching](../../cassandra/operations/opsDataCachingTOC.md)

