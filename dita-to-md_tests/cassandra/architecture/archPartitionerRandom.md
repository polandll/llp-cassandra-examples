# RandomPartitioner {#archPartitionerRandom .concept}

The default partitioner prior to Cassandra 1.2.

The `RandomPartitioner` was the default partitioner prior to Cassandra 1.2. It is included for backwards compatibility. The RandomPartitioner can be used with virtual nodes \(vnodes\). However, if you don't use vnodes, you must calculate the tokens, as described in [Generating tokens](../configuration/configGenTokens.md).The `RandomPartitioner` distributes data evenly across the nodes using an MD5 hash value of the row key. The possible range of hash values is from 0 to 2127 -1.

When using the `RandomPartitioner`, you can page through all rows using the [token function](/en/cql-oss/3.3/cql/cql_reference/cqlshPaging.html) in a CQL query.

**Parent topic:** [Partitioners](../../cassandra/architecture/archPartitionerAbout.md)

