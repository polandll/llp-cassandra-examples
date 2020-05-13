# Configuring firewall port access {#secureFireWall .reference}

Which ports to open when nodes are protected by a firewall.

The following ports must be open to allow bi-directional communication between nodes, including certain Cassandra ports. Configure the firewall running on nodes in your Cassandra cluster accordingly. Without open ports as shown, nodes will act as a standalone database server and will not join the Cassandra cluster.

|Port number.|Description|
|------------|-----------|
|22|SSH port|

|Port number.|Description|
|------------|-----------|
|7000|Cassandra inter-node cluster communication.|
|7001|Cassandra SSL inter-node cluster communication.|
|7199|Cassandra JMX monitoring port.|

|Port number.|Description|
|------------|-----------|
|9042|Cassandra client port.|
|9160|Cassandra client port \(Thrift\).|
|9142|Default for [native\_transport\_port\_ssl](configCassandra_yaml.md#native_transport_port), useful when both encrypted and unencrypted connections are required|

**Parent topic:** [Security](../../cassandra/configuration/secureTOC.md)

