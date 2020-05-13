# Changing keyspace replication strategy {#opsChangeKSStrategy .task}

Changing the strategy of a keyspace from SimpleStrategy to NetworkTopologyStrategy.

A keyspace is created with a strategy. For development work, the `SimpleStrategy` class is acceptable. For production work, the `NetworkTopologyStrategy` class must be set. To change the strategy, two steps are required. Altering the distribution of nodes within multiple datacenters when data is present should be accomplished by adding a datacenter, and then adding data to the new nodes in the new datacenter and removing nodes from the old datacenter.

-   [Change the snitch](opsSwitchSnitch.md) to a network-aware setting.

-   Alter the keyspace properties using the `ALTER KEYSPACE` command. For example, the keyspace cycling set to `SimpleStrategy` is switched to `NetworkTopologyStrategy` for a single datacenter `DC1`.

    ```
    cqlsh> ALTER KEYSPACE cycling WITH REPLICATION = {'class' : 'NetworkTopologyStrategy', 'DC1' : 3};
    ```

-   Alter the keyspace properties using the `ALTER KEYSPACE` command. For example, the keyspace cycling set to `SimpleStrategy` is switched to `NetworkTopologyStrategy`. Altering a keyspace to add a datacenter involves additional steps. Simply altering the keyspace may lead to faulty data replication. See [switching snitches](opsSwitchSnitch.md) for additional information.

    ```
    cqlsh> ALTER KEYSPACE cycling WITH REPLICATION = {'class' : 'NetworkTopologyStrategy', 'DC1' : 3, 'DC2' : 2 };
    ```

-   Run [nodetool-repair](../tools/toolsRepair.md) using the `-full` option on each node affected by the change. For details, see [Updating the replication factor](/en/cql/3.1/cql/cql_using/update_ks_rf_t.html).

    It is possible to restrict the replication of a keyspace to selected datacenters, or a single datacenter. To do this, use the NetworkTopologyStrategy and set the replication factors of the excluded datacenters to `0` \(zero\), as in the following example:

    ```
    cqlsh> ALTER KEYSPACE cycling WITH REPLICATION = {'class' : 'NetworkTopologyStrategy', 'DC1' : 0, 'DC2' : 3, 'DC3' : 0 };
    ```


**Parent topic:** [Adding or removing nodes, datacenters, or clusters](../../cassandra/operations/opsAddingRemovingNodeTOC.md)

