# Decommissioning a datacenter {#opsDecomissionDC .task}

Steps to properly remove a datacenter so no information is lost.

Steps to properly remove a datacenter so no information is lost.

1.  Make sure no clients are still writing to any nodes in the datacenter.

2.  Run a full repair with [nodetool repair](../tools/toolsRepair.md).

    This ensures that all data is propagated from the datacenter being decommissioned.

3.  [Change all keyspaces](/en/cql-oss/3.3/cql/cql_reference/cqlAlterKeyspace.html) so they no longer reference the datacenter being removed.

4.  Run [nodetool decommission](../tools/toolsDecommission.md) on every node in the datacenter being removed.


**Parent topic:** [Adding or removing nodes, datacenters, or clusters](../../cassandra/operations/opsAddingRemovingNodeTOC.md)

