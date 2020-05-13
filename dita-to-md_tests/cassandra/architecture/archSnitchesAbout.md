# Snitches {#archSnitchesAbout .concept}

A snitch determines which datacenters and racks nodes belong to.

A snitch determines which datacenters and racks nodes belong to. They inform Cassandra about the network topology so that requests are routed efficiently and allows Cassandra to distribute replicas by grouping machines into datacenters and racks. Specifically, the replication strategy places the replicas based on the information provided by the new snitch. All nodes must return to the same rack and datacenter. Cassandra does its best not to have more than one replica on the same rack \(which is not necessarily a physical location\).

**Note:** If you change snitches, you may need to perform additional steps because the snitch affects where replicas are placed. See [Switching snitches](../operations/opsSwitchSnitch.md).

-   **[Dynamic snitching](../../cassandra/architecture/archSnitchDynamic.md)**  
Monitors the performance of reads from the various replicas and chooses the best replica based on this history.
-   **[SimpleSnitch](../../cassandra/architecture/archSnitchSimple.md)**  
The SimpleSnitch is used only for single-datacenter deployments.
-   **[RackInferringSnitch](../../cassandra/architecture/archSnitchRackInf.md)**  
Determines the location of nodes by rack and datacenter corresponding to the IP addresses.
-   **[PropertyFileSnitch](../../cassandra/architecture/archSnitchPFSnitch.md)**  
Determines the location of nodes by rack and datacenter.
-   **[GossipingPropertyFileSnitch](../../cassandra/architecture/archsnitchGossipPF.md)**  
Automatically updates all nodes using gossip when adding new nodes and is recommended for production.
-   **[Ec2Snitch](../../cassandra/architecture/archSnitchEC2.md)**  
Use the Ec2Snitch with Amazon EC2 in a single region.
-   **[Ec2MultiRegionSnitch](../../cassandra/architecture/archSnitchEC2MultiRegion.md)**  
Use the Ec2MultiRegionSnitch for deployments on Amazon EC2 where the cluster spans multiple regions.
-   **[GoogleCloudSnitch](../../cassandra/architecture/archSnitchGoogle.md)**  
Use the GoogleCloudSnitch for Cassandra deployments on Google Cloud Platform across one or more regions.
-   **[CloudstackSnitch](../../cassandra/architecture/archSnitchCloudStack.md)**  
Use the CloudstackSnitch for Apache Cloudstack environments.

**Parent topic:** [Understanding the architecture](../../cassandra/architecture/archTOC.md)

