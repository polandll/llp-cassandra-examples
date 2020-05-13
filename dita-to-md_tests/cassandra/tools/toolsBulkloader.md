# sstableloader \(Cassandra bulk loader\) {#toolsBulkloader .task}

Provides the ability to bulk load external data into a cluster, load existing SSTables into another cluster with a different number of nodes or replication strategy, and restore snapshots.

The Cassandra bulk loader, also called the sstableloader, provides the ability to:

-   Bulk load external data into a cluster.
-   Load existing SSTables into another cluster with a different number of nodes or replication strategy.
-   Restore snapshots.

The sstableloader streams a set of SSTable data files to a live cluster. It does not simply copy the set of SSTables to every node, but transfers the relevant part of the data to each node, conforming to the replication strategy of the cluster. The table into which the data is loaded does not need to be empty.

Run sstableloader specifying the path to the SSTables and passing it the location of the target cluster. When using the sstableloader be aware of the following:

-   Bulkloading SSTables created in versions prior to Cassandra 3.0 is supported only in Cassandra 3.0.5 and later.
-   Repairing tables that have been loaded into a different cluster does not repair the source tables.

-   The source data loaded by sstableloader must be in SSTables.
-   Because sstableloader uses the streaming protocol, it requires a direct connection over the port 7000 \(storage port\) to each connected node.

Generating SSTables

When using sstableloader to load external data, you must first put the external data into SSTables.

SSTableWriter is the API to create raw Cassandra data files locally for bulk load into your cluster. The Cassandra source code includes the CQLSSTableWriter implementation for creating SSTable files from external data without needing to understand the details of how those map to the underlying storage engine. Import the org.apache.cassandra.io.sstable.CQLSSTableWriter class, and define the schema for the data you want to import, a writer for the schema, and a prepared insert statement. For a complete example, see [https://www.datastax.com/dev/blog/using-the-cassandra-bulk-loader-updated](https://www.datastax.com/dev/blog/using-the-cassandra-bulk-loader-updated).

Restoring Cassandra snapshots

For information about preparing snapshots for sstableloader import, see [Restoring from centralized backups](../operations/opsBackupSnapshotRestore.md#central-backup).

Importing SSTables from an existing cluster

Before importing existing SSTables, run [nodetool flush](toolsFlush.md) on each source node to assure that any data in memtables is written out to the SSTables on disk.

Preparing the target environment

Before loading the data, you must define the schema of the target tables with [CQL](/en/cql-oss/3.3/cql/cqlIntro.html) or Thrift.

## Usage {#bulkloader-usage .section}

Package installations:

```no-highlight
$ sstableloader -d host\_url (,host\_url …) [options] path\_to\_keyspace
```

Tarball installations:

```no-highlight
$ cd install\_location/bin
$ sstableloader -d host\_url (,host\_url …) [options] path\_to\_keyspace
```

The sstableloader bulk loads the SSTables found in the specified directory, where the parent directories of the path are used for the target keyspace and table name, to the indicated target cluster.

Verify the location of the sstables to be streamed ends with directories named for the keyspace and table:

```screen
$ ls /var/lib/cassandra/data/Keyspace1/Standard1/
```

```
Keyspace1-Standard1-jb-60-CRC.db
Keyspace1-Standard1-jb-60-Data.db
...
Keyspace1-Standard1-jb-60-TOC.txt
```

For more sstableloader options, see [sstableloader options](toolsBulkloader.md#bulkloader-sstableloader-options)

## Using sstableloader {#bulkloader-using-sstableloader .section}

1.  If restoring snapshot data from some other source: make sure that the snapshot files are in a keyspace/tablename directory path whose names match those of the target `keyspace/tablename`. In this example, make sure the snapshot files are in /Keyspace/Standard1/.
2.  Go to the location of the SSTables:

    Package installations:

    ```no-highlight
    $ cd /var/lib/cassandra/data/Keyspace1/Standard1/
    ```

    Tarball installations:

    ```no-highlight
    $ cd install\_location/data/data/Keyspace1/Standard1/
    ```

3.  To view the contents of the keyspace:

    ```no-highlight
    $ ls
    ```

    ```no-highlight
    Keyspace1-Standard1-jb-60-CRC.db
    Keyspace1-Standard1-jb-60-Data.db
    ...
    Keyspace1-Standard1-jb-60-TOC.txt
    ```

4.  To bulk load the files, **indicate one or more nodes in the target cluster with the -d flag, which takes a comma-separated list of IP addresses or hostnames, and** specify the path to **../Keyspace1/Standard1/** in the **source machine**:

    ```
    $ sstableloader -d 110.82.155.1 /var/lib/cassandra/data/Keyspace1/Standard1/ ## package installation
    ```

    ```
    $ install_location/bin/sstableloader -d 110.82.155.1 /var/lib/cassandra/data/Keyspace1/Standard1/ ## tarball installation
    ```

    This command bulk loads all files.


**Note:** To get the best throughput from SSTable loading, you can use multiple instances of sstableloader to stream across multiple machines. No hard limit exists on the number of SSTables that sstableloader can run at the same time, so you can add additional loaders until you see no further improvement.

|Short option|Long option|Description|
|------------|-----------|-----------|
|-alg|--ssl-alg <ALGORITHM\>|Client SSL algorithm \(default: SunX509\).|
|-ap|--auth-provider <auth provider class name\>|Allows the use of a third party auth provider. Can be combined with -u <username\> and -pw <password\> if the auth provider supports plain text credentials.|
|-ciphers|--ssl-ciphers <CIPHER-SUITES\>|Client SSL. Comma-separated list of encryption suites.|
|-cph|--connections-per-host <connectionsPerHost\>|Number of concurrent connections-per-host.|
|-d|--nodes <initial\_hosts\>|**Required**. Connect to a list of \(comma separated\) hosts for initial cluster information.|
|-f|--conf-path <path\_to\_config\_file\>|Path to the cassandra.yaml path for streaming throughput and client/server SSL.|
|-h|--help|Display help.|
|-i|--ignore <NODES\>|Do not stream to this comma separated list of nodes.|
|-ks|--keystore <KEYSTORE\>|Client SSL. Full path to the keystore.|
|-kspw|--keystore-password <KEYSTORE-PASSWORD\>| Client SSL. Password for the keystore.

 Overrides the client\_encryption\_options option in [cassandra.yaml](../configuration/configCassandra_yaml.md#client_encryption_options)

|
| |--no-progress|Do not display progress.|
|-p|--port <rpc port\>|RPC port \(default: 9160 \[Thrift\]\).|
|-prtcl|--ssl-protocol <PROTOCOL\>|Client SSL. Connections protocol to use \(default: TLS\).

Overrides the server\_encryption\_options option in [cassandra.yaml](../configuration/configCassandra_yaml.md#server_encryption_options)

|
|-pw|--password <password\>|Password for Cassandra authentication.|
|-st|--store-type <STORE-TYPE\>|Client SSL. Type of store.|
|-t|--throttle <throttle\>|Throttle speed in Mbits \(default: unlimited\).

Overrides the stream\_throughput\_outbound\_megabits\_per\_sec option in [cassandra.yaml](../configuration/configCassandra_yaml.md#stream_throughput_outbound_megabits_per_sec)

|
|-tf|--transport-factory <transport factory\>|Fully-qualified ITransportFactory class name for creating a connection to Cassandra.|
|-ts|--truststore <TRUSTSTORE\>|Client SSL. Full path to truststore.|
|-tspw|--truststore-password <TRUSTSTORE-PASSWORD\>|Client SSL. Password of the truststore.|
|-u|--username <username\>|User name for Cassandra authentication.|
|-v|--verbose|Verbose output.|

The location of the [cassandra.yaml](/en/archived/cassandra/3.x/cassandra/configuration/configCassandra_yaml.html) file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra.yaml|
|Tarball installations|install\_location/resources/cassandra/conf/cassandra.yaml|

**Parent topic:** [SSTable utilities](../../cassandra/tools/toolsSSTableUtilitiesTOC.md)

