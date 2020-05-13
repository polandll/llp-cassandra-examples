# PropertyFileSnitch {#archSnitchPFSnitch .task}

Determines the location of nodes by rack and datacenter.

This snitch determines proximity as determined by rack and datacenter. It uses the network details located in the cassandra-topology.properties file. When using this snitch, you can define your datacenter names to be whatever you want. Make sure that the datacenter names correlate to the name of your datacenters in the [keyspace definition](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#refClstrOrdr__cql-compact-storage). Every node in the cluster should be described in the cassandra-topology.properties file, and this file should be exactly the same on every node in the cluster.

The location of the cassandra-topology.properties file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-topology.properties|
|Tarball installations|install\_location/conf/cassandra-topology.properties|

1.  If you had non-uniform IPs and two physical datacenters with two racks in each, and a third logical datacenter for replicating analytics data, the cassandra-topology.properties file might look like this:

    **Note:** datacenter and rack names are case-sensitive.

    ```
    # datacenter One
    
    175.56.12.105=DC1:RAC1
    175.50.13.200=DC1:RAC1
    175.54.35.197=DC1:RAC1
    
    120.53.24.101=DC1:RAC2
    120.55.16.200=DC1:RAC2
    120.57.102.103=DC1:RAC2
    
    # datacenter Two
    
    110.56.12.120=DC2:RAC1
    110.50.13.201=DC2:RAC1
    110.54.35.184=DC2:RAC1
    
    50.33.23.120=DC2:RAC2
    50.45.14.220=DC2:RAC2
    50.17.10.203=DC2:RAC2
    
    # Analytics Replication Group
    
    172.106.12.120=DC3:RAC1
    172.106.12.121=DC3:RAC1
    172.106.12.122=DC3:RAC1
    
    # default for unknown nodes 
    default =DC3:RAC1
    
    ```


**Parent topic:** [Snitches](../../cassandra/architecture/archSnitchesAbout.md)

