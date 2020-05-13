# Configuring gossip settings {#configGossipSettings .task}

Using the cassandra.yaml file to configure gossip.

When a node first starts up, it looks at its cassandra.yaml configuration file to determine the name of the Cassandra cluster it belongs to; which nodes \(called seeds\) to contact to obtain information about the other nodes in the cluster; and other parameters for determining port and range information.

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

1.  In the cassandra.yaml file, set the following parameters:

    |Property|Description|
    |--------|-----------|
    |**[cluster\_name](configCassandra_yaml.md#cluster_name)**|Name of the cluster that this node is joining. Must be the same for every node in the cluster.|
    |**[listen\_address](configCassandra_yaml.md#listen_address)**|The IP address or hostname that Cassandra binds to for connecting this node to other nodes.|
    |**[listen\_interface](configCassandra_yaml.md#listen_interface)**|Use this option instead of listen\_address to specify the network interface by name, rather than address/hostname|
    |**\(Optional\) [broadcast\_address](configCassandra_yaml.md#broadcast_address)**| The "public" IP address this node uses to broadcast to other nodes outside the network or across regions in multiple-region EC2 deployments. If this property is commented out, the node uses the same IP address or hostname as `listen_address`. A node does not need a separate `broadcast_address` in a single-node or single-datacenter installation, or in an EC2-based network that supports automatic switching between private and public communication. It is necessary to set a separate `listen_address` and `broadcast_address` on a node with multiple physical network interfaces or other topologies where not all nodes have access to other nodes by their private IP addresses. For specific configurations, see the instructions for [listen\_address](configCassandra_yaml.md#listen_address). The default is the listen\_address.|
    |**[seed\_provider](configCassandra_yaml.md#seed_provider)**|A -seeds list is comma-delimited list of hosts \(IP addresses\) that gossip uses to learn the topology of the ring. Every node should have the same list of seeds. **Attention:** In multiple data-center clusters, include at least one node from each datacenter \(replication group\) in the seed list. Designating more than a single seed node per datacenter is recommended for fault tolerance. Otherwise, gossip has to communicate with another datacenter when bootstrapping a node.

Making every node a seed node is **not** recommended because of increased maintenance and reduced gossip performance. Gossip optimization is not critical, but it is recommended to use a small seed list \(approximately three nodes per datacenter\).

 |
    |**[storage\_port](configCassandra_yaml.md#storage_port)**|The inter-node communication port \(default is 7000\). Must be the same for every node in the cluster.|
    |**[initial\_token](configCassandra_yaml.md#initial_token)**|For legacy clusters. Set this property for single-node-per-token architecture, in which a node owns exactly one contiguous range in the ring space.|
    |**[num\_tokens](configCassandra_yaml.md#num_tokens)**|For new clusters. The number of tokens randomly assigned to this node in a cluster that uses [virtual nodes](configVnodesEnable.md) \(vnodes\).|


**Parent topic:** [Configuration](../../cassandra/configuration/configTOC.md)

