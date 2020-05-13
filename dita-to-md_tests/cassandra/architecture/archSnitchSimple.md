# SimpleSnitch {#archSnitchSimple .concept}

The SimpleSnitch is used only for single-datacenter deployments.

The SimpleSnitch \(default\) is used only for single-datacenter deployments. It does not recognize datacenter or rack information and can be used only for single-datacenter deployments or single-zone in public clouds. It treats strategy order as proximity, which can improve cache locality when disabling read repair.

Using a SimpleSnitch, you [define the keyspace](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#refClstrOrdr__cql-compact-storage) to use SimpleStrategy and specify a replication factor.

**Parent topic:** [Snitches](../../cassandra/architecture/archSnitchesAbout.md)

