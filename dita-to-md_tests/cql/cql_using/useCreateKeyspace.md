# Creating and updating a keyspace {#useCreateKeyspace .concept}

Creating a keyspace is the CQL counterpart to creating an SQL database.

Creating a keyspace is the CQL counterpart to creating an SQL database, but a little different. The Cassandra keyspace is a namespace that defines how data is replicated on nodes. Typically, a cluster has one keyspace per application. Replication is controlled on a per-keyspace basis, so data that has different replication requirements typically resides in different keyspaces. Keyspaces are not designed to be used as a significant map layer within the data model. Keyspaces are designed to control data replication for a set of tables.

When you create a keyspace, specify a [Table 2](../cql_reference/cqlCreateKeyspace.md#CQLreplicationMap) for replicating keyspaces. Using the `SimpleStrategy` class is fine for evaluating Cassandra. For production use or for use with mixed workloads, use the `NetworkTopologyStrategy` class.

To use `NetworkTopologyStrategy` for evaluation purposes using, for example, a single node cluster, the default data center name is used. To use `NetworkTopologyStrategy` for production use, you need to change the default snitch, `SimpleSnitch`, to a network-aware snitch, define one or more data center names in the snitch properties file, and use the data center name\(s\) to define the keyspace; see [Snitch](/en/cassandra-oss/3.0/cassandra/architecture/archSnitchesAbout.html). For example, if the cluster uses the [PropertyFileSnitch](/en/cassandra-oss/3.0/cassandra/architecture/archSnitchPFSnitch.html), create the keyspace using the user-defined data center and rack names in the cassandra-topologies.properties file. If the cluster uses the [Ec2Snitch](/en/cassandra-oss/3.0/cassandra/architecture/archSnitchEC2.html), create the keyspace using EC2 data center and rack names. If the cluster uses the [GoogleCloudSnitch](/en/cassandra-oss/3.0/cassandra/architecture/archSnitchGoogle.html), create the keyspace using GoogleCloud data center and rack names.

If you fail to change the default snitch and use `NetworkTopologyStrategy`, Cassandra will fail to complete any write request, such as inserting data into a table, and log this error message:

```
Unable to complete request: one or more nodes were unavailable.
```

**Note:** You cannot insert data into a table in keyspace that uses `NetworkTopologyStrategy` unless you define the data center names in the snitch properties file or you use a single data center named `datacenter1`.

-   **[Example of creating a keyspace](../../cql/cql_using/useExampleCreatingKeyspace.md)**  
A simple example of querying Cassandra by creating a keyspace and then using it.
-   **[Updating the replication factor](../../cql/cql_using/useUpdateKeyspaceRF.md)**  
Increasing the replication factor increases the total number of copies of keyspace data stored in a Cassandra cluster.

**Parent topic:** [Using CQL](../../cql/cql_using/useAboutCQL.md)

