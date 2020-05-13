# Cluster information {#useQuerySystemTableCluster .task}

Querying system tables to get cluster topology information.

You can query system tables to get cluster topology information. Display the IP address of peer nodes, data center and rack names, token values, and other information. [*"The Data Dictionary*"](https://www.datastax.com/dev/blog/the-data-dictionary-in-cassandra-1-2) article describes querying system tables in detail.

1.  After setting up a cluster, query the peers and local tables.

    ```
    SELECT * FROM system.peers;
    ```

    Output from querying the peers table looks something like this:

    ```
       peer    | data_center | host_id     | preferred_ip | rack  | release_version | rpc_address | schema_version | tokens
    -----------+-------------+-------------+--------------+-------+-----------------+-------------+----------------+-----------
     127.0.0.3 | datacenter1 | edda8d72... |         null | rack1 |           2.1.0 | 127.0.0.3   | 59adb24e-f3... |  {3074...
     127.0.0.2 | datacenter1 | ef863afa... |         null | rack1 |           2.1.0 | 127.0.0.2   | 3d19cd8f-c9... | {-3074...}
                            
    (2 rows)
    ```


**Parent topic:** [Querying a system table](../../cql/cql_using/useQuerySystem.md)

