# Partitioners {#archPartitionerAbout .concept}

A partitioner determines how data is distributed across the nodes in the cluster \(including replicas\).

A partitioner determines how data is distributed across the nodes in the cluster \(including replicas\). Basically, a partitioner is a function for deriving a token representing a row from its partition key, typically by hashing. Each row of data is then distributed across the cluster by the value of the token.

Both the `Murmur3Partitioner` and `RandomPartitioner` use tokens to help assign equal portions of data to each node and evenly distribute data from all the tables throughout the ring or other grouping, such as a keyspace. This is true even if the tables use different [partition keys](/en/glossary/doc/glossary/gloss_partition_key.html), such as usernames or timestamps. Moreover, the read and write requests to the cluster are also evenly distributed and load balancing is simplified because each part of the hash range receives an equal number of rows on average. For more detailed information, see [Consistent hashing](archDataDistributeHashing.md).

The main difference between the two partitioners is how each generates the token hash values. The `RandomPartitioner` uses a cryptographic hash that takes longer to generate than the `Murmur3Partitioner`. Cassandra doesn't really need a cryptographic hash, so using the `Murmur3Partitioner` results in a 3-5 times improvement in performance.

Cassandra offers the following partitioners that can be set in the [cassandra.yaml file](../configuration/configCassandra_yaml.md).

-   `Murmur3Partitioner` \(default\): uniformly distributes data across the cluster based on MurmurHash hash values.
-   `RandomPartitioner`: uniformly distributes data across the cluster based on MD5 hash values.
-   `ByteOrderedPartitioner`: keeps an ordered distribution of data lexically by key bytes

The `Murmur3Partitioner` is the default partitioning strategy for Cassandra 1.2 and later new clusters and the right choice for new clusters in almost all cases. However, the partitioners are not compatible and data partitioned with one partitioner cannot be easily converted to the other partitioner.

**Note:** If using virtual nodes \(vnodes\), you do **not** need to calculate the tokens. If not using vnodes, you **must** calculate the tokens to assign to the [initial\_token](../configuration/configCassandra_yaml.md#initial_token) parameter in the cassandra.yaml file. See [Generating tokens](../configuration/configGenTokens.md) and use the method for the type of partitioner you are using.

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

-   **[Murmur3Partitioner](../../cassandra/architecture/archPartitionerM3P.md)**  
The Murmur3Partitioner provides fast hashing and good performance.
-   **[RandomPartitioner](../../cassandra/architecture/archPartitionerRandom.md)**  
The default partitioner prior to Cassandra 1.2.
-   **[ByteOrderedPartitioner](../../cassandra/architecture/archPartitionerBOP.md)**  
Cassandra provides this partitioner for ordered partitioning. It is included for backwards compatibility.

**Parent topic:** [Understanding the architecture](../../cassandra/architecture/archTOC.md)

**Related information**  


[Install locations](../install/installLocationsTOC.md)

