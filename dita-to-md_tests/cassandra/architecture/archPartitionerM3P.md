# Murmur3Partitioner {#archPartitionerM3P .concept}

The Murmur3Partitioner provides fast hashing and good performance.

The Murmur3Partitioner is the default partitioner. The Murmur3Partitioner provides faster hashing and improved performance than the RandomPartitioner. The `Murmur3Partitioner` can be used with vnodes. However, if you don't use vnodes, you must calculate the tokens, as described in [Generating tokens](../configuration/configGenTokens.md).

Use `Murmur3Partitioner` for new clusters; you cannot change the partitioner in existing clusters that use a different partitioner. The `Murmur3Partitioner` uses the MurmurHash function. This hashing function creates a 64-bit hash value of the partition key. The possible range of hash values is from -263 to +263-1.

When using the `Murmur3Partitioner`, you can page through all rows using the [token function](/en/cql-oss/3.3/cql/cql_reference/cqlshPaging.html) in a CQL query.

**Parent topic:** [Partitioners](../../cassandra/architecture/archPartitionerAbout.md)

