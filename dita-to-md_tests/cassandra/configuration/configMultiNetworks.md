# Using multiple network interfaces {#configMultiNetworks .task}

Steps for configuring Cassandra for multiple network interfaces or when using different regions in cloud implementations.

How to configure Cassandra for multiple network interfaces or when using different regions in cloud implementations.

You must configure settings in both the cassandra.yaml file and the property file \(cassandra-rackdc.properties or cassandra-topology.properties\) used by the snitch.

## Configuring cassandra.yaml for multiple networks or across regions in cloud implementations {#cstar-yaml-settings .section}

In multiple networks or cross-region cloud scenarios, communication between datacenters can only take place using an external IP address. The external IP address is defined in the cassandra.yaml file using the broadcast\_address setting. Configure each node as follows:

1.  In the cassandra.yaml, set the [listen\_address](configCassandra_yaml.md#listen_address) to the *private* IP address of the node, and the [broadcast\_address](configCassandra_yaml.md#broadcast_address) to the *public* address of the node.

    This allows Cassandra nodes to bind to nodes in another network or region, thus enabling multiple data-center support. For intra-network or region traffic, Cassandra switches to the private IP after establishing a connection.

2.  Set the addresses of the seed nodes in the cassandra.yaml file to that of the *public* IP. Private IP are not routable between networks. For example:

    ```no-highlight
    seeds: 50.34.16.33, 60.247.70.52
    ```

    **Note:** Do not make all nodes seeds, see [Internode communications \(gossip\)](../architecture/archGossipAbout.md).

3.  Be sure that the [storage\_port](configCassandra_yaml.md#storage_port) or [ssl\_storage\_port](configCassandra_yaml.md#ssl_storage_port) is open on the public IP firewall.

CAUTION:

Be sure to enable encryption and authentication when using public IPs. See [Node-to-node encryption](secureSSLNodeToNode.md). Another option is to use a custom VPN to have local, inter-region/ datacenter IPs.

## Additional cassandra.yaml configuration for non-EC2 implementations { .section}

If multiple network interfaces are used in a non-EC2 implementation, enable the `listen_on_broadcast_address`option.

```
listen_on_broadcast_address: true
```

In non-EC2 environments, the public address to private address routing is not automatically enabled. Enabling `listen_on_broadcast_address` allows Cassandra to listen on both `listen_address` and `broadcast_address` with two network interfaces.

## Configuring the snitch for multiple networks {#snitch-config .section}

External communication between the datacenters can only happen when using the broadcast\_address \(public IP\).

The [GossipingPropertyFileSnitch](../architecture/archsnitchGossipPF.md) is recommended for production. The cassandra-rackdc.properties file defines the datacenters used by this snitch. Enable the option `prefer_local` to ensure that traffic to `broadcast_address` will re-route to `listen_address`.

For each node in the network, specify its datacenter in cassandra-rackdc.properties file.

In the example below, there are two cassandra datacenters and each datacenter is named for its workload. The datacenter naming convention in this example is based on the workload. You can use other conventions, such as DC1, DC2 or 100, 200. \(datacenter names are case-sensitive.\)

|Network A|Network B|
|---------|---------|
|Node and datacenter:-   **node0** 

dc=DC\_A\_cassandra  
 rack=RAC1

-   **node1**

dc=DC\_A\_cassandra  
 rack=RAC1

-   **node2**

dc=DC\_B\_cassandra  
 rack=RAC1

-   **node3** 

dc=DC\_B\_cassandra  
 rack=RAC1

-   **node4** 

dc=DC\_A\_analytics  
 rack=RAC1

-   **node5** 

dc=DC\_A\_search  
 rack=RAC1


|Node and datacenter:-   **node0** 

dc=DC\_A\_cassandra  
 rack=RAC1

-   **node1**

dc=DC\_A\_cassandra  
 rack=RAC1

-   **node2**

dc=DC\_B\_cassandra  
 rack=RAC1

-   **node3** 

dc=DC\_B\_cassandra  
 rack=RAC1

-   **node4** 

dc=DC\_A\_analytics  
 rack=RAC1

-   **node5** 

dc=DC\_A\_search  
 rack=RAC1


|

## Configuring the snitch for cross-region communication in cloud implementations {#cloud-implement .section}

**Note:** Be sure to use the appropriate [snitch](../architecture/archSnitchesAbout.md) for your implementation. If deploying on Amazon EC2, see the instructions in [Ec2MultiRegionSnitch](../architecture/archSnitchEC2MultiRegion.md).

In cloud deployments, the region name is treated as the datacenter name and availability zones are treated as racks within a datacenter. For example, if a node is in the us-east-1 region, us-east is the datacenter name and 1 is the rack location. \(Racks are important for distributing replicas, but not for datacenter naming.\)

In the example below, there are two cassandra datacenters and each datacenter is named for its workload. The datacenter naming convention in this example is based on the workload. You can use other conventions, such as DC1, DC2 or 100, 200. \(datacenter names are case-sensitive.\)

For each node, specify its datacenter in the cassandra-rackdc.properties. The dc\_suffix option defines the datacenters used by the snitch. Any other lines are ignored.

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

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

The location of the cassandra-rackdc.properties file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-rackdc.properties|
|Tarball installations|install\_location/conf/cassandra-rackdc.properties|

The location of the cassandra-topology.properties file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-topology.properties|
|Tarball installations|install\_location/conf/cassandra-topology.properties|

**Parent topic:** [Configuration](../../cassandra/configuration/configTOC.md)

