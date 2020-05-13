# GossipingPropertyFileSnitch {#archsnitchGossipPF .concept}

Automatically updates all nodes using gossip when adding new nodes and is recommended for production.

This snitch is recommended for production. It uses rack and datacenter information for the local node defined in the cassandra-rackdc.properties file and propagates this information to other nodes via gossip.

The configuration for the GossipingPropertyFileSnitch is contained in the cassandra-rackdc.properties file.

The location of the cassandra-rackdc.properties file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-rackdc.properties|
|Tarball installations|install\_location/conf/cassandra-rackdc.properties|

To configure a node to use GossipingPropertyFileSnitch, edit the cassandra-rackdc.properties file as follows:

-   Define the datacenter and Rack that include this node. The default settings:

    ```
    dc=DC1
    rack=RAC1
    ```

    **Note:** datacenter and rack names are case-sensitive.

-   To save bandwidth, add the `prefer_local=true` option. This option tells Cassandra to use the local IP address when communication is not across different datacenters.


**Migrating from the PropertyFileSnitch to the GossipingPropertyFileSnitch**

To allow migration from the PropertyFileSnitch, the GossipingPropertyFileSnitch uses the cassandra-topology.properties file when present. Delete the file after the migration is complete. For more information about migration, see [Switching snitches](../operations/opsSwitchSnitch.md).

**Note:** The `GossipingPropertyFileSnitch` always loads cassandra-topology.properties when that file is present. Remove the file from each node on any new cluster or any cluster migrated from the `PropertyFileSnitch`. 

**Parent topic:** [Snitches](../../cassandra/architecture/archSnitchesAbout.md)

