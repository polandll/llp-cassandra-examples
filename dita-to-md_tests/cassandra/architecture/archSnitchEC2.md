# Ec2Snitch {#archSnitchEC2 .concept}

Use the Ec2Snitch with Amazon EC2 in a single region.

Use the Ec2Snitch for simple cluster deployments on Amazon EC2 where all nodes in the cluster are within a single region.

In EC2 deployments , the region name is treated as the datacenter name and availability zones are treated as racks within a datacenter. For example, if a node is in the us-east-1 region, us-east is the datacenter name and 1 is the rack location. \(Racks are important for distributing replicas, but not for datacenter naming.\) Because private IPs are used, this snitch does not work across multiple regions.

If you are using only a single datacenter, you do not need to specify any properties.

If you need multiple datacenters, set the dc\_suffix options in the cassandra-rackdc.properties file. Any other lines are ignored.

For example, for each node within the us-eastregion, specify the datacenter in its cassandra-rackdc.properties file:

**Note:** datacenter names are case-sensitive.

-   **node0**

    `dc_suffix=_1_cassandra`

-   **node1**

    `dc_suffix=_1_cassandra`

-   **node2** 

    `dc_suffix=_1_cassandra`

-   **node3**

    `dc_suffix=_1_cassandra`

-   **node4** 

    `dc_suffix=_1_analytics`

-   **node5**

    `dc_suffix=_1_search`


This results in three datacenters for the region:

```
us-east_1_cassandra
us-east_1_analytics
us-east_1_search
```

**Note:** The datacenter naming convention in this example is based on the workload. You can use other conventions, such as DC1, DC2 or 100, 200.

## Keyspace strategy options {#keyspace-strat .section}

When defining your [keyspace strategy options](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#refClstrOrdr__cql-compact-storage), use the EC2 region name, such as \`\`us-east\`\`, as your datacenter name.

The location of the cassandra-rackdc.properties file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-rackdc.properties|
|Tarball installations|install\_location/conf/cassandra-rackdc.properties|

**Parent topic:** [Snitches](../../cassandra/architecture/archSnitchesAbout.md)

