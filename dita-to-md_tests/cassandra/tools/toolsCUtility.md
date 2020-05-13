# The cassandra utility {#toolsCUtility .task}

You can start Cassandra 3.2 and later with special parameters by adding them to the jvm.options file \(package or tarball installations\) or by entering them at the command prompt \(in tarball installations\).

You can run Cassandra 3.2 and later with start-up parameters to by adding them to the jvm.options file \(package or tarball installations\). You can also enter parameters at the command line when starting up a tarball installation.

**Note:** If you are using Cassandra 3.1, see the [Cassandra 3.0 documentation](/en/cassandra-oss/3.0/cassandra/tools/toolsCUtility.html).

You can also add options such as maximum and minimum heap size to the jvm.options file to pass them to the Java virtual machine at startup, rather than setting them in the environment.

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

## Usage {#usage .section}

Add a parameter to the jvm.options file as follows:

```
JVM_OPTS="$JVM_OPTS -D[PARAMETER]"
```

The location of the cassandra-env.sh file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-env.sh|
|Tarball installations|install\_location/conf/cassandra-env.sh|

The location of the jvm.options file depends on the type of installation:

|Package installations|/etc/cassandra/jvm.options|
|Tarball installations|install\_location/conf/jvm.options|

When starting up a tarball installations, you can add parameters at the command line:

```screen
$ cassandra [PARAMETERS]
```

Examples:

-   Command line: $ bin/cassandra -Dcassandra.load\_ring\_state=false
-   jvm.options: JVM\_OPTS="$JVM\_OPTS -Dcassandra.load\_ring\_state=false"

The [Example section](toolsCUtility.md#example) contains more examples.

## Command line only options {#general-options .section}

|Option|Description|
|------|-----------|
| -f |Start the cassandra process in foreground. The default is to start as background process.|
| -h |Help.|
| -p filename |Log the process ID in the named file. Useful for stopping Cassandra by killing its PID.|
| -v |Print the version and exit.|

## Start-up parameters {#start-up-parameters .section}

The -D option specifies start-up parameters at the command line and in the cassandra-env.sh file.

 cassandra.auto\_bootstrap=false
 :   Sets [auto\_bootstrap](../configuration/configCassandra_yaml.md#auto_bootstrap) to `false` on initial set-up of the cluster. The next time you start the cluster, you do not need to change the cassandra.yaml file on each node to revert to `true`.

  cassandra.available\_processors=number\_of\_processors 
 :   In a multi-instance deployment, each Cassandra instance independently assumes that all CPU processors are available to it. Use this setting to specify a smaller set of processors.

  cassandra.boot\_without\_jna=true
 :   Configures Cassandra to boot without JNA. If you do not set this parameter to `true`, and JNA does not initalize, Cassandra does not boot.

  cassandra.config=directory 
 :   Sets the directory location of the cassandra.yaml file. The default location depends on the type of installation.

  cassandra.initial\_token=token 
 :   Use when Cassandra is not using virtual nodes \(vnodes\). Sets the initial partitioner token for a node the first time the node is started. \(Default: disabled\)

    **Note:** Vnodes automatically select tokens.

  cassandra.join\_ring=true\|false 
 :   When set to `false`, prevents the Cassandra node from joining a ring on startup. \(Default: `true`\) You can add the node to the ring afterwards using [nodetool join](toolsJoin.md) and a JMX call.

  cassandra.load\_ring\_state=true\|false
 :   When set to `false`, clears all gossip state for the node on restart. \(Default: true\)

  cassandra.metricsReporterConfigFile=file 
 :   Enables pluggable metrics reporter. See [Pluggable metrics reporting in Cassandra 2.0.2](https://www.datastax.com/dev/blog/pluggable-metrics-reporting-in-cassandra-2-0-2).

  cassandra.native\_transport\_port=port
 :   Sets the port on which the CQL native transport listens for clients. \(Default: 9042\)

  cassandra.partitioner=partitioner 
 :   Sets the partitioner. \(Default: org.apache.cassandra.dht.Murmur3Partitioner\)

  cassandra.replace\_address=listen\_address or broadcast\_address of dead node
 :   To replace a node that has died, restart a new node in its place specifying the [listen\_address](../configuration/configCassandra_yaml.md#listen_address) or [broadcast\_address](../configuration/configCassandra_yaml.md#broadcast_address) that the new node is assuming. The new node must be in the same state as before bootstrapping, without any data in its data directory.

    **Note:** The broadcast\_address defaults to thelisten\_address except when the ring is using the [Ec2MultiRegionSnitch](../architecture/archSnitchEC2MultiRegion.md).

  cassandra.replayList=table 
 :   Allows restoring specific tables from an archived commit log.

  cassandra.ring\_delay\_ms=ms 
 :   Defines the amount of time a node waits to hear from other nodes before formally joining the ring. \(Default: 1000ms\)

  cassandra.rpc\_port=port 
 :   Sets the port for the Thrift RPC service, which is used for client connections. \(Default: 9160\).

  cassandra.ssl\_storage\_port=port 
 :   Sets the SSL port for encrypted communication. \(Default: 7001\)

  cassandra.start\_native\_transport=true \| false 
 :   Enables or disables the native transport server. See [start\_native\_transport](../configuration/configCassandra_yaml.md#start_native_transport) in cassandra.yaml. \(Default: true\)

  cassandra.start\_rpc=true \| false
 :   Enables or disables the Thrift RPC server. \(Default: true\)

  cassandra.storage\_port=port 
 :   Sets the port for inter-node communication. \(Default: 7000\)

  cassandra.triggers\_dir=directory 
 :   Sets the default location for the triggers JARs.

    The location of the triggers directory depends on the type of installation:

        |Package installations|/var/lib/cassandra|
    |Tarball installations|install\_location/conf|

  cassandra.write\_survey=true
 :   Enables a tool sor testing new compaction and compression strategies. `write_survey` allows you to experiment with different strategies and benchmark write performance differences without affecting the production workload. See [Testing compaction and compression](../operations/opsTestCompactCompress.md).

  consistent.rangemovement=true
 :   Set to `true`, makes bootstrapping behavior effective.

  **Clearing gossip state when starting a node:** 

-   Command line: $ bin/cassandra -Dcassandra.load\_ring\_state=false
-   jvm.options: JVM\_OPTS="$JVM\_OPTS -Dcassandra.load\_ring\_state=false"

 **Starting a Cassandra node without joining the ring:**

-   Command line: bin/cassandra -Dcassandra.join\_ring=false
-   jvm.options: JVM\_OPTS="$JVM\_OPTS -Dcassandra.join\_ring=false"

 **Replacing a dead node:** 

-   Command line: bin/cassandra -Dcassandra.replace\_address=10.91.176.160
-   jvm.options: JVM\_OPTS="$JVM\_OPTS -Dcassandra.replace\_address=10.91.176.160"

**Parent topic:** [Cassandra tools](../../cassandra/tools/toolsTOC.md)

