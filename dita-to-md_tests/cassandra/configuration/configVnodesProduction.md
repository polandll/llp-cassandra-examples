# Enabling virtual nodes on an existing production cluster {#configVnodesProduction .task}

Steps and recommendations for enabling virtual nodes \(vnodes\) on an existing production cluster.

You cannot directly convert a single-token nodes to a vnode. However, you can configure another datacenter configured with vnodes already enabled and let Cassandra automatic mechanisms distribute the existing data into the new nodes. This method has the least impact on performance.

1.  [Add a new datacenter to the cluster](../operations/opsAddDCToCluster.md).

2.  Once the new datacenter with vnodes enabled is up, switch your clients to use the new datacenter.

3.  Run a full repair with [nodetool repair](../tools/toolsRepair.md).

    This step ensures that after you move the client to the new datacenter that any previous writes are added to the new datacenter and that nothing else, such as hints, is dropped when you remove the old datacenter.

4.  Update your schema to no longer reference the old datacenter.

5.  Remove the old datacenter from the cluster.

    See [Decommissioning a datacenter](../operations/opsDecomissionDC.md).


**Parent topic:** [Configuring virtual nodes](../../cassandra/configuration/configVirtualNodesTOC.md)

