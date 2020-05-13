# The cassandra.yaml configuration file {#configCassandra_yaml .reference}

The cassandra.yaml file is the main configuration file for Cassandra.

The cassandra.yaml file is the main configuration file for Cassandra.

**Important:** After changing properties in the cassandra.yaml file, you must restart the node for the changes to take effect. It is located in the following directories:

-   Cassandra package installations: /etc/cassandra
-   Cassandra tarball installations: install\_location/conf

The configuration properties are grouped into the following sections:

-   [Quick start](configCassandra_yaml.md#QuickStartProps)

    The minimal properties needed for configuring a cluster.

-   [Commonly used](configCassandra_yaml.md#commonProps)

    Properties most frequently used when configuring Cassandra.

-   [Performance tuning](configCassandra_yaml.md#PerformanceTuningProps)

     Tuning performance and system resource utilization, including commit log, compaction, memory, disk I/O, CPU, reads, and writes.

-   [Advanced](configCassandra_yaml.md#advProps)

    Properties for advanced users or properties that are less commonly used.

-   [Security](configCassandra_yaml.md#SecurityProps)

    Server and client security settings.


**Note:** Values with *note* mark default values that are defined internally, missing, or commented out, or whose implementation depends on other properties in the cassandra.yaml file. Additionally, some commented-out values may not match the actual default values. These are recommended alternatives to the default values.

## Quick start properties {#QuickStartProps .section}

The minimal properties needed for configuring a cluster.

Related information: [Initializing a multiple node cluster \(single datacenter\)](../initialize/initSingleDS.md) and [Initializing a multiple node cluster \(multiple datacenters\)](../initialize/initMultipleDS.md).

 cluster\_name
 :   \(Default: Test Cluster\) The name of the cluster. This setting prevents nodes in one logical cluster from joining another. All nodes in a cluster must have the same value.

  listen\_address
 :   \(Default: localhost\) The IP address or hostname that Cassandra binds to for connecting this node to other nodes. Set this parameter or [listen\_interface](configCassandra_yaml.md#listen_interface), not both. Correct settings for various use cases:

    -   **Single-node installations**: do one of the following:
        -   Comment this property out. If the node is properly configured \(host name, name resolution, and so on.\), Cassandra uses InetAddress.getLocalHost\(\) to get the local address from the system.
        -   Leave set to the default, `localhost`.
    -   **Node in a multi-node installations**: set this property to the node's IP address or hostname, or set [listen\_interface](configCassandra_yaml.md#listen_interface).
    -   **Node in a multi-network or multi-Datacenter installation, within an EC2 environment that supports automatic switching between public and private interfaces**: set `listen_address` to the node's IP address or hostname, or set [listen\_interface](configCassandra_yaml.md#listen_interface).
    -   **Node with two physical network interfaces in a multi-datacenter installation or a Cassandra cluster deployed across multiple Amazon EC2 regions using the Ec2MultiRegionSnitch**:
        1.  Set `listen_address` to this node's private IP or hostname, or set [listen\_interface](configCassandra_yaml.md#listen_interface) \(for communication within the local datacenter\).
        2.  Set [broadcast\_address](configCassandra_yaml.md#broadcast_address) to the second IP or hostname \(for communication between datacenters\).
        3.  Set [listen\_on\_broadcast\_address](configCassandra_yaml.md#listen_on_broadcast_address) to `true`.
        4.  If this node is a seed node, add the node's *public* IP address or hostname to the [seeds](configCassandra_yaml.md#seed_provider) list.
    -   Open the [storage\_port](configCassandra_yaml.md#storage_port) or [ssl\_storage\_port](configCassandra_yaml.md#ssl_storage_port) on the public IP firewall.

    **Warning:** 

    -   Never set `listen_address` to 0.0.0.0. It is always wrong.

    -   Do not set values for both [listen\_address](configCassandra_yaml.md#listen_address) and `listen_interface` on the same node.


  listen\_interface
 :   \(Default: eth0\)[note](configCassandra_yaml.md#asterisks) The interface that Cassandra binds to for connecting to other Cassandra nodes. Interfaces must correspond to a single address — IP aliasing is not supported. Do not set values for both [listen\_address](configCassandra_yaml.md#listen_address) and `listen_interface` on the same node.

  listen\_interface\_prefer\_ipv6
 :   \(Default: false\) If an interface has an ipv4 and an ipv6 address, Cassandra uses the first ipv4 address by default. Set this property to true to configure Cassandra to use the first ipv6 address.

 *Default directories*

If you have changed any of the default directories during installation, set these properties to the new locations. Make sure you have root access.

 cdc\_raw\_directory
 :   The directory where the CDC log is stored. Default locations:

    -   Package installations: /var/lib/cassandra/cdc\_raw
    -   Tarball installations: install\_location/data/cdc\_raw

    The directory where Change Data Capture logs are stored.

  commitlog\_directory
 :   The directory where the commit log is stored. Default locations:

    -   Package installations: /var/lib/cassandra/commitlog
    -   Tarball installations: install\_location/data/commitlog

    For optimal write performance, place the commit log be on a separate disk partition, or \(ideally\) a separate physical device from the data file directories. Because the commit log is append only, an HDD is acceptable for this purpose.

  data\_file\_directories
 :   The directory location where table data is stored \(in SSTables\). Cassandra distributes data evenly across the location, subject to the granularity of the configured compaction strategy. Default locations:

    -   Package installations: /var/lib/cassandra/data
    -   Tarball installations: install\_location/data/data

    As a production best practice, use [RAID 0 and SSDs](/en/landing_page/doc/landing_page/planning/planningHardware.html).

  saved\_caches\_directory
 :   The directory location where table key and row caches are stored. Default location:

    -   Package installations: /var/lib/cassandra/saved\_caches
    -   Tarball installations: install\_location/data/saved\_caches

 ## Commonly used properties {#commonProps .section}

Properties most frequently used when configuring Cassandra.

Before starting a node for the first time, you should carefully evaluate your requirements.

*Common initialization properties*

**Note:** Be sure to set the properties in the [Quick start section](configCassandra_yaml.md#QuickStartProps) as well.

 commit\_failure\_policy
 :   \(Default: `stop`\) Policy for commit disk failures:

    -   die

        Shut down gossip and Thrift and kill the JVM, so the node can be replaced.

    -   stop

        Shut down gossip and Thrift, leaving the node effectively dead, available for inspection using JMX.

    -   stop\_commit

        Shut down the commit log, letting writes collect but continuing to service reads \(as in pre-2.0.5 Cassandra\).

    -   ignore

        Ignore fatal errors and let the batches fail.


  disk\_optimization\_strategy
 :   \(Default: ssd\) The strategy for optimizing disk reads. Possible values: ssd or spinning.

  disk\_failure\_policy
 :   \(Default: stop\) Sets how Cassandra responds to disk failure. Recommend settings: stop or best\_effort. Valid values:

    -   die

        Shut down gossip and Thrift and kill the JVM for any file system errors or single SSTable errors, so the node can be replaced.

    -   stop\_paranoid

        Shut down gossip and Thrift even for single SSTable errors.

    -   stop

        Shut down gossip and Thrift, leaving the node effectively dead, but available for inspection using JMX.

    -   best\_effort

        Stop using the failed disk and respond to requests based on the remaining available SSTables. This allows obsolete data at consistency level of ONE.

    -   ignore 

        Ignore fatal errors and lets the requests fail; all file system errors are logged but otherwise ignored. Cassandra acts as in versions prior to 1.2.


    Related information: [Handling Disk Failures In Cassandra 1.2](https://www.datastax.com/blog/2012/10/handling-disk-failures-cassandra-12) blog and [Recovering from a single disk failure using JBOD](../operations/opsRecoverUsingJBOD.md).

  endpoint\_snitch
 :   \(Default: org.apache.cassandra.locator.SimpleSnitch\) Set to a class that implements the IEndpointSnitch interface. Cassandra uses the snitch to locate nodes and route requests.

    -   **SimpleSnitch**

        Use for single-datacenter deployment or single-zone deployment in public clouds. Does not recognize datacenter or rack information. Treats strategy order as proximity, which can improve cache locality when you disable read repair.

    -   **GossipingPropertyFileSnitch** 

        Recommended for production. Reads rack and datacenter for the local node in cassandra-rackdc.properties file and propagates these values to other nodes via gossip. For migration from the PropertyFileSnitch, uses the cassandra-topology.properties file if it is present.

        The location of the cassandra-rackdc.properties file depends on the type of installation:

                |Package installations|/etc/cassandra/cassandra-rackdc.properties|
        |Tarball installations|install\_location/conf/cassandra-rackdc.properties|

        The location of the cassandra-topology.properties file depends on the type of installation:

                |Package installations|/etc/cassandra/cassandra-topology.properties|
        |Tarball installations|install\_location/conf/cassandra-topology.properties|

    -   **PropertyFileSnitch**

        Determines proximity by rack and datacenter, which are explicitly configured in cassandra-topology.properties file.

    -   **Ec2Snitch**

        For EC2 deployments in a single region. Loads region and availability zone information from the Amazon EC2 API. The region is treated as the datacenter and the availability zone as the rack and uses only private IP addresses. For this reason, it does not work across multiple regions.

    -   **Ec2MultiRegionSnitch**

        Uses the public IP as the [broadcast\_address](configCassandra_yaml.md#broadcast_address) to allow cross-region connectivity. This means you must also set [seed](configCassandra_yaml.md#seed_provider) addresses to the public IP and open the [storage\_port](configCassandra_yaml.md#storage_port) or [ssl\_storage\_port](configCassandra_yaml.md#ssl_storage_port) on the public IP firewall. For intra-region traffic, Cassandra switches to the private IP after establishing a connection.

    -   **RackInferringSnitch**:

        Proximity is determined by rack and datacenter, which are assumed to correspond to the 3rd and 2nd octet of each node's IP address, respectively. Best used as an example for writing a custom snitch class \(unless this happens to match your deployment conventions\).

    -   **GoogleCloudSnitch**:

        Use for Cassandra deployments on [Google Cloud Platform](https://cloud.google.com/) across one or more regions. The region is treated as a datacenter and the availability zones are treated as racks within the datacenter. All communication occurs over private IP addresses within the same logical network.

    -   **CloudstackSnitch**

        Use the CloudstackSnitch for [Apache Cloudstack](http://cloudstack.apache.org/) environments.


    Related information: [Snitches](../architecture/archSnitchesAbout.md)

  rpc\_address
 :   \(Default: localhost\) The listen address for client connections \(Thrift RPC service and native transport\). Valid values:

    -   unset:

        Resolves the address using the configured hostname configuration of the node. If left unset, the hostname resolves to the IP address of this node using /etc/hostname, /etc/hosts, or DNS.

    -    0.0.0.0:

        Listens on all configured interfaces. You must set the [broadcast\_rpc\_address](configCassandra_yaml.md#broadcast_rpc_address) to a value other than 0.0.0.0.

    -    IP address
    -   hostname

    Related information: [Network](/en/landing_page/doc/landing_page/planning/planningHardware.html#planPlanningHardware__network)

  rpc\_interface
 :   \(Default: eth1\)[note](configCassandra_yaml.md#asterisks) The listen address for client connections. Interface must correspond to a single address, IP aliasing is not supported. See [rpc\_address](configCassandra_yaml.md#rpc_address).

  rpc\_interface\_prefer\_ipv6
 :   \(Default: false\) If an interface has an ipv4 and an ipv6 address, Cassandra uses the first ipv4 address by default, i. If set to true, the first ipv6 address will be used.

  seed\_provider
 :   The addresses of hosts designated as contact points in the cluster. A joining node contacts one of the nodes in the -seeds list to learn the topology of the ring.

    -   class\_name \(Default: org.apache.cassandra.locator.SimpleSeedProvider\)

        The class within Cassandra that handles the seed logic. It can be customized, but this is typically not required.

    -   - seeds \(Default: 127.0.0.1\)

        A comma-delimited list of IP addresses used by [gossip](../architecture/archGossipAbout.md) for bootstrapping new nodes joining a cluster. If your cluster includes multiple nodes, you must change the list from the default value to the IP address of one of the nodes.

        **Attention:** In multiple data-center clusters, include at least one node from each datacenter \(replication group\) in the seed list. Designating more than a single seed node per datacenter is recommended for fault tolerance. Otherwise, gossip has to communicate with another datacenter when bootstrapping a node.

        Making every node a seed node is **not** recommended because of increased maintenance and reduced gossip performance. Gossip optimization is not critical, but it is recommended to use a small seed list \(approximately three nodes per datacenter\).


    Related information: [Initializing a multiple node cluster \(single datacenter\)](../initialize/initSingleDS.md) and [Initializing a multiple node cluster \(multiple datacenters\)](../initialize/initMultipleDS.md).

  enable\_user\_defined\_functions
 :   \(Default: false\) User defined functions \(UDFs\) present a security risk, since they are executed on the server side. In Cassandra 3.0 and later, UDFs are executed in a sandbox to contain the execution of malicious code. They are disabled by default.

  enable\_scripted\_user\_defined\_functions
 :   \(Default: false\) ﻿ Java UDFs are always enabled, if `enable_user_defined_functions` is true. Enable this option to use UDFs with `language javascript` or any custom JSR-223 provider. This option has no effect if `enable_user_defined_functions` is false.

 *Common compaction settings*

 compaction\_throughput\_mb\_per\_sec
 :   \(Default: 16\) Throttles compaction to the specified Mb/second across the instance. The faster Cassandra inserts data, the faster the system must compact in order to keep the SSTable count down. The recommended value is 16 to 32 times the rate of write throughput \(in Mb/second\). Setting the value to 0 disables compaction throttling.

    Related information: [Configuring compaction](../operations/opsConfigureCompaction.md)

  compaction\_large\_partition\_warning\_threshold\_mb
 :   \(Default: 100\) Cassandra logs a warning when compacting partitions larger than the set value.

 *Common memtable settings*

 memtable\_heap\_space\_in\_mb
 :   \(Default: 1/4 of heap size\)[note](configCassandra_yaml.md#asterisks)

 :   The amount of on-heap memory allocated for memtables. Cassandra uses the total of this amount and the value of memtable\_offheap\_space\_in\_mb to set a threshold for automatic memtable flush. For details, see [memtable\_cleanup\_threshold](configCassandra_yaml.md#memtable_cleanup_threshold).

    Related information: [Tuning the Java heap](../operations/opsTuneJVM.md#tuning-the-java-heap) 

  memtable\_offheap\_space\_in\_mb
 :   \(Default: 1/4 of heap size\)[note](configCassandra_yaml.md#asterisks)

 :   Sets the total amount of off-heap memory allocated for memtables. Cassandra uses the total of this amount and the value of memtable\_heap\_space\_in\_mb to set a threshold for automatic memtable flush. For details, see [memtable\_cleanup\_threshold](configCassandra_yaml.md#memtable_cleanup_threshold).

    Related information: [Tuning the Java heap](../operations/opsTuneJVM.md#tuning-the-java-heap)

 *Common disk settings*

 concurrent\_reads
 :   \(Default: 32\)[note](configCassandra_yaml.md#asterisks) Workloads with more data than can fit in memory encounter a bottleneck in fetching data from disk during reads. Setting `concurrent_reads` to \(16 × number\_of\_drives\) allows operations to queue low enough in the stack so that the OS and drives can reorder them. The default setting applies to both logical volume managed \(LVM\) and RAID drives.

  concurrent\_writes
 :   \(Default: 32\)[note](configCassandra_yaml.md#asterisks) Writes in Cassandra are rarely I/O bound, so the ideal number of concurrent writes depends on the number of CPU cores on the node. The recommended value is 8 × number\_of\_cpu\_cores.

  concurrent\_counter\_writes
 :   \(Default: 32\)[note](configCassandra_yaml.md#asterisks) Counter writes read the current values before incrementing and writing them back. The recommended value is \(16 × number\_of\_drives\) .

  concurrent\_batchlog\_writes
 :   \(Default: 32\) Limit on the number of concurrent batchlog writes, similar to `concurrent_writes`.

  concurrent\_materialized\_view\_writes
 :   \(Default: 32\) Limit on the number of concurrent materialized view writes. Set this to the lesser of concurrent reads or concurrent writes, because there is a read involved in each materialized view write.

 *Common automatic backup settings*

 incremental\_backups
 :   \(Default: false\) Backs up data updated since the last snapshot was taken. When enabled, Cassandra creates a hard link to each SSTable flushed or streamed locally in a backups subdirectory of the keyspace data. Removing these links is the operator's responsibility.

    Related information: [Enabling incremental backups](../operations/opsBackupIncremental.md)

  snapshot\_before\_compaction
 :   \(Default: false\) Enables or disables taking a snapshot before each compaction. A snapshot is useful to back up data when there is a data format change. Be careful using this option: Cassandra does not clean up older snapshots automatically.

    Related information: [Configuring compaction](../operations/opsConfigureCompaction.md)

 *Common fault detection settin*g

 phi\_convict\_threshold
 :   \(Default: 8\)[note](configCassandra_yaml.md#asterisks) Adjusts the sensitivity of the failure detector on an exponential scale. Generally this setting does not need adjusting.

    Related information: [Failure detection and recovery](../architecture/archDataDistributeFailDetect.md)

 ## Performance tuning properties {#PerformanceTuningProps .section}

Tuning performance and system resource utilization, including commit log, compaction, memory, disk I/O, CPU, reads, and writes.

*Commit log settings*

 commitlog\_sync
 :   \(Default: periodic\) The method that Cassandra uses to acknowledge writes in milliseconds:

    -    periodic: \(Default: 10000 milliseconds \[10 seconds\]\)

        With commitlog\_sync\_period\_in\_ms, controls how often the commit log is synchronized to disk. Periodic syncs are acknowledged immediately.

    -   batch: \(Default: disabled\)[note](configCassandra_yaml.md#asterisks)

        With commitlog\_sync\_batch\_window\_in\_ms \(Default: 2 ms\), controls how long Cassandra waits for other writes before performing a sync. When this method is enabled, Cassandra does not acknowledge writes until they are fsynced to disk.


  commitlog\_segment\_size\_in\_mb
 :   \(Default: 32MB\) The size of an individual commitlog file segment. A commitlog segment may be archived, deleted, or recycled after all its data has been flushed to SSTables. This data can potentially include commitlog segments from every table in the system. The default size is usually suitable for most commitlog archiving, but if you want a finer granularity, 8 or 16 MB is reasonable.

    By default, the [max\_mutation\_size\_in\_kb](configCassandra_yaml.md#max_mutation_size_in_kb) is set to half of the `commitlog_segment_size_in_kb`.

    Related information: [Commit log archive configuration](configLogArchive.md)

  max\_mutation\_size\_in\_kb
 :   \(Default: ½ of [commitlog\_segment\_size\_in\_mb](configCassandra_yaml.md#commitlog_segment_size_in_mb).

    If a mutation's size exceeds this value, the mutation is rejected. Before increasing the commitlog segment size of the commitlog segments, investigate why the mutations are larger than expected. Look for underlying issues with access patterns and data model, because increasing the commitlog segment size is a limited fix.

    **Restriction:** 

    If you set `max_mutation_size_in_kb` explicitly, then you must set `commitlog_segment_size_in_mb` to at least twice the size of max\_mutation\_size\_in\_kb / 1024.

    For more information, see [commitlog\_segment\_size\_in\_mb](configCassandra_yaml.md#commitlog_segment_size_in_mb) above.

  commitlog\_compression
 :   \(Default: not enabled\) The compressor to use if commit log is compressed. Valid values: `LZ4`, `Snappy` or `Deflate`. If no value is set for this property, the commit log is written uncompressed.

  cdc\_total\_space\_in\_mb
 :   \(Default: 4096MB and 1/8thof the total space of the drive where the `cdc_raw_directory` resides.\)[note](configCassandra_yaml.md#asterisks) If space gets above this value, Cassandra will throw `WriteTimeoutException` on Mutations including tables with CDC enabled. A CDCCompactor \(a consumer\) is responsible for parsing the raw CDC logs and deleting them when parsing is completed.

  cdc\_free\_space\_check\_interval\_ms
 :   \(Default: 250 ms\)note When the `cdc_raw` limit is hit and the CDCCompactor is either running behind or experiencing backpressure, this interval is checked to see if any new space for cdc-tracked tables has been made available.

  commitlog\_total\_space\_in\_mb
 :   \(Default: 32MB for 32-bit JVMs, 8192MB for 64-bit JVMs\)[note](configCassandra_yaml.md#asterisks) Total space used for commit logs. If the total space used by all commit logs goes above this value, Cassandra rounds up to the next nearest segment multiple and flushes memtables to disk for the oldest commitlog segments, removing those log segments from the commit log. This reduces the amount of data to replay on start-up, and prevents infrequently-updated tables from keeping commitlog segments indefinitely. If the `commitlog_total_space_in_mb` is small, the result is more flush activity on less-active tables.

    Related information: [Configuring memtable thresholds](../operations/opsMemtableThruput.md)

 *Compaction settings*

Related information: [Configuring compaction](../operations/opsConfigureCompaction.md)

 concurrent\_compactors
 :   \(Default: Smaller of number of disks or number of cores, with a minimum of 2 and a maximum of 8 per CPU core\)[note](configCassandra_yaml.md#asterisks)The number of concurrent compaction processes allowed to run simultaneously on a node, not including validation [compactions](/en/glossary/doc/glossary/gloss_compaction.html) for[anti-entropy](/en/glossary/doc/glossary/gloss_anti_entropy.html) repair. Simultaneous compactions help preserve read performance in a mixed read-write workload by limiting the number of small SSTables that accumulate during a single long-running compaction. If your data directories are backed by [SSDs](/en/glossary/doc/glossary/gloss_ssd.html), increase this value to the number of cores. If compaction running too slowly or too fast, adjust [compaction\_throughput\_mb\_per\_sec](configCassandra_yaml.md#compaction_throughput_mb_per_sec) first.

    **Note:** Increasing concurrent compactors leads to more use of available disk space for compaction, because concurrent compactions happen in parallel, especially for STCS. Ensure that adequate disk space is available before increasing this configuration.

  sstable\_preemptive\_open\_interval\_in\_mb
 :   \(Default: 50MB\) The compaction process opens SSTables before they are completely written and uses them in place of the prior SSTables for any range previously written. This setting helps to smoothly transfer reads between the SSTables by reducing page cache churn and keeps hot rows hot.

 *Memtable settings*

 memtable\_allocation\_type
 :   \(Default: heap\_buffers\) The method Cassandra uses to allocate and manage memtable memory. See [Off-heap memtables in Cassandra 2.1](https://www.datastax.com/blog/2014/07/heap-memtables-cassandra-21). In releases 3.2.0 and 3.2.1, the only option that works is: heap-buffers \(On heap NIO \(non-blocking I/O\) buffers\).

  memtable\_cleanup\_threshold
 :   \(Default: 1/\([memtable\_flush\_writers](configCassandra_yaml.md#memtable_flush_writers) + 1\)\)[note](configCassandra_yaml.md#asterisks). Ratio used for automatic memtable flush. Cassandra adds [memtable\_heap\_space\_in\_mb](configCassandra_yaml.md#memtable_heap_space_in_mb) to [memtable\_offheap\_space\_in\_mb](configCassandra_yaml.md#memtable_offheap_space_in_mb) and multiplies the total by memtable\_cleanup\_threshold to get a space amount in MB. When the total amount of memory used by all non-flushing memtables exceeds this amount, Cassandra flushes the largest memtable to disk.

    For example, consider a node where the total of memtable\_heap\_space\_in\_mb and memtable\_offheap\_space\_in\_mb is 1000, and memtable\_cleanup\_threshold is `0.50`. The *memtable\_cleanup* amount is `500`MB. This node has two memtables: Memtable A \(150MB\) and Memtable B \(350MB\). When either memtable increases, the total space they use exceeds 500MB and Cassandra flushes the Memtable B to disk.

    A larger value for memtable\_cleanup\_threshold means larger flushes, less frequent flushes and potentially less compaction activity, but also less concurrent flush activity, which can make it difficult to keep your disks saturated under heavy write load.

    This section documents the formula used to calculate the ratio based on the number of [memtable\_flush\_writers](configCassandra_yaml.md#memtable_flush_writers). The default value in cassandra.yaml is `0.11`, which works if the node has many disks or if you set the node's memtable\_flush\_writers to `8`. As another example, if the node uses a single SSD, the value for memttable\_cleanup\_threshold computes to `0.33`, based on the minimum memtable\_flush\_writers value of `2`.

  file\_cache\_size\_in\_mb
 :   \(Default: Smaller of 1/4 heap or 512\) Total memory to use for SSTable-reading buffers.

  buffer\_pool\_use\_heap\_if\_exhausted
 :   \(Default: true\)[note](configCassandra_yaml.md#asterisks) ﻿Indicates whether Cassandra allocates allocate on-heap or off-heap memory when the SSTable buffer pool is exhausted \(when the buffer pool has exceeded the maximum memory [file\_cache\_size\_in\_mb](configCassandra_yaml.md#file_cache_size_in_mb)\), beyond this amount, Cassandra stops caching buffers, but allocates on request.

  memtable\_flush\_writers
 :   \(Default: Smaller of number of disks or number of cores with a minimum of 2 and a maximum of 8\)[note](configCassandra_yaml.md#asterisks) The number of memtable flush writer threads. These threads are blocked by disk I/O, and each one holds a memtable in memory while blocked. If your data directories are backed by SSDs, increase this setting to the number of cores.

 *Cache and index settings*

 column\_index\_size\_in\_kb
 :   \(Default: 64\) Granularity of the index of rows within a partition. For huge rows, decrease this setting to improve seek time. If you use key cache, be careful not to make this setting too large because key cache will be overwhelmed. If you're unsure of the size of the rows, it's best to use the default setting.

  index\_summary\_capacity\_in\_mb
 :   \(Default: 5% of the heap size \[empty\]\)[note](configCassandra_yaml.md#asterisks) Fixed memory pool size in MB for SSTable index summaries. If the memory usage of all index summaries exceeds this limit, any SSTables with low read rates shrink their index summaries to meet this limit. This is a best-effort process. In extreme conditions, Cassandra may use more than this amount of memory.

  index\_summary\_resize\_interval\_in\_minutes
 :   \(Default: 60 minutes\) How frequently index summaries should be re-sampled. Re-sampling is done periodically to redistribute memory from the fixed-size pool to SSTables proportional their recent read rates. To disable, set to -1. This setting leaves existing index summaries at their current sampling level.

 *Disks settings*

 stream\_throughput\_outbound\_megabits\_per\_sec
 :   \(Default: 200 Mbps\)[note](configCassandra_yaml.md#asterisks) Throttle for the throughput of all outbound streaming file transfers on a node. Cassandra does mostly sequential I/O when streaming data during bootstrap or repair. This can saturate the network connection and degrade client \(RPC\) performance.

  inter\_dc\_stream\_throughput\_outbound\_megabits\_per\_sec
 :   \(Default: unset\)[note](configCassandra_yaml.md#asterisks) Throttle for all streaming file transfers between datacenters, and for network stream traffic as configured with [stream\_throughput\_outbound\_megabits\_per\_sec](configCassandra_yaml.md#stream_throughput_outbound_megabits_per_sec).

  trickle\_fsync
 :   \(Default: false\) When set to `true`, causes fsync to force the operating system to flush the dirty buffers at the set interval trickle\_fsync\_interval\_in\_kb. Enable this parameter to prevent sudden dirty buffer flushing from impacting read latencies. Recommended for use with SSDs, but not with HDDs.

  trickle\_fsync\_interval\_in\_kb
 :   \(Default: 10240\). The size of the fsync in kilobytes.

  windows\_timer\_interval
 :   \(Default: 1\) ﻿The default Windows kernel timer and scheduling resolution is 15.6ms for power conservation. Lowering this value on Windows can provide much tighter latency and better throughput. However, some virtualized environments may see a negative performance impact from changing this setting below the system default. The `sysinternals clockres` tool can confirm your system's default setting.

 ## Advanced properties {#advProps .section}

Properties for advanced users or properties that are less commonly used.

*Advanced initialization properties*

 auto\_bootstrap
 :   \(Default: true\) This setting has been removed from default configuration. It causes new \(non-seed\) nodes migrate the right data to themselves automatically. When initializing a fresh cluster *without* data, add auto\_bootstrap: false.

    Related information: [Initializing a multiple node cluster \(single datacenter\)](../initialize/initSingleDS.md) and [Initializing a multiple node cluster \(multiple datacenters\)](../initialize/initMultipleDS.md).

  batch\_size\_warn\_threshold\_in\_kb
 :   \(Default: 5KB per batch\) Causes Cassandra to log a WARN message when any batch size exceeds this value in kilobytes.

    CAUTION:

    Increasing this threshold can lead to node instability.

  batch\_size\_fail\_threshold\_in\_kb
 :   \(Default: 50KB per batch\) Cassandra fails any batch whose size exceeds this setting. The default value is 10X the value of `batch_size_warn_threshold_in_kb`.

  unlogged\_batch\_across\_partitions\_warn\_threshold
 :   \(Default: 10partitions per batch\) Causes Cassandra to log a WARN message on any batches not of type LOGGED that span across more partitions than this limit. The default value is 10 partitions.

  cdc\_enabled
 :   \(Default: commented out\) Enable / disable CDC functionality on a per-node basis. This modifies the logic used for write path allocation rejection \(standard: never reject. cdc: reject Mutation containing a CDC-enabled table if at space limit in cdc\_raw\_directory\).

    **Important:** Do not enable CDC on a mixed-version cluster. Upgrade all nodes to Cassandra 3.8 before enabling and restarting the cluster.

  broadcast\_address
 :   \(Default: listen\_address\)[note](configCassandra_yaml.md#asterisks) The "public" IP address this node uses to broadcast to other nodes outside the network or across regions in multiple-region EC2 deployments. If this property is commented out, the node uses the same IP address or hostname as `listen_address`. A node does not need a separate `broadcast_address` in a single-node or single-datacenter installation, or in an EC2-based network that supports automatic switching between private and public communication. It is necessary to set a separate `listen_address` and `broadcast_address` on a node with multiple physical network interfaces or other topologies where not all nodes have access to other nodes by their private IP addresses. For specific configurations, see the instructions for [listen\_address](configCassandra_yaml.md#listen_address).

  listen\_on\_broadcast\_address
 :   \(Default: false\) If this node uses multiple physical network interfaces, set a unique IP address for [broadcast\_address](configCassandra_yaml.md#broadcast_address) and set `listen_on_broadcast_address` to true. This enables the node to communicate on both interfaces.

    Set this property to false if the node is on a network that automatically routes between public and private networks, as Amazon EC2 does.

    For configuration details, see the instructions for [listen\_address](configCassandra_yaml.md#listen_address).

  initial\_token
 :   \(Default: disabled\) Set this property for single-node-per-token architecture, in which a node owns exactly one contiguous range in the ring space. Setting this property overrides [num\_tokens](configCassandra_yaml.md#num_tokens).

 :   If your Cassandra installation is not using vnodes or this node's [num\_tokens](configCassandra_yaml.md#num_tokens) is set it to 1 or is commented out, you should always set an `initial_token` value when setting up a production cluster for the first time, and when adding capacity. For more information, see this parameter in the [Cassandra 1.1 Node and Cluster Configuration](/en/archived/cassandra/1.1/docs/configuration/node_configuration.html#initial-token) documentation.

 :   This parameter can be used with num\_tokens \(vnodes \) in special cases such as [Restoring from a snapshot](../operations/opsBackupSnapshotRestore.md).

  num\_tokens
 :   \(Default: 256\) [note](configCassandra_yaml.md#asterisks) The number of tokens randomly assigned to this node in a cluster that uses [virtual nodes](configVnodesEnable.md) \(vnodes\). This setting is evaluated in relation to the `num_tokens` set on other nodes in the cluster. If this node's `num_tokens` value is higher than the values on other nodes, the vnode logic assigns this node a larger proportion of data relative to other nodes. In general, if all nodes have equal hardware capability, each one should have the same `num_tokens` value . The recommended value is 256. If this property is commented out \(`#num_tokens`\), Cassandra uses 1 \(equivalent to `#num_tokens : 1`\) for legacy compatibility and assigns tokens using the initial\_token property.

 :   If this cluster is not using vnodes, comment out `num_tokens` or set `num_tokens: 1` and use [initial\_token](configCassandra_yaml.md#initial_token). If you already have an existing cluster with one token per node and wish to migrate to vnodes, see [Enabling virtual nodes on an existing production cluster](configVnodesProduction.md).

  allocate\_tokens\_keyspace
 :   \(Default: KEYSPACE\) ﻿Enables automatic allocation of `num_tokens` tokens for this node. The allocation algorithm attempts to choose tokens in a way that optimizes replicated load over the nodes in the datacenter for the replication strategy used by the specified KEYSPACE. The load assigned to each node will near proportional to its number of vnodes.

  partitioner
 :   \(Default: org.apache.cassandra.dht.Murmur3Partitioner\) Sets the class that distributes rows \(by partition key\) across all nodes in the cluster. Any IPartitioner may be used, including your own as long as it is in the class path. For new clusters use the default partitioner.

    Cassandra provides the following partitioners for backwards compatibility:

    -   RandomPartitioner 
    -   ByteOrderedPartitioner \(deprecated\)
    -   OrderPreservingPartitioner \(deprecated\)

    Related information: [Partitioners](../architecture/archPartitionerAbout.md)

  storage\_port
 :   \(Default: 7000\) The port for inter-node communication.

  tracetype\_query\_ttl
 :   ﻿\(Default: 86400\) TTL for different trace types used during logging of the query process

  tracetype\_repair\_ttl
 :   ﻿\(Default: 604800\)﻿ TTL for different trace types used during logging of the repair process.

 *Advanced automatic backup setting*

 auto\_snapshot
 :   \(Default: true\) Enables or disables whether Cassandra takes a snapshot of the data before truncating a keyspace or dropping a table. To prevent data loss, Datastax strongly advises using the default setting. If you set `auto_snapshot` to `false`, you lose data on truncation or drop.

 *Key caches and global row properties*

When creating or modifying tables, you can enable or disable the key cache \(partition key cache\) or row cache for that table by setting the caching parameter. Other row and key cache tuning and configuration options are set at the global \(node\) level. Cassandra uses these settings to automatically distribute memory for each table on the node based on the overall workload and specific table usage. You can also configure the save periods for these caches globally.

Related information: [Configuring caches](../operations/opsConfiguringCaches.md)

 key\_cache\_keys\_to\_save
 :   \(Default: disabled - all keys are saved\)[note](configCassandra_yaml.md#asterisks) Number of keys from the key cache to save.

  key\_cache\_save\_period
 :   \(Default: 14400 seconds \[4 hours\]\) Duration in seconds that keys are kept in cache. Caches are saved to [saved\_caches\_directory](configCassandra_yaml.md#saved_caches_directory). Saved caches greatly improve cold-start speeds and have relatively little effect on I/O.

  key\_cache\_size\_in\_mb
 :   \(Default: empty\) A global cache setting for the maximum size of the key cache in memory \(for all tables\). If no value is set, the cache is set to the smaller of 5% of the available heap, or 100MB. To disable set to 0.

    Related information: [setcachecapacity](../tools/toolsSetCacheCapacity.md), [Enabling and configuring caching](../operations/opsSetCaching.md).

  column\_index\_cache\_size\_in\_kb
 :   \(Default: 2\) A threshold for the total size of all index entries for a partition that Cassandra stores in the partition key cache. If the total size of all index entries for a partition exceeds this amount, Cassandra stops putting entries for this partition into the partition key cache. This limitation prevents index entries from large partitions from taking up all the space in the partition key cache \(which is controlled by `key_cache_size_in_mb`\).

  row\_cache\_class\_name
 :   \(Default: disabled - row cache is not enabled\)[note](configCassandra_yaml.md#asterisks) The classname of the row cache provider to use. Valid values: `OHCProvider` \(fully off-heap\) or `SerializingCacheProvider` \(partially off-heap\).

  row\_cache\_keys\_to\_save
 :   \(Default: disabled - all keys are saved\)[note](configCassandra_yaml.md#asterisks) Number of keys from the row cache to save.

  row\_cache\_size\_in\_mb
 :   \(Default: 0- disabled\) Maximum size of the row cache in memory. The row cache can save more time than [key\_cache\_size\_in\_mb](configCassandra_yaml.md#key_cache_size_in_mb),, but it is space-intensive because it contains the entire row. Use the row cache only for hot rows or static rows. If you reduce the size, you may not get you hottest keys loaded on start up.

  row\_cache\_save\_period
 :   \(Default: 0- disabled\) The number of seconds that rows are kept in cache. Caches are saved to [saved\_caches\_directory](configCassandra_yaml.md#saved_caches_directory). This setting has limited use as described in row\_cache\_size\_in\_mb.

 *Counter caches properties*

Counter cache helps to reduce counter locks' contention for hot counter cells. In case of RF = 1 a counter cache hit causes Cassandra to skip the read before write entirely. With RF \> 1 a counter cache hit still helps to reduce the duration of the lock hold, helping with hot counter cell updates, but does not allow skipping the read entirely. Only the local \(clock, count\) tuple of a counter cell is kept in memory, not the whole counter, so it is relatively cheap.

**Note:** If you reduce the counter cache size, Cassandra may load the hottest keys start-up.

 counter\_cache\_size\_in\_mb
 :   \(Default value: empty\)[note](configCassandra_yaml.md#asterisks) When no value is set, Cassandra uses the smaller of minimum of 2.5% of Heap or 50MB. If your system performs counter deletes and relies on low [gc\_grace\_seconds](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#tabProp__cql_gc_grace_sec), you should disable the counter cache. To disable, set to 0.

  counter\_cache\_save\_period
 :   \(Default: 7200 seconds \[2 hours\]\) the amount of time after which Cassandra saves the counter cache \(keys only\). Cassandra saves caches to [saved\_caches\_directory](configCassandra_yaml.md#saved_caches_directory).

  counter\_cache\_keys\_to\_save
 :   \(Default value: disabled\)[note](configCassandra_yaml.md#asterisks) Number of keys from the counter cache to save. When this property is disabled, Cassandra saves all keys.

 *Tombstone settings*

When executing a scan, within or across a partition, Cassandra must keep tombstones in memory to allow them to return to the coordinator. The coordinator uses tombstones to ensure that other replicas know about the deleted rows. Workloads that generate numerous tombstones may cause performance problems and exhaust the server heap. See [Cassandra anti-patterns: Queues and queue-like datasets](https://www.datastax.com/blog/2013/04/cassandra-anti-patterns-queues-and-queue-datasets). Adjust these thresholds only if you understand the impact and want to scan more tombstones. You can adjust these thresholds at runtime using the StorageServiceMBean.

Related information: [Cassandra anti-patterns: Queues and queue-like datasets](https://www.datastax.com/blog/2013/04/cassandra-anti-patterns-queues-and-queue-datasets)

 tombstone\_warn\_threshold
 :   \(Default: 1000\) Cassandra issues a warning if a query scans more than this number of tombstones.

  tombstone\_failure\_threshold
 :   \(Default: 100000\) Cassandra aborts a query if it scans more than this number of tombstones.

 *Network timeout settings*

 range\_request\_timeout\_in\_ms
 :   \(Default: 10000 milliseconds\) The number of milliseconds that the coordinator waits for sequential or index scans to complete before timing it out.

  read\_request\_timeout\_in\_ms
 :   \(Default: 5000 milliseconds\) The number of milliseconds that the coordinator waits for read operations to complete before timing it out.

  counter\_write\_request\_timeout\_in\_ms
 :   \(Default: 5000 milliseconds\) The number of milliseconds that the coordinator waits for counter writes to complete before timing it out.

  cas\_contention\_timeout\_in\_ms
 :   \(Default: 1000 milliseconds\) The number of milliseconds during which the coordinator continues to retry a CAS \(compare and set\) operation that contends with other proposals for the same row. If the coordinator cannot complete the operation within this timespan, it aborts the operation.

  cqlTruncateequest\_timeout\_in\_ms
 :   \(Default: 60000 milliseconds\) The number of milliseconds that the coordinator waits for a truncate \(the removal of all data from a table\) to complete before timing it out. The long default value allows Cassandra to take a snapshot before removing the data. If [auto\_snapshot](configCassandra_yaml.md#auto_snapshot) is disabled \(not recommended\), you can reduce this time.

  write\_request\_timeout\_in\_ms
 :   \(Default: 2000 milliseconds\) The number of milliseconds that the coordinator waits for a write operations to complete before timing it out.

    Related information: [Hinted Handoff: repair during write path](../operations/opsRepairNodesHintedHandoff.md)

  request\_timeout\_in\_ms
 :   \(Default: 10000 milliseconds\) The default timeout value for other miscellaneous operations.

    Related information: [Hinted Handoff: repair during write path](../operations/opsRepairNodesHintedHandoff.md)

 *Inter-node settings*

 cross\_node\_timeout
 :   \(Default: false\) Enables or disables operation timeout information exchange between nodes \(to accurately measure request timeouts\). If this property is disabled, Cassandra assumes the requests are forwarded to the replica instantly by the coordinator, which means that under overload conditions extra time is required for processing already-timed-out requests.

    CAUTION:

    Before enabling this property make sure NTP \(network time protocol\) is installed and the times are synchronized among the nodes.

  internode\_send\_buff\_size\_in\_bytes
 :   \(Default: N/A\)[note](configCassandra_yaml.md#asterisks) The sending socket buffer size in bytes for inter-node calls.

    The buffer size set by this parameter and [internode\_recv\_buff\_size\_in\_bytes](configCassandra_yaml.md#internode_recv_buff_size_in_bytes) is limited by `net.core.wmem_max`. If this property is not set, `net.ipv4.tcp_wmem` determines the buffer size. See man tcp and:

    -   /proc/sys/net/core/wmem\_max
    -   /proc/sys/net/core/rmem\_max
    -   /proc/sys/net/ipv4/tcp\_wmem
    -   /proc/sys/net/ipv4/tcp\_wmem

    Related information: [TCP settings](/en/landing_page/doc/landing_page/recommendedSettingsLinux.html#recommendedSettingsLinux__tcp-settings)

  internode\_recv\_buff\_size\_in\_bytes
 :   \(Default: N/A\)[note](configCassandra_yaml.md#asterisks)The receiving socket buffer size in bytes for inter-node calls.

  internode\_compression
 :   \(Default: all\) Controls whether traffic between nodes is compressed. Valid values:

    -   all

        Compresses all traffic.

    -   dc 

        Compresses traffic between datacenters only.

    -   none

        No compression.


  inter\_dc\_tcp\_nodelay
 :   \(Default: false\) Enable this property or disable tcp\_nodelay for inter-datacenter communication. If this property is disabled, the network sends larger, but fewer, network packets. This reduces overhead from the TCP protocol itself. However, disabling `inter_dc_tcp_nodelay` may increase latency by blocking cross data-center responses.

  streaming\_socket\_timeout\_in\_ms
 :   \(Default: 3600000 - 1 hour\)[note](configCassandra_yaml.md#asterisks) Enables or disables socket timeout for streaming operations. If a streaming times out by exceeding this number of milliseconds, Cassandra retries it from the start of the current file. Setting this value too low can result in a significant amount of data re-streaming.

 *Native transport \(CQL Binary Protocol\)* 

 start\_native\_transport
 :   \(Default: true\) Enables or disables the native transport server. This server uses the same address as the [rpc\_address](configCassandra_yaml.md#rpc_address), but the port it uses is different from [rpc\_port](configCassandra_yaml.md#rpc_port). See [native\_transport\_port](configCassandra_yaml.md#native_transport_port).

  native\_transport\_port
 :   \(Default: 9042\) The port where the CQL native transport listens for clients.

  native\_transport\_max\_threads
 :   \(Default: 128\)[note](configCassandra_yaml.md#asterisks) The maximum number of thread handling requests. Similar to [rpc\_max\_threads](configCassandra_yaml.md#rpc_max_threads), but this property differs as follows:

    -   The default for `native_transport_max_threads` is 128; the default for `rpc_max_threads` is unlimited.
    -   There is no corresponding `native_transport_min_threads`.
    -   Cassandra stops idle native transport threads after 30 seconds.

  native\_transport\_max\_frame\_size\_in\_mb
 :   \(Default: 256MB\) The maximum allowed size of a frame. Frame \(requests\) larger than this are rejected as invalid.

  native\_transport\_max\_concurrent\_connections
 :   \(Default: -1\) The maximum number of concurrent client connections. The default value of -1 means unlimited.

  native\_transport\_max\_concurrent\_connections\_per\_ip
 :   \(Default: -1\) The maximum number of concurrent client connections per source IP address. The default value of -1 means unlimited.

 *RPC \(remote procedure call\) settings*

Settings for configuring and tuning client connections.

 broadcast\_rpc\_address
 :   \(Default: unset\)[note](configCassandra_yaml.md#asterisks) The RPC address for broadcast to drivers and other Cassandra nodes. This cannot be set to 0.0.0.0. If left blank, Cassandra uses the [rpc\_address](configCassandra_yaml.md#rpc_address) or [rpc\_interface](configCassandra_yaml.md#broadcast_rpc_address). If rpc\_address or rpc\_interfaceis set to 0.0.0.0, this property must be set.

  rpc\_port
 :   \(Default: 9160\) Thrift port for client connections.

  start\_rpc
 :   \(Default: true\) Enables or disables the Thrift RPC server.

  rpc\_keepalive
 :   \(Default: true\) Enables or disables keepalive on client connections \(RPC or native\).

  rpc\_max\_threads
 :   \(Default: unlimited\)[note](configCassandra_yaml.md#asterisks) Regardless of your choice of RPC server \([rpc\_server\_type](configCassandra_yaml.md#rpc_server_type)\), rpc\_max\_threads dictates the maximum number of concurrent requests in the RPC thread pool. If you are using the parameter sync \(see [rpc\_server\_type](configCassandra_yaml.md#rpc_server_type)\) it also dictates the number of clients that can be connected. A high number of client connections could cause excessive memory usage for the thread stack. Connection pooling on the client side is highly recommended. Setting a rpc\_max\_threads acts as a safeguard against misbehaving clients. If the number of threads reaches the maximum, Cassandra blocks additional connections until a client disconnects.

  rpc\_min\_threads
 :   \(Default: 16\)[note](configCassandra_yaml.md#asterisks)The minimum thread pool size for remote procedure calls.

  rpc\_recv\_buff\_size\_in\_bytes
 :   \(Default: N/A\)[note](configCassandra_yaml.md#asterisks) The receiving socket buffer size for remote procedure calls.

  rpc\_send\_buff\_size\_in\_bytes
 :   \(Default: N/A\)[note](configCassandra_yaml.md#asterisks) The sending socket buffer size in bytes for remote procedure calls.

  rpc\_server\_type
 :   \(Default: sync\) Cassandra provides three options for the RPC server. On Windows, `sync` is about 30% slower than `hsha`. On Linux, `sync` and `hsha` performance is about the same, but `hsha` uses less memory.

    -   sync: \(Default: one thread per Thrift connection.\)

        For a very large number of clients, memory is the limiting factor. On a 64-bit JVM, 180KB is the minimum stack size per thread and corresponds to your use of virtual memory. Physical memory may be limited depending on use of stack space.

    -   hsha:

        Half synchronous, half asynchronous. All Thrift clients are handled asynchronously using a small number of threads that does not vary with the number of clients. This mechanism scales well to many clients. The RPC requests are synchronous \(one thread per active request\).

        **Note:** If you select this option, you must change the default value \(unlimited\) of [rpc\_max\_threads](configCassandra_yaml.md#rpc_max_threads).

    -   Your own RPC server

        You must provide a fully-qualified class name of an o.a.c.t.TServerFactory that can create a server instance.


 *Advanced fault detection settings*

Settings to handle poorly performing or failing components.

 gc\_warn\_threshold\_in\_ms
 :   \(Default:1000\) Any GC pause longer than this interval is logged at the WARN level. \(By default, Cassandra logs any GC pause greater than 200 ms at the INFO level.\)

    Additional information: [Configuring logging](configLoggingLevels.md).

  dynamic\_snitch\_badness\_threshold
 :   \(Default:0.1\) The performance threshold for dynamically routing client requests away from a poorly performing node. Specifically, it controls how much worse a poorly performing node has to be before the [dynamic snitch](../architecture/archSnitchDynamic.md) prefers other replicas over it. A value of 0.2 means Cassandra continues to prefer the static snitch values until the node response time is 20% worse than the best performing node. Until the threshold is reached, incoming requests are statically routed to the closest replica \(as determined by the snitch\). A value greater than zero for this parameter, with a value of less than 1.0 for [read\_repair\_chance](/en/cql-oss/3.3/cql/cql_reference/cqlCreateTable.html#tabProp), maximizes cache capacity across the nodes.

  dynamic\_snitch\_reset\_interval\_in\_ms
 :   \(Default: 600000 milliseconds\) Time interval after which Cassandra resets all node scores. This allows a bad node to recover.

  dynamic\_snitch\_update\_interval\_in\_ms
 :   \(Default: 100 milliseconds\) The number of milliseconds between Cassandra's calculation of node scores. Because score calculation is CPU intensive, be careful when reducing this interval.

  hints\_flush\_period\_in\_ms
 :   \(Default: 10000\) The number of milliseconds Cassandra waits before flushing hints from internal buffers to disk.

  hints\_directory
 :   \(Default: $CASSANDRA\_HOME/data/hints\) The directory in which hints are stored.

  hinted\_handoff\_enabled
 :   \(Default: true\) Enables or disables hinted handoff. To enable per datacenter, add a list of datacenters. For example: `hinted_handoff_enabled: DC1,DC2`. A hint indicates that the write needs to be replayed to an unavailable node. Cassandra writes the hint to a hints file on the coordinator node.

    Related information: [Hinted Handoff: repair during write path](../operations/opsRepairNodesHintedHandoff.md)

  hinted\_handoff\_disabled\_datacenters
 :   \(Default: none\) A blacklist of datacenters that will not perform hinted handoffs. To disable hinted handoff on a certain datacenter, , add its name to this list. For example: `hinted_handoff_disabled_datacenters: - DC1 - DC2`.

    Related information: [Hinted Handoff: repair during write path](../operations/opsRepairNodesHintedHandoff.md)

  hinted\_handoff\_throttle\_in\_kb
 :   \(Default: 1024\) Maximum amount of traffic per delivery thread in kilobytes per second. This rate reduces proportionally to the number of nodes in the cluster. For example, if there are two nodes in the cluster, each delivery thread uses the maximum rate. If there are three, each node throttles to half of the maximum, since the two nodes are expected to deliver hints simultaneously.

    **Note:** When applying this limit, Cassandra computes the hint transmission rate based on the uncompressed hint size, even if [internode\_compression](configCassandra_yaml.md#internode_compression) or [hints\_compression](configCassandra_yaml.md#hints_compression) is enabled.

  max\_hint\_window\_in\_ms
 :   \(Default: 10800000 milliseconds \[3 hours\]\) Maximum amount of time during which Cassandra generates hints for an unresponsive node. After this interval, Cassandra does not generate any new hints for the node until it is back up and responsive. If the node goes down again, Cassandra starts a new interval. This setting can prevent a sudden demand for resources when a node is brought back online and the rest of the cluster attempts to replay a large volume of hinted writes.

    Related information: [Failure detection and recovery](../architecture/archDataDistributeFailDetect.md)

  max\_hints\_delivery\_threads
 :   \(Default: 2\) Number of threads Cassandra uses to deliver hints. In multiple data-center deployments, consider increasing this number because cross data-center handoff is generally slower.

  max\_hints\_file\_size\_in\_mb
 :   \(Default: 128\) The maximum size for a single hints file, in megabytes.

  hints\_compression
 :   \(Default: LZ4Compressor\) The compressor for hint files. Supported compressors: [LZ](https://en.wikipedia.org/wiki/Lempel–Ziv–Welch), [Snappy](https://google.github.io/snappy/), and [Deflate](https://en.wikipedia.org/wiki/DEFLATE). If you do not specify a compressor, Cassandra does not compress hints files.

  batchlog\_replay\_throttle\_in\_kb
 :   \(Default: 1024KB per second\) Total maximum throttle for replaying hints. Throttling is reduced proportionally to the number of nodes in the cluster.

 *Request scheduler properties*

Settings to handle incoming client requests according to a defined policy. If your nodes are overloaded and dropping requests, DataStax recommends that you add more nodes rather than use these properties to prioritize requests.

**Note:** The properties in this section apply only to the Thrift transport. They have no effect on the use of CQL over the native protocol.

 request\_scheduler
 :   \(Default: org.apache.cassandra.scheduler.NoScheduler\) The scheduler to handle incoming client requests according to a defined policy. This scheduler is useful for throttling client requests in single clusters containing multiple keyspaces. This parameter is specifically for requests from the client and does not affect inter-node communication. Valid values:

    -   org.apache.cassandra.scheduler.NoScheduler

        Cassandra does no scheduling.

    -   org.apache.cassandra.scheduler.RoundRobinScheduler

        Cassandra uses a round robin of client requests to a node with a separate queue for each [request\_scheduler\_id](configCassandra_yaml.md#request_scheduler_id) property.

    -   Cassandra uses a Java class that implements the RequestScheduler interface.

  request\_scheduler\_id
 :   \(Default: keyspace\)[note](configCassandra_yaml.md#asterisks) The scope of the scheduler's activity. Currently the only valid value is keyspace. See [weights](configCassandra_yaml.md#keyspace).

  request\_scheduler\_options
 :   \(Default: disabled\) A list of properties that define configuration options for [request\_scheduler](configCassandra_yaml.md#request_scheduler):

    -   throttle\_limit: The number of in-flight requests per client. Requests beyond this limit are queued up until running requests complete. Recommended value is \(\(concurrent\_reads + concurrent\_writes\) × 2\).
    -   default\_weight: \(Default: 1\)[note](configCassandra_yaml.md#asterisks) 

        How many requests the scheduler handles during each turn of the RoundRobin.

    -   weights: \(Default: Keyspace: 1\)

        A list of keyspaces. How many requests the scheduler handles during each turn of the RoundRobin, based on the [request\_scheduler\_id](configCassandra_yaml.md#request_scheduler_id).


 *Thrift interface properties*

Legacy API for older clients. [CQL](/en/cql-oss/3.3/cql/cqlIntro.html) is a simpler and better API for Cassandra.

 thrift\_framed\_transport\_size\_in\_mb
 :   \(Default: 15\) Frame size \(maximum field length\) for Thrift. The frame is the row or part of the row that the application is inserting.

  thrift\_max\_message\_length\_in\_mb
 :   \(Default: 16\) The maximum length of a Thrift message in megabytes, including all fields and internal Thrift overhead \(1 byte of overhead for each frame\). Calculate message length in conjunction with batches. A frame length greater than or equal to 24 accommodates a batch with four inserts, each of which is 24 bytes. The required message length is greater than or equal to 24+24+24+24+4 \(number of frames\).

 ## Security properties {#SecurityProps .section}

Server and client security settings.

 authenticator
 :   \(Default: AllowAllAuthenticator\) The authentication backend. It implements IAuthenticator for identifying users. Available authenticators:

    -   AllowAllAuthenticator:

        Disables authentication; Cassandra performs no checks.

    -   PasswordAuthenticator

        Authenticates users with user names and hashed passwords stored in the system\_auth.credentials table. Leaving the default replication factor of 1 set for the *system\_auth* keyspace results in denial of access to the cluster if the single replica of the keyspace goes down. For multiple datacenters, be sure to set the replication class to `NetworkTopologyStrategy`.


    Related information: [About Internal authentication](secureAboutNativeAuth.md)

  internode\_authenticator
 :   \(Default: enabled\)[note](configCassandra_yaml.md#asterisks) Internode authentication backend. It implements org.apache.cassandra.auth.AllowAllInternodeAuthenticator to allows or disallow connections from peer nodes.

  authorizer
 :   \(Default: AllowAllAuthorizer\) The authorization backend. It implements IAuthenticator to limit access and provide permissions. Available authorizers:

    -   AllowAllAuthorizer

        Disables authorization: Cassandra allows any action to any user.

    -   CassandraAuthorizer

        Stores permissions in system\_auth.permissions table. Leaving the default replication factor of 1 set for the *system\_auth* keyspace results in denial of access to the cluster if the single replica of the keyspace goes down. For multiple datacenters, be sure to set the replication class to `NetworkTopologyStrategy`.


    Related information: [Object permissions](secureObjectPerms.md)

  role\_manager
 :   \(Default: CassandraRoleManager\) ﻿Part of the Authentication & Authorization backend that implements IRoleManager to maintain grants and memberships between roles. Out of the box, Cassandra provides org.apache.cassandra.auth.CassandraRoleManager, which stores role information in the system\_auth keyspace. Most functions of the IRoleManager require an authenticated login, so unless the configured IAuthenticator actually implements authentication, most of this functionality will be unavailable. `CassandraRoleManager` stores role data in the `system_auth` keyspace. If you use the role manager, increase `system_auth` keyspace replication factor .

  roles\_validity\_in\_ms
 :   \(Default: 2000\) ﻿Fetching permissions can be an expensive operation depending on the authorizer, so this setting allows flexibility. Validity period for roles cache; set to 0 to disable. Granted roles are cached for authenticated sessions in `AuthenticatedUser` and after the period specified here, become eligible for \(async\) reload. Disabled automatically for `AllowAllAuthenticator`.

  roles\_update\_interval\_in\_ms
 :   \(Default: 2000\) ﻿ ﻿Enable to refresh interval for roles cache. Defaults to the same value as `roles_validity_in_ms`. After this interval, cache entries become eligible for refresh. Upon next access, Cassandra schedules an async reload, and returns the old value until the reload completes. If `roles_validity_in_ms` is non-zero, then this must be also.

  credentials\_validity\_in\_ms
 :   \(Default: 2000\) How many milliseconds credentials in the cache remain valid. This cache is tightly coupled to the provided PasswordAuthenticator implementation of [IAuthenticator](configCassandra_yaml.md#authenticator). If another IAuthenticator implementation is configured, Cassandra does not use this cache, and these settings have no effect. Set to 0 to disable.

    Related information: [Internal authentication](secureInternalAuthenticationTOC.md), [Internal authorization](secureInternalAuthorizationTOC.md)

    **Note:** Credentials are cached in encrypted form. This may cause a performance penalty that offsets the reduction in latency gained by caching.

  credentials\_update\_interval\_in\_ms
 :   \(Default: same value as credentials\_validity\_in\_ms\) After this interval, cache entries become eligible for refresh. The next time the cache is accessed, the system schedules an asynchronous reload of the cache. Until this cache reload is complete, the cache returns the old values.

    If credentials\_validity\_in\_ms is nonzero, this property must also be nonzero.

  permissions\_validity\_in\_ms
 :   \(Default: 2000\) How many milliseconds permissions in cache remain valid. Depending on the authorizer, such as CassandraAuthorizer, fetching permissions can be resource intensive. This setting is disabled when set to 0 or when AllowAllAuthorizer is set.

    Related information: [Object permissions](secureObjectPerms.md)

  permissions\_update\_interval\_in\_ms
 :   \(Default: same value as [permissions\_validity\_in\_ms](configCassandra_yaml.md#permissions_validity_in_ms)\)[note](configCassandra_yaml.md#asterisks) If enabled, sets refresh interval for the permissions cache. After this interval, cache entries become eligible for refresh. On next access, Cassandra schedules an async reload and returns the old value until the reload completes. If permissions\_validity\_in\_ms is nonzero, roles\_update\_interval\_in\_ms must also be non-zero.

  server\_encryption\_options
 :   Enables or disables inter-node encryption. If you enable server\_encryption\_options, you must also generate keys and provide the appropriate key and truststore locations and passwords. There are no custom encryption options currently enabled for Cassandra. Available options:

    -   internode\_encryption: \(Default: none\) Enables or disables encryption of inter-node communication using the `TLS_RSA_WITH_AES_128_CBC_SHA` cipher suite for authentication, key exchange, and encryption of data transfers. Use the DHE/ECDHE ciphers, such as `TLS_DHE_RSA_WITH_AES_128_CBC_SHA` if running in \(Federal Information Processing Standard\) FIPS 140 compliant mode. Available inter-node options:
        -   all

            Encrypt all inter-node communications.

        -    none

            No encryption.

        -   dc

            Encrypt the traffic between the datacenters \(server only\).

        -   rack

            Encrypt the traffic between the racks \(server only\).

    -   keystore: \(Default: conf/.keystore\)

        The location of a Java keystore \(JKS\) suitable for use with Java Secure Socket Extension \(JSSE\), which is the Java version of the Secure Sockets Layer \(SSL\), and Transport Layer Security \(TLS\) protocols. The keystore contains the private key used to encrypt outgoing messages.

    -   keystore\_password: \(Default: cassandra\)

        Password for the keystore.

    -   truststore: \(Default: conf/.truststore\)

        Location of the truststore containing the trusted certificate for authenticating remote servers.

    -   truststore\_password: \(Default: cassandra\)

        Password for the truststore.


    The passwords used in these options must match the passwords used when generating the keystore and truststore. For instructions on generating these files, see [Creating a Keystore to Use with JSSE.](http://docs.oracle.com/javase/7/docs/technotes/guides/security/jsse/JSSERefGuide.html#CreateKeystore)

    The advanced settings:

    -   protocol: \(Default: TLS\)
    -   algorithm: \(Default: SunX509\)
    -   store\_type: \(Default: JKS\)
    -   cipher\_suites: \(Default: TLS\_RSA\_WITH\_AES\_128\_CBC\_SHA,TLS\_RSA\_WITH\_AES\_256\_CBC\_SHA\)
    -   require\_client\_auth: \(Default: false\)

        Enables or disables certificate authentication.

    -   require\_endpoint\_verification: \(Default: false\)

        Enables or disables host name verification.


    Related information: [Node-to-node encryption](secureSSLNodeToNode.md)

  client\_encryption\_options
 :   Enables or disables client-to-node encryption. You must also generate keys and provide the appropriate key and truststore locations and passwords. There are no custom encryption options are currently enabled for Cassandra. Available options:

    -   enabled: \(Default: false\)

        To enable, set to true.

    -   keystore: \(Default: conf/.keystore\)

        The location of a Java keystore \(JKS\) suitable for use with Java Secure Socket Extension \(JSSE\), which is the Java version of the Secure Sockets Layer \(SSL\), and Transport Layer Security \(TLS\) protocols. The keystore contains the private key used to encrypt outgoing messages.

    -   keystore\_password: \(Default: cassandra\)

        Password for the keystore. This must match the password used when generating the keystore and truststore.

    -   require\_client\_auth: \(Default: false\)

        Enables or disables certificate authentication. \(Available starting with Cassandra 1.2.3.\)

    -   truststore: \(Default: conf/.truststore\)

        Set this property if require\_client\_auth is `true`.

    -   truststore\_password: truststore\_password 

        Set if require\_client\_authis `true`.


    Advanced settings:

    -   protocol: \(Default: TLS\)
    -   algorithm: \(Default: SunX509\)
    -   store\_type: \(Default: JKS\)
    -   cipher\_suites: \(Default: TLS\_RSA\_WITH\_AES\_128\_CBC\_SHA,TLS\_RSA\_WITH\_AES\_256\_CBC\_SHA\)

    Related information: [Client-to-node encryption](secureSSLClientToNode.md)

  transparent\_data\_encryption\_options
 :   Enables encryption of data *at rest* \(on-disk\). Recommendation: download and install the [Java Cryptography Extension \(JCE\) Unlimited Strength Jurisdiction Policy Files](http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html) for your version of the JDK.

    Cassandra supports transparent data encryption for the following file types:

    -   [commitlog](configCassandra_yaml.md#c_yaml_commitlog_settings)
    -   [hints](configCassandra_yaml.md#c_yaml_advanced_fault_detection_settings)

    Available options:

    -   enabled: \(Default: false\)
    -   chunk\_length\_kb: \(Default: 64\)
    -   cipher: options:
        -   AES
        -   CBC
        -   PKCS5Padding
    -   key\_alias: testing:1
    -    iv\_length: 16

        **Note:** iv\_length is commented out in the default cassandra.yaml file. Uncomment only if cipher is set to AES. The value must be 16 \(bytes\).

    -   key\_provider:
        -   class\_name: org.apache.cassandra.security.JKSKeyProvider

            parameters:

            -   keystore: conf/.keystore
            -   keystore\_password: cassandra
            -   store\_type: JCEKS
            -   key\_password: cassandra 

  ssl\_storage\_port
 :   \(Default: 7001\) The SSL port for encrypted communication. Unused unless enabled in encryption\_options.

  native\_transport\_port\_ssl
 :   \(Default: 9142\) In Cassandra 3.0 and later, an additional dedicated port can be designated for encryption. If client encryption is enabled and `native_transport_port_ssl` is disabled, the `native_transport_port` \(default: 9042\) will encrypt all traffic. To use both unencrypted and encrypted traffic, enable `native_transport_port_ssl`

 The location of the cassandra-env.sh file depends on the type of installation:

|Package installations|/etc/cassandra/cassandra-env.sh|
|Tarball installations|install\_location/conf/cassandra-env.sh|

**Parent topic:** [Configuration](../../cassandra/configuration/configTOC.md)

