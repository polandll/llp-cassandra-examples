# Example of creating a keyspace {#useExampleCreatingKeyspace .task}

A simple example of querying Cassandra by creating a keyspace and then using it.

To query Cassandra, create and use a keyspace. Choose an arbitrary data center name and register the name in the properties file of the snitch. Alternatively, in a cluster in a single data center, use the default data center name, for example, datacenter1, and skip registering the name in the properties file.

1.  Determine the default data center name, if using NetworkTopologyStrategy, using `nodetool status`.

    ```screen
    $ bin/nodetool status
    ```

    The output is:

    ```screen
    Datacenter: datacenter1
    =======================
    Status=Up/Down
    |/ State=Normal/Leaving/Joining/Moving
    --  Address    Load       Tokens  Owns (effective)  Host ID      Rack
    UN  127.0.0.1  41.62 KB   256     100.0%            75dcca8f...  rack1
    
    ```

2.  Create a keyspace.

    ```language-cql
    cqlsh> CREATE KEYSPACE IF NOT EXISTS cycling WITH REPLICATION = { 'class' : 'NetworkTopologyStrategy', 'datacenter1' : 3 };
    ```

3.  Use the keyspace.

    ```language-cql
    cqlsh> USE cycling;
    ```


**Parent topic:** [Creating and updating a keyspace](../../cql/cql_using/useCreateKeyspace.md)

