# ByteOrderedPartitioner {#archPartitionerBOP .concept}

Cassandra provides this partitioner for ordered partitioning. It is included for backwards compatibility.

Cassandra provides the `ByteOrderedPartitioner` for ordered partitioning. It is included for backwards compatibility. This partitioner orders rows lexically by key bytes. You calculate tokens by looking at the actual values of your partition key data and using a hexadecimal representation of the leading character\(s\) in a key. For example, if you wanted to partition rows alphabetically, you could assign an A token using its hexadecimal representation of 41.

Using the ordered partitioner allows ordered scans by primary key. This means you can scan rows as though you were moving a cursor through a traditional index. For example, if your application has user names as the partition key, you can scan rows for users whose names fall between Jake and Joe. This type of query is not possible using randomly partitioned partition keys because the keys are stored in the order of their MD5 hash \(not sequentially\).

Although having the capability to do range scans on rows sounds like a desirable feature of ordered partitioners, there are ways to achieve the same functionality using [table indexes](/en/cql-oss/3.3/cql/cql_using/useCreateTable.html).

Using an ordered partitioner is not recommended for the following reasons:

 Difficult load balancing
 :   More administrative overhead is required to load balance the cluster. An ordered partitioner requires administrators to manually calculate [partition ranges](/en/glossary/doc/glossary/gloss_partition_range.html) based on their estimates of the partition key distribution. In practice, this requires actively moving node tokens around to accommodate the actual distribution of data once it is loaded.

  Sequential writes can cause hot spots
 :   If your application tends to write or update a sequential block of rows at a time, then the writes are not be distributed across the cluster; they all go to one node. This is frequently a problem for applications dealing with timestamped data.

  Uneven load balancing for multiple tables
 :   If your application has multiple tables, chances are that those tables have different row keys and different distributions of data. An ordered partitioner that is balanced for one table may cause hot spots and uneven distribution for another table in the same cluster.

 **Parent topic:** [Partitioners](../../cassandra/architecture/archPartitionerAbout.md)

