# GoogleCloudSnitch {#archSnitchGoogle .concept}

Use the GoogleCloudSnitch for Cassandra deployments on Google Cloud Platform across one or more regions.

Use the GoogleCloudSnitch for Cassandra deployments on [Google Cloud Platform](https://cloud.google.com/) across one or more regions. The region is treated as a datacenter and the availability zones are treated as racks within the datacenter. All communication occurs over private IP addresses within the same logical network.

The region name is treated as the datacenter name and zones are treated as racks within a datacenter. For example, if a node is in the us-central1-a region, us-central1 is the datacenter name and a is the rack location. \(Racks are important for distributing replicas, but not for datacenter naming.\) This snitch can work across multiple regions without additional configuration.

If you are using only a single datacenter, you do not need to specify any properties.

If you need multiple datacenters, set the dc\_suffix options in the cassandra-rackdc.properties file. Any other lines are ignored.

For example, for each node within the us-central1 region, specify the datacenter in its cassandra-rackdc.properties file:

**Note:** datacenter names are case-sensitive.

-   **node0**

    `dc_suffix=_a_cassandra`

-   **node1**

    `dc_suffix=_a_cassandra`

-   **node2** 

    `dc_suffix=_a_cassandra`

-   **node3**

    `dc_suffix=_a_cassandra`

-   **node4** 

    `dc_suffix=_a_analytics`

-   **node5**

    `dc_suffix=_a_search`


The location of the cassandra-rackdc.properties file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-rackdc.properties|
|Tarball installations|install\_location/conf/cassandra-rackdc.properties|

**Note:** datacenter and rack names are case-sensitive.

**Parent topic:** [Snitches](../../cassandra/architecture/archSnitchesAbout.md)

