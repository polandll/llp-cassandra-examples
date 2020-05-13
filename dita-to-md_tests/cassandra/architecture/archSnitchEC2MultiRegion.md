# Ec2MultiRegionSnitch {#archSnitchEC2MultiRegion .concept}

Use the Ec2MultiRegionSnitch for deployments on Amazon EC2 where the cluster spans multiple regions.

Use the Ec2MultiRegionSnitch for deployments on Amazon EC2 where the cluster spans multiple regions.

You must configure settings in both the cassandra.yaml file and the property file \(cassandra-rackdc.properties\) used by the Ec2MultiRegionSnitch.

## Configuring cassandra.yaml for cross-region communication {#other-settings .section}

The Ec2MultiRegionSnitch uses public IP designated in the broadcast\_address to allow cross-region connectivity. Configure each node as follows:

1.  In the cassandra.yaml, set the [listen\_address](../configuration/configCassandra_yaml.md#listen_address) to the *private* IP address of the node, and the [broadcast\_address](../configuration/configCassandra_yaml.md#broadcast_address) to the *public* IP address of the node.

    This allows Cassandra nodes in one EC2 region to bind to nodes in another region, thus enabling multiple datacenter support. For intra-region traffic, Cassandra switches to the private IP after establishing a connection.

2.  Set the addresses of the seed nodes in the cassandra.yaml file to that of the *public* IP. Private IP are not routable between networks. For example:

    ```no-highlight
    seeds: 50.34.16.33, 60.247.70.52
    ```

    To find the public IP address, from each of the seed nodes in EC2:

    ```screen
    $ curl http://instance-data/latest/meta-data/public-ipv4
    ```

    **Note:** Do not make all nodes seeds, see [Internode communications \(gossip\)](archGossipAbout.md).

3.  Be sure that the [storage\_port](../configuration/configCassandra_yaml.md#storage_port) or [ssl\_storage\_port](../configuration/configCassandra_yaml.md#ssl_storage_port) is open on the public IP firewall.

## Configuring the snitch for cross-region communication { .section}

In EC2 deployments, the region name is treated as the datacenter name and availability zones are treated as racks within a datacenter. For example, if a node is in the us-east-1 region, us-east is the datacenter name and 1 is the rack location. \(Racks are important for distributing replicas, but not for datacenter naming.\)

For each node, specify its datacenter in the cassandra-rackdc.properties. The dc\_suffix option defines the datacenters used by the snitch. Any other lines are ignored.

In the example below, there are two cassandra datacenters and each datacenter is named for its workload. The datacenter naming convention in this example is based on the workload. You can use other conventions, such as DC1, DC2 or 100, 200. \(datacenter names are case-sensitive.\)

|Region: us-east|Region: us-west|
|---------------|---------------|
|Node and datacenter:-   **node0** 

`dc_suffix=_1_cassandra`

-   **node1**

`dc_suffix=_1_cassandra`

-   **node2**

`dc_suffix=_2_cassandra`

-   **node3** 

`dc_suffix=_2_cassandra`

-   **node4** 

`dc_suffix=_1_analytics`

-   **node5** 

`dc_suffix=_1_search`


This results in four us-east datacenters:

```no-highlight
us-east_1_cassandra
us-east_2_cassandra
us-east_1_analytics
us-east_1_search
```

|Node and datacenter:-   **node0**

`dc_suffix=_1_cassandra`

-   **node1**

`dc_suffix=_1_cassandra`

-   **node2**

`dc_suffix=_2_cassandra`

-   **node3** 

`dc_suffix=_2_cassandra`

-   **node4**

`dc_suffix=_1_analytics`

-   **node5** 

`dc_suffix=_1_search`


This results in four us-west datacenters:

```no-highlight
us-west_1_cassandra
us-west_2_cassandra
us-west_1_analytics
us-west_1_search
```

|

## Keyspace strategy options { .section}

When defining your [keyspace strategy options](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#refClstrOrdr__cql-compact-storage), use the EC2 region name, such as \`\`us-east\`\`, as your datacenter name.

The location of the cassandra-rackdc.properties file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-rackdc.properties|
|Tarball installations|install\_location/conf/cassandra-rackdc.properties|

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

**Parent topic:** [Snitches](../../cassandra/architecture/archSnitchesAbout.md)

**Related information**  


[Install locations](../install/installLocationsTOC.md)

