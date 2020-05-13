# Internode communications \(gossip\) {#archGossipAbout .concept}

Cassandra uses a protocol called gossip to discover location and state information about the other nodes participating in a Cassandra cluster.

Gossip is a peer-to-peer communication protocol in which nodes periodically exchange state information about themselves and about other nodes they know about. The gossip process runs every second and exchanges state messages with up to three other nodes in the cluster. The nodes exchange information about themselves and about the other nodes that they have gossiped about, so all nodes quickly learn about all other nodes in the cluster. A gossip message has a version associated with it, so that during a gossip exchange, older information is overwritten with the most current state for a particular node.

To prevent problems in gossip communications, use the same list of seed nodes for all nodes in a cluster. This is most critical the first time a node starts up. By default, a node remembers other nodes it has gossiped with between subsequent restarts. The seed node designation has no purpose other than bootstrapping the gossip process for new nodes joining the cluster. Seed nodes are *not* a single point of failure, nor do they have any other special purpose in cluster operations beyond the bootstrapping of nodes.

**Attention:** In multiple data-center clusters, include at least one node from each datacenter \(replication group\) in the seed list. Designating more than a single seed node per datacenter is recommended for fault tolerance. Otherwise, gossip has to communicate with another datacenter when bootstrapping a node.

Making every node a seed node is **not** recommended because of increased maintenance and reduced gossip performance. Gossip optimization is not critical, but it is recommended to use a small seed list \(approximately three nodes per datacenter\).

-   **[Failure detection and recovery](../../cassandra/architecture/archDataDistributeFailDetect.md)**  
A method for locally determining from gossip state and history if another node in the system is down or has come back up.

**Parent topic:** [Understanding the architecture](../../cassandra/architecture/archTOC.md)

