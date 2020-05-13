# Updating the replication factor {#useUpdateKeyspaceRF .task}

Increasing the replication factor increases the total number of copies of keyspace data stored in a Cassandra cluster.

Increasing the replication factor increases the total number of copies of keyspace data stored in a Cassandra cluster. For more information about replication, see [Data replication](/en/cassandra-oss/3.0/cassandra/architecture/archDataDistributeReplication.html).

When you change the replication factor of a keyspace, you affect each node that the keyspaces replicates to \(or no longer replicates to\). Follow this procedure to prepare all affected nodes for this change.

1.  Update a keyspace in the cluster and change its replication strategy options.

    ```language-cql
    cqlsh> ALTER KEYSPACE system_auth WITH REPLICATION =
      {'class' : 'NetworkTopologyStrategy', 'dc1' : 3, 'dc2' : 2};
    ```

    Or if using SimpleStrategy:

    ```language-cql
    cqlsh> ALTER KEYSPACE "Excalibur" WITH REPLICATION =
      { 'class' : 'SimpleStrategy', 'replication_factor' : 3 };
    ```

2.  On each affected node, run `nodetool repair` with the `-full` option.

3.  Wait until repair completes on a node, then move to the next node.

    For more about replication strategy options, see [Changing keyspace replication strategy](/en/cassandra-oss/3.x/cassandra/operations/opsChangeKSStrategy.html)


Changing the replication factor of the system\_auth keyspace

If you are using security features, it is particularly important to increase the replication factor of the system\_auth keyspace from the default \(1\) because you will not be able to log into the cluster if the node with the lone replica goes down. It is recommended to set the replication factor for the system\_auth keyspace equal to the number of nodes in each data center.

Restricting replication for a keyspace

The example above shows how to configure a keyspace to create different numbers of replicas on different data centers. In some cases, you may want to prevent the keyspace from sending replicas to particular data centers — or restrict a keyspace to just one data center.

To do this, use ALTER KEYSPACE to configure the keyspace to use NetworkTopologyStrategy, as shown above. You can prevent the keyspace from sending replicas to a specific datacenter by setting its replication factor to `0` \(zero\). For example:

```language-cql
cqlsh> ALTER KEYSPACE keyspace1 WITH REPLICATION =
  {'class' : 'NetworkTopologyStrategy', 'dc1' : 0, 'dc2' : 3, 'dc3' : 0 };
```

This command configures `keyspace1` to create replicas only on `dc2`. The data centers `dc1` and `dc3` receive no replicas from tables in `keyspace1`.

**Parent topic:** [Creating and updating a keyspace](../../cql/cql_using/useCreateKeyspace.md)

