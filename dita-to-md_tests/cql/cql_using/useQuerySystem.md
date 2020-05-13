# Querying a system table {#useQuerySystem .concept}

Details about Cassandra database objects and cluster configuration in the system keyspace tables.

The system keyspace includes a number of tables that contain details about your Cassandra database objects and cluster configuration.

Cassandra 2.2 populates these tables and others in the system keyspace.

|Table name|Column name|Comment|
|----------|-----------|-------|
|local|key, bootstrapped, broadcast\_address, cluster\_name, cql\_version, data\_center, gossip\_generation, host\_id, native\_protocol\_version, partitioner, rack, release\_version, rpc\_address, schema\_version, thrift\_version, tokens, truncated\_at map|Information on a node has about itself and a superset of [gossip](/en/glossary/doc/glossary/gloss_gossip.html).|
|peers|peer, data\_center, host\_id, preferred\_ip, rack, release\_version, rpc\_address, schema\_version, tokens|Each node records what other nodes tell it about themselves over the gossip.|
|schema\_aggregates|keyspace\_name, aggregate\_name, signature, argument\_types, final\_func, initcond, return\_type, state\_func, state\_type|Information about user-defined aggregates|
|schema\_columnfamilies|See comment.|Inspect schema\_columnfamilies to get detailed information about specific tables.|
|schema\_columns|keyspace\_name, columnfamily\_name, column\_name, component\_index, index\_name, index\_options, index\_type, validator|Information on columns and column indexes. Used internally for compound primary keys.|
|schema\_functions|keyspace\_name, function\_name, signature, argument\_names, argument\_types, body, called\_on\_null\_input, language, return\_type|Information on user-defined functions|
|schema\_keyspaces|keyspace\_name, durable\_writes, strategy\_class, strategy\_options|Information on keyspace strategy class and replication factor|
|schema\_usertypes|keyspace\_name, type\_name, field\_names, field\_types|Information about user-defined types|

Cassandra 3.0 populates these tables and others in the system keyspace.

|Table name|Column name|Comment|
|----------|-----------|-------|
|available\_ranges|keyspace\_name, ranges| |
|batches|id, mutations, version| |
|batchlog|id, data, version, written\_at| |
|built\_views|keyspace\_name, view\_name|Information on materialized views|
|compaction\_history|id, bytes\_in, bytes\_out, columnfamily\_name, compacted\_at, keyspace\_name, rows\_merged|Information on compaction history|
|hints|target\_id, hint\_id, message\_version, mutation| |
|"IndexInfo"|table\_name, index\_name|Information on indexes|
|local|key, bootstrapped, broadcast\_address, cluster\_name, cql\_version, data\_center, gossip\_generation, host\_id, listen\_address, native\_protocol\_version, partitioner, rack, release\_version, rpc\_address, schema\_version, thrift\_version, tokens, truncated\_at map|Information on a node has about itself and a superset of [gossip](/en/glossary/doc/glossary/gloss_gossip.html).|
|paxos|row\_key, cf\_id, in\_progress\_ballot, most\_recent\_commit, most\_recent\_commit\_at, most\_recent\_commit\_version, proposal, proposal\_ballot, proposal\_version|Information on lightweight Paxos transactions|
|peers|peer, data\_center, host\_id, preferred\_ip, rack, release\_version, rpc\_address, schema\_version, tokens|Each node records what other nodes tell it about themselves over the gossip.|
|peer\_events|peer, hints\_dropped| |
|range\_xfers|token\_bytes,requested\_at| |
|size\_estimates|keyspace\_name, table\_name, range\_start, range\_end, mean\_partition\_size, partitions\_count|Information on partitions|
|sstable\_activity|keyspace\_name, columnfamily\_name, generation, rate\_120m, rate\_15m| |
|views\_builds\_in\_progress|keyspace\_name, view\_name, generation\_number, last\_token| |

Cassandra 3.0 populates these tables in the system\_schema keyspace.

|Table name|Column name|Comment|
|----------|-----------|-------|
|aggregates|keyspace\_name, aggregate\_name, argument\_types, final\_func, initcond, return\_type, state\_func, state\_type|Information about user-defined aggregates|
|columns|keyspace\_name, table\_name, column\_name, clustering\_order, column\_name\_bytes, kind, position, type|Information about table columns|
|dropped\_columns|keyspace\_name, table\_name, column\_name, dropped\_time,type|Information about dropped columns|
|functions|keyspace\_name, function\_name, argument\_types, argument\_names, body, called\_on\_null\_input,language,return\_type|Information on user-defined functions|
|indexes|keyspace\_name, table\_name, index\_name, kind,options|Information about indexes|
|keyspaces|keyspace\_name, durable\_writes, replication|Information on keyspace durable writes and replication|
|tables|keyspace\_name, table\_name, bloom\_filter\_fp\_chance, caching, comment, compaction, compression, crc\_check\_chance, dclocal\_read\_repair\_chance, default\_time\_to\_live, extensions, flags, gc\_grace\_seconds, id, max\_index\_interval, memtable\_flush\_period\_in\_ms, min\_index\_interval, read\_repair\_chance, speculative\_retry|Information on columns and column indexes. Used internally for compound primary keys.|
|triggers|keyspace\_name, table\_name, trigger\_name, options|Information on triggers|
|types|keyspace\_name, type\_name, field\_names, field\_types|Information about user-defined types|
|views|keyspace\_name, view\_name, base\_table\_id, base\_table\_name, bloom\_filter\_fp\_chance, caching, comment, compaction, compression, crc\_check\_chance, dclocal\_read\_repair\_chance, default\_time\_to\_live, extensions, flags,gc\_grace\_seconds, include\_all\_columns, max\_index\_interval, memtable\_flush\_period\_in\_ms, min\_index\_interval, read\_repair\_chance, speculative\_retry, where\_clause|Information about materialized views|

-   **[Keyspace, table, and column information](../../cql/cql_using/useQuerySystemTable.md)**  
Querying system.schema\_\* tables directly to get keyspace, table, and column information.
-   **[Cluster information](../../cql/cql_using/useQuerySystemTableCluster.md)**  
Querying system tables to get cluster topology information.
-   **[Functions, aggregates, and user types](../../cql/cql_using/useQuerySystemTableUserDefined.md)**  
Querying system.schema\_\* tables directly to get information about user-defined functions, aggregates, and user types.

**Parent topic:** [Querying tables](../../cql/cql_using/useQueryDataTOC.md)

