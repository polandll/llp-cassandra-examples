# nodetool repair {#toolsRepair .reference}

Repairs one or more tables.

Repairs one or more tables.

## Synopsis {#synopsis .section}

```language-bash
 nodetool [(-h <host> | --host <host>)] [(-p <port> | --port <port>)]
     [(-pw password | --password password)]
     [(-pwf passwordFilePath | --password-file passwordFilePath)]
     [(-u username | --username username)] repair
     [(-dc specific\_dc | --in-dc specific\_dc)...]
     [(-dcpar | --dc-parallel)] [(-et end\_token | --end-token end\_token)]
     [(-full | --full)]
     [(-hosts specific\_host | --in-hosts specific\_host)...]
     [(-j job\_threads | --job-threads job\_threads)]
     [(-local | --in-local-dc)] [(-pr | --partitioner-range)]
     [(-seq | --sequential)]
     [(-st start\_token | --start-token start\_token)] [(-tr | --trace)]
     [--] [keyspace tables...]
```

|Short|Long|Description|
|-----|----|-----------|
|`-h`|`--host`|Hostname or IP address.|
|`-p`|`--port`|Port number.|
|`-pwf`|`--password-file`|Password file path.|
|`-pw`|`--password`|Password.|
|`-u`|`--username`|Remote JMX agent username.|
|`-dc` specific\_dc|`--in-dc` specific\_dc|Repair to nodes in the named datacenter \(specific\_dc\).|
|`-dcpar`|`--dc-parallel`|Repair datacenters in parallel, one node per datacenter at a time.|
|`-et end\_token`|`--end-token end\_token`|Token UUID. Repair a range of nodes starting with the first token \(see -st\) and ending with this token \(end\_token\). Use -hosts to specify neighbor nodes.|
|`-full`|`--full`|Do a full repair.|
|`-h host\_name` |`--host host\_name` |Node host name or IP address.|
|`-hosts specific\_host`|`--in-hosts specific\_host`|Repair specific hosts.|
|`-j job\_threads`|`--job-threads job\_threads`|Number of threads \(job\_threads\) to run repair jobs. Usually the number of tables to repair concurrently. Be aware that increasing this setting puts more load on repairing nodes. \(Default: 1, maximum: 4\)|
|`-local`|`--in-local-dc`|Use to only repair nodes in the same datacenter.|
|-pr|--partitioner-range|Run a repair on the partition ranges that are primary on a replica.|
|`-seq start\_token`|`--sequential start\_token`|Run a sequential repair.|
|`-st start\_token`|`--start-token start\_token`|Specify the token \(start\_token\) at which the repair range starts.|
|`-tr`|`--trace`|Trace the repair. Traces are logged to system\_traces.events.|
|keyspace|Name of keyspace.|
|tables|One or more table names, separated by a space.|
|`--`|Separates an option from an argument that could be mistaken for a option.|

## Description {#description .section}

Performing an anti-entropy node repair on a [regular basis](../operations/opsRepairNodesManualRepair.md) is important, especially in an environment that deletes data frequently. The `repair` command repairs one or more nodes in a cluster, and provides options for restricting repair to a set of nodes. Anti-entropy node repair performs the following tasks:

-   Ensures that all data on a replica is consistent.
-   Repairs inconsistencies on a node that has been down.

Incremental repair is the default for Cassandra 2.2 and later, and full repair is the default in Cassandra 2.1 and earlier. In Cassandra 2.2 and later, when a full repair is run, SSTables are marked as repaired and anti-compacted. Parallel repair is the default for Cassandra 2.2 and later, and sequential repair is the default in Cassandra 2.1 and earlier.

## Using options {#toolsRepairTypes .section}

You can use options to do these other types of repair:

-   Sequential or Parallel
-   Full or incremental

Use the -hosts option to list the good nodes to use for repairing the bad nodes. Use -h to name the bad nodes.

Use the -full option for a full repair if required. By default, an incremental repair eliminates the need for constant Merkle tree construction by persisting already repaired data and calculating only the Merkle trees for SSTables that have not been repaired. The repair process is likely more performant than the other types of repair even as datasets grow, assuming you run repairs frequently. Before doing an incremental repair for the first time, perform [migration steps](../operations/opsRepairNodesMigration.md) first if necessary for tables created before Cassandra 2.2.

Use the -dcpar option to repair data centers in parallel. Unlike [sequential repair](../operations/opsRepairNodesManualRepair.md), parallel repair constructs the Merkle tables for all data centers at the same time. Therefore, no snapshots are required \(or generated\). Use parallel repair to complete the repair quickly or when you have operational downtime that allows the resources to be completely consumed during the repair.

Performing [partitioner range repairs](../operations/opsRepairNodesManualRepair.md) by using the -pr option is generally considered a good choice for doing manual repairs. However, do not use this option with incremental repairs \(default for Cassandra 3.0 and later\).

## Example {#toolsRepairExample .section}

All nodetool repair arguments are optional.

To do a sequential repair of all keyspaces on the current node:

```language-bash
nodetool repair -seq
```

To do a partitioner range repair of the bad partition on current node using the good partitions on 10.2.2.20 or 10.2.2.21:

```language-bash
nodetool repair -pr -hosts 10.2.2.20 10.2.2.21
```

For a start-point-to-end-point repair of all nodes between two nodes on the ring:

```language-bash
nodetool -st a9fa31c7-f3c0-44d1-b8e7-a26228867840c -et f5bb146c-db51-475ca44f-9facf2f1ad6e 
```

To restrict the repair to the local data center, use the `-dc` option followed by the name of the data center. Issue the command from a node in the data center you want to repair. Issuing the command from a data center other than the named one returns an error. Do not use `-pr` with this option to repair only a local data center.

```language-bash
nodetool repair -dc DC1
```

Results in output:

```
[2014-07-24 21:59:55,326] Nothing to repair for keyspace 'system'
[2014-07-24 21:59:55,617] Starting repair command #2, repairing 490 ranges 
  for keyspace system_traces (seq=true, full=true)
[2014-07-24 22:23:14,299] Repair session 323b9490-137e-11e4-88e3-c972e09793ca 
  for range (820981369067266915,822627736366088177] finished
[2014-07-24 22:23:14,320] Repair session 38496a61-137e-11e4-88e3-c972e09793ca 
  for range (2506042417712465541,2515941262699962473] finished
. . .
```

And an inspection of the system.log shows repair taking place only on IP addresses in DC1.

```
. . .
INFO  [AntiEntropyStage:1] 2014-07-24 22:23:10,708 RepairSession.java:171 
  - [repair #16499ef0-1381-11e4-88e3-c972e09793ca] Received merkle tree 
  for sessions from /192.168.2.101
INFO  [RepairJobTask:1] 2014-07-24 22:23:10,740 RepairJob.java:145 
  - [repair #16499ef0-1381-11e4-88e3-c972e09793ca] requesting merkle trees 
  for events (to [/192.168.2.103, /192.168.2.101])
. . .
```

**Parent topic:** [The nodetool utility](../../cassandra/tools/toolsNodetool.md)

