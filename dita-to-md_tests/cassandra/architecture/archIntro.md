# Architecture in brief {#archIntro .concept}

Essential information for understanding and using Cassandra.

Cassandra is designed to handle big data workloads across multiple nodes with no single point of failure. Its architecture is based on the understanding that system and hardware failures can and do occur. Cassandra addresses the problem of failures by employing a peer-to-peer distributed system across homogeneous nodes where data is distributed among all nodes in the cluster. Each node frequently exchanges state information about itself and other nodes across the cluster using peer-to-peer [gossip](/en/glossary/doc/glossary/gloss_gossip.html) communication protocol. A sequentially written [commit log](/en/glossary/doc/glossary/gloss_commit_log.html) on each node captures write activity to ensure data durability. Data is then indexed and written to an in-memory structure, called a [memtable](/en/glossary/doc/glossary/gloss_memtable.html), which resembles a write-back cache. Each time the memory structure is full, the data is written to disk in an [SSTables](/en/glossary/doc/glossary/gloss_sstable.html) data file. All writes are automatically partitioned and replicated throughout the cluster. Cassandra periodically consolidates SSTables using a process called [compaction](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#tabProp__moreCompaction), discarding obsolete data marked for deletion with a [tombstone](/en/glossary/doc/glossary/gloss_tombstone.html). To ensure all data across the cluster stays consistent, various [repair](../operations/opsRepairNodesTOC.md) mechanisms are employed.

Cassandra is a partitioned row store database, where rows are organized into tables with a required primary key. Cassandra's architecture allows any [authorized user](../configuration/secureIntro.md) to connect to any node in any datacenter and access data using the CQL language. For ease of use, CQL uses a similar syntax to SQL and works with table data. Developers can access CQL through [cqlsh](/en/cql-oss/3.3/cql/cql_reference/cqlshCommandsTOC.html), [DevCenter](/en/archived/developer/devcenter/doc), and via [drivers](/en/developer/driver-matrix/doc/common/driverMatrix.html#driver-cmpt-matrix) for application languages. Typically, a cluster has one [keyspace](/en/glossary/doc/glossary/gloss_keyspace.html) per application composed of many different tables.

Client read or write requests can be sent to any node in the cluster. When a client connects to a node with a request, that node serves as the [coordinator](/en/glossary/doc/glossary/gloss_coordinator_node.html) for that particular client operation. The coordinator acts as a proxy between the client application and the nodes that own the data being requested. The coordinator determines which nodes in the ring should get the request based on how the cluster is configured.

## Key structures { .section}

-   Node

    Where you store your data. It is the basic infrastructure component of Cassandra.

-   datacenter

    A collection of related nodes. A datacenter can be a physical datacenter or virtual datacenter. Different workloads should use separate datacenters, either physical or virtual. Replication is set by datacenter. Using separate datacenters prevents Cassandra transactions from being impacted by other workloads and keeps requests close to each other for lower latency. Depending on the replication factor, data can be written to multiple datacenters. datacenters must never span physical locations.

-   Cluster

    A cluster contains one or more datacenters. It can span physical locations.

-   Commit log

    All data is written first to the commit log for durability. After all its data has been flushed to SSTables, it can be archived, deleted, or recycled.

-   SSTable

    A sorted string table \(SSTable\) is an immutable data file to which Cassandra writes memtables periodically. SSTables are append only and stored on disk sequentially and maintained for each Cassandra table.

-   CQL Table

    A collection of ordered columns fetched by table row. A table consists of columns and has a primary key.


## Key components for configuring Cassandra {#key-components .section}

-   [Gossip](archGossipAbout.md)

    A peer-to-peer communication protocol to discover and share location and state information about the other nodes in a Cassandra cluster. Gossip information is also persisted locally by each node to use immediately when a node restarts.

-   [Partitioner](archPartitionerAbout.md)

    A partitioner determines which node will receive the first replica of a piece of data, and how to distribute other replicas across other nodes in the cluster. Each row of data is uniquely identified by a primary key, which may be the same as its partition key, but which may also include other clustering columns. A partitioner is a hash function that derives a token from the primary key of a row. The partitioner uses the token value to determine which nodes in the cluster receive the replicas of that row. The [Murmur3Partitioner](archPartitionerM3P.md) is the default partitioning strategy for new Cassandra clusters and the right choice for new clusters in almost all cases.

    You must set the partitioner and assign the node a [num\_tokens](../configuration/configCassandra_yaml.md#num_tokens) value for each node. The number of tokens you assign depends on the [hardware capabilities](/en/landing_page/doc/landing_page/planning/planningHardware.html) of the system. If not using virtual nodes \(vnodes\), use the [initial\_token](../configuration/configCassandra_yaml.md#initial_token) setting instead.

-   [Replication factor](archDataDistributeReplication.md)

    The total number of replicas across the cluster. A replication factor of 1 means that there is only one copy of each row on one node. A replication factor of 2 means two copies of each row, where each copy is on a different node. All replicas are equally important; there is no primary or master replica. You define the replication factor for each datacenter. Generally you should set the replication strategy greater than one, but no more than the number of nodes in the cluster.

-   [Replica placement strategy](archDataDistributeReplication.md)

    Cassandra stores copies \(replicas\) of data on multiple nodes to ensure reliability and fault tolerance. A replication strategy determines which nodes to place replicas on. The first replica of data is simply the first copy; it is not unique in any sense. The [NetworkTopologyStrategy](archDataDistributeReplication.md#networkToplogyStrategy-ph) is highly recommended for most deployments because it is much easier to expand to multiple datacenters when required by future expansion.

    When creating a keyspace, you must define the replica placement strategy and the number of replicas you want.

-   [Snitch](archSnitchesAbout.md)

    A snitch defines groups of machines into datacenters and racks \(the topology\) that the replication strategy uses to place replicas.

    You must configure a [snitch](archSnitchesAbout.md) when you create a cluster. All snitches use a dynamic snitch layer, which monitors performance and chooses the best replica for reading. It is enabled by default and recommended for use in most deployments. Configure dynamic snitch thresholds for each node in the cassandra.yaml configuration file.

    The default [SimpleSnitch](archSnitchSimple.md) does not recognize datacenter or rack information. Use it for single-datacenter deployments or single-zone in public clouds. The [GossipingPropertyFileSnitch](archsnitchGossipPF.md) is recommended for production. It defines a node's datacenter and rack and uses [gossip](/en/glossary/doc/glossary/gloss_gossip.html) for propagating this information to other nodes.

-   [The cassandra.yaml configuration file](../configuration/configCassandra_yaml.md)

    The main configuration file for setting the initialization properties for a cluster, caching parameters for tables, properties for tuning and resource utilization, timeout settings, client connections, backups, and security.

    By default, a node is configured to store the data it manages in a directory set in the cassandra.yaml file.

    The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

        |Package installations|/etc/cassandra/cassandra.yaml|
    |Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

    In a production cluster deployment, you can change the [commitlog-directory](../configuration/configCassandra_yaml.md#commitlog_directory) to a different disk drive from the [data\_file\_directories](../configuration/configCassandra_yaml.md#data_file_directories).

-   [System keyspace table properties](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#tabProp)

    You set storage configuration attributes on a per-keyspace or per-table basis programmatically or using a client application, such as CQL.


**Parent topic:** [Understanding the architecture](../../cassandra/architecture/archTOC.md)

**Related information**  


[cassandra.yaml configuration file](../configuration/configCassandra_yaml.md)

[Install locations](../install/installLocationsTOC.md)

