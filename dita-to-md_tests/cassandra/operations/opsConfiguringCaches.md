# Configuring data caches {#opsConfiguringCaches .concept}

Cassandra includes integrated caching and distributes cache data around the cluster. The integrated architecture facilitates troubleshooting and the cold start problem.

Cassandra includes integrated caching and distributes cache data around the cluster. When a node goes down, the client can read from another cached replica of the data. The integrated architecture also facilitates troubleshooting because there is no separate caching tier, and cached data matches what is in the database exactly. The integrated cache alleviates the cold start problem by saving the cache to disk periodically. Cassandra reads contents back into the cache and distributes the data when it restarts. The cluster does not start with a cold cache.

The saved key cache files include the ID of the table in the file name. A saved key cache filename for the `users` table in the `mykeyspace` keyspace looks similar to: mykeyspace-users.users\_name\_idx-19bd7f80352c11e4aa6a57448213f97f-KeyCache-b.db2046071785672832311.tmp

## About the partition key cache {#about-the-partition-key-cache .section}

The partition key cache is a cache of the [partition index](/en/cql-oss/3.3/cql/cql_using/useCreateTable.html) for a Cassandra table. Using the key cache instead of relying on the OS page cache decreases seek times. Enabling just the key cache results in disk \(or OS page cache\) activity to actually read the requested data rows, but not enabling the key cache results in more reads from disk.

## About the row cache {#about-the-row-cache .section}

**Note:** Utilizing appropriate OS page cache will result in better performance than using row caching. Consult resources for page caching for the operating system on which Cassandra is hosted.

Configure the number of rows to cache in a partition by setting the rows\_per\_partition table option. To cache rows, if the row key is not already in the cache, Cassandra reads the first portion of the partition, and puts the data in the cache. If the newly cached data does not include all cells configured by user, Cassandra performs another read. The actual size of the row-cache depends on the workload. You should properly benchmark your application to get ”the best” row cache size to configure.

There are two row cache options, the old serializing cache provider and a new off-heap cache \(OHC\) provider. The new OHC provider has been benchmarked as performing about 15% better than the older option.

## Using key cache and row cache { .section}

Typically, you enable either the partition key or row cache for a table.

**Tip:** Enable a row cache only when the number of reads is much bigger \(rule of thumb is 95%\) than the number of writes. Consider using the operating system page cache instead of the row cache, because writes to a partition invalidate the whole partition in the cache.

**Tip:** Disable caching entirely for archive tables, which are infrequently read.

-   **[Enabling and configuring caching](../../cassandra/operations/opsSetCaching.md)**  
Using CQL to enable or disable caching.
-   **[Tips for efficient cache use](../../cassandra/operations/opsCacheTips.md)**  
Various tips for efficient cache use.

**Parent topic:** [Data caching](../../cassandra/operations/opsDataCachingTOC.md)

