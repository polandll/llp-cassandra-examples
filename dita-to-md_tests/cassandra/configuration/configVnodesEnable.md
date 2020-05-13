# Enabling virtual nodes on a new cluster {#configVnodesEnable .task}

Steps and recommendations for enabling virtual nodes \(vnodes\) on a new cluster.

Generally when all nodes have equal hardware capability, they should have the same number of virtual nodes \(vnodes\). If the hardware capabilities vary among the nodes in your cluster, assign a proportional number of vnodes to the larger machines. For example, you could designate your older machines to use 128 vnodes and your new machines \(that are twice as powerful\) with 256 vnodes.

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

1.  Set the number of tokens on each node in your cluster with the [num\_tokens](configCassandra_yaml.md#num_tokens) parameter in the cassandra.yaml file.

    The recommended value is 256. Do not set the [initial\_token](configCassandra_yaml.md#initial_token) parameter.


**Parent topic:** [Configuring virtual nodes](../../cassandra/configuration/configVirtualNodesTOC.md)

**Related information**  


[Install locations](../install/installLocationsTOC.md)

