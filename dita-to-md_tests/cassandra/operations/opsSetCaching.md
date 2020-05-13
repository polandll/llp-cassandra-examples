# Enabling and configuring caching {#opsSetCaching .task}

Using CQL to enable or disable caching.

Use CQL to enable or disable caching by configuring the caching [table property](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#tabProp__moreCaching). Set parameters in the cassandra.yaml file to configure global caching properties:

-   [Partition key cache size](../configuration/configCassandra_yaml.md#key_cache_size_in_mb)
-   [Row cache size](../configuration/configCassandra_yaml.md#row_cache_size_in_mb)
-   How often Cassandra [saves partition key caches](../configuration/configCassandra_yaml.md#key_cache_save_period) to disk
-   How often Cassandra [saves row caches](../configuration/configCassandra_yaml.md#row_cache_save_period) to disk

Configuring the row\_cache\_size\_in\_mb \(in the [cassandra.yaml](../configuration/configCassandra_yaml.md#row_cache_size_in_mb) configuration file\) determines how much space in memory Cassandra allocates to store rows from the most frequently read partitions of the table.

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

1.  Set the table caching property that configures the partition key cache and the row cache.

    ```
    CREATE TABLE users (
      userid text PRIMARY KEY,
      first_name text,
      last_name text,
    )
    WITH caching = { 'keys' : 'NONE', 'rows_per_partition' : '120' };
    ```


**Parent topic:** [Configuring data caches](../../cassandra/operations/opsConfiguringCaches.md)

