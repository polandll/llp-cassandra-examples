# Dynamic snitching {#archSnitchDynamic .concept}

Monitors the performance of reads from the various replicas and chooses the best replica based on this history.

By default, all snitches also use a dynamic snitch layer that monitors read latency and, when possible, routes requests away from poorly-performing nodes. The dynamic snitch is enabled by default and is recommended for use in most deployments. For information on how this works, see [Dynamic snitching in Cassandra: past, present, and future](https://www.datastax.com/blog/2012/08/dynamic-snitching-cassandra-past-present-and-future). Configure dynamic snitch thresholds for each node in the cassandra.yaml configuration file.

For more information, see the properties listed under [Failure detection and recovery](archDataDistributeFailDetect.md).

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

**Parent topic:** [Snitches](../../cassandra/architecture/archSnitchesAbout.md)

