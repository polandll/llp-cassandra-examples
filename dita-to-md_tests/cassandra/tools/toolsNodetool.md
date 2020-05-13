# The nodetool utility {#toolsNodetool}

A list of the available commands for managing a cluster.

-   **[About the nodetool utility](../../cassandra/tools/toolsAboutNodetool.md)**  
A command line interface for managing a cluster.
-   **[nodetool assassinate](../../cassandra/tools/toolsAssassinate.md)**  
Forcefully removes a dead node without re-replicating any data. It is a last resort tool if you cannot successfully use nodetool removenode.
-   **[nodetool bootstrap](../../cassandra/tools/toolsBootstrap.md)**  
Monitor and manage a node's bootstrap process.
-   **[nodetool cfhistograms](../../cassandra/tools/toolsCfHistogramsRedirect.md)**  
This tool has been renamed.
-   **[nodetool cfstats](../../cassandra/tools/toolsCfStatsRedirect.md)**  
This tool has been renamed.
-   **[nodetool cleanup](../../cassandra/tools/toolsCleanup.md)**  
Cleans up keyspaces and partition keys no longer belonging to a node.
-   **[nodetool clearsnapshot](../../cassandra/tools/toolsClearSnapShot.md)**  
Removes one or more snapshots.
-   **[nodetool compact](../../cassandra/tools/toolsCompact.md)**  
Forces a major compaction on one or more tables.
-   **[nodetool compactionhistory](../../cassandra/tools/toolsCompactionHistory.md)**  
Provides the history of compaction operations.
-   **[nodetool compactionstats](../../cassandra/tools/toolsCompactionStats.md)**  
Provide statistics about a compaction.
-   **[nodetool decommission](../../cassandra/tools/toolsDecommission.md)**  
Deactivates a node by streaming its data to another node.
-   **[nodetool describecluster](../../cassandra/tools/toolsDescribeCluster.md)**  
Provide the name, snitch, partitioner and schema version of a cluster
-   **[nodetool describering](../../cassandra/tools/toolsDescribeRing.md)**  
Provides the partition ranges of a keyspace.
-   **[nodetool disableautocompaction](../../cassandra/tools/toolsDisableAutoCompaction.md)**  
Disables autocompaction for a keyspace and one or more tables.
-   **[nodetool disablebackup](../../cassandra/tools/toolsDisableBackup.md)**  
Disables incremental backup.
-   **[nodetool disablebinary](../../cassandra/tools/toolsDisableBinary.md)**  
Disables the native transport.
-   **[nodetool disablegossip](../../cassandra/tools/toolsDisableGossip.md)**  
Disables the gossip protocol.
-   **[nodetool disablehandoff](../../cassandra/tools/toolsDisableHandoff.md)**  
Disables storing of future hints on the current node.
-   **[nodetool disablehintsfordc](../../cassandra/tools/toolsDisablehintsfordc.md)**  
 Disable hints for a datacenter.
-   **[nodetool disablethrift](../../cassandra/tools/toolsDisableThrift.md)**  
Disables the Thrift server.
-   **[nodetool drain](../../cassandra/tools/toolsDrain.md)**  
Drains the node.
-   **[nodetool enableautocompaction](../../cassandra/tools/toolsEnableAutoCompaction.md)**  
Enables autocompaction for a keyspace and one or more tables.
-   **[nodetool enablebackup](../../cassandra/tools/toolsEnableBackup.md)**  
Enables incremental backup.
-   **[nodetool enablebinary](../../cassandra/tools/toolsEnableBinary.md)**  
Re-enables native transport.
-   **[nodetool enablegossip](../../cassandra/tools/toolsEnableGossip.md)**  
Re-enables gossip.
-   **[nodetool enablehandoff](../../cassandra/tools/toolsEnableHandoff.md)**  
Re-enables the storing of future hints on the current node.
-   **[nodetool enablehintsfordc](../../cassandra/tools/toolsEnablehintsfordc.md)**  
 Enable hints for a datacenter.
-   **[nodetool enablethrift](../../cassandra/tools/toolsEnableThrift.md)**  
Re-enables the Thrift server.
-   **[nodetool failuredetector](../../cassandra/tools/toolsFailureDetector.md)**  
Shows the failure detector information for the cluster.
-   **[nodetool flush](../../cassandra/tools/toolsFlush.md)**  
Flushes one or more tables from the memtable.
-   **[nodetool gcstats](../../cassandra/tools/toolsGcstats.md)**  
Print garbage collection \(GC\) statistics.
-   **[nodetool getcompactionthreshold](../../cassandra/tools/toolsGetCompactionThreshold.md)**  
Provides the minimum and maximum compaction thresholds in megabytes for a table.
-   **[nodetool getcompactionthroughput](../../cassandra/tools/toolsGetcompactionthroughput.md)**  
Print the throughput cap \(in MB/s\) for compaction in the system.
-   **[nodetool getendpoints](../../cassandra/tools/toolsGetEndPoints.md)**  
Provides the IP addresses or names of replicas that own the partition key.
-   **[nodetool getlogginglevels](../../cassandra/tools/toolsGetLogLev.md)**  
Get the runtime logging levels.
-   **[nodetool getsstables](../../cassandra/tools/toolsGetSstables.md)**  
Provides the SSTables that own the partition key.
-   **[nodetool getstreamthroughput](../../cassandra/tools/toolsGetStreamThroughput.md)**  
Provides the Mb per second outbound throughput limit for streaming in the system.
-   **[nodetool gettimeout](../../cassandra/tools/toolsGettimeout.md)**  
Print the timeout value of the given type in milliseconds.
-   **[nodetool gettraceprobability](../../cassandra/tools/toolsGetTraceProbability.md)**  
Get the probability for tracing a request.
-   **[nodetool gossipinfo](../../cassandra/tools/toolsGossipInfo.md)**  
Provides the gossip information for the cluster.
-   **[nodetool help](../../cassandra/tools/toolsHelp.md)**  
Provides nodetool command help.
-   **[nodetool info](../../cassandra/tools/toolsInfo.md)**  
Provides node information, such as load and uptime.
-   **[nodetool invalidatecountercache](../../cassandra/tools/toolsInvalidatecountercache.md)**  
Resets the global counter cache parameter, counter\_cache\_keys\_to\_save, to the default \(not set\), which saves all keys.
-   **[nodetool invalidatekeycache](../../cassandra/tools/toolsInvalidateKeyCache.md)**  
Resets the global key cache parameter to the default, which saves all keys.
-   **[nodetool invalidaterowcache](../../cassandra/tools/toolsInvalidateRowCache.md)**  
Resets the global key cache parameter, row\_cache\_keys\_to\_save, to the default \(not set\), which saves all keys.
-   **[nodetool join](../../cassandra/tools/toolsJoin.md)**  
Causes the node to join the ring.
-   **[nodetool listsnapshots](../../cassandra/tools/toolsListSnapShots.md)**  
Lists snapshot names, size on disk, and true size.
-   **[nodetool move](../../cassandra/tools/toolsMove.md)**  
Moves the node on the token ring to a new token.
-   **[nodetool netstats](../../cassandra/tools/toolsNetstats.md)**  
Provides network information about the host.
-   **[nodetool pausehandoff](../../cassandra/tools/toolsPauseHandoff.md)**  
Pauses the hints delivery process
-   **[nodetool proxyhistograms](../../cassandra/tools/toolsProxyHistograms.md)**  
Provides a histogram of network statistics.
-   **[nodetool rangekeysample](../../cassandra/tools/toolsRangeKeySample.md)**  
Provides the sampled keys held across all keyspaces.
-   **[nodetool rebuild](../../cassandra/tools/toolsRebuild.md)**  
Rebuilds data by streaming from other nodes.
-   **[nodetool rebuild\_index](../../cassandra/tools/toolsRebuildIndex.md)**  
Performs a full rebuild of the index for a table
-   **[nodetool refresh](../../cassandra/tools/toolsRefresh.md)**  
Loads newly placed SSTables onto the system without a restart.
-   **[nodetool refreshsizeestimates](../../cassandra/tools/toolsRefreshSizeEstimates.md)**  
Refresh system.size\_estimates table.
-   **[nodetool reloadtriggers](../../cassandra/tools/toolsReloadTriggers.md)**  
Reloads trigger classes.
-   **[nodetool relocatesstables](../../cassandra/tools/toolsRelocateSSTables.md)**  
Rewrites any SSTable that contains tokens that should be in another data directory.
-   **[nodetool removenode](../../cassandra/tools/toolsRemoveNode.md)**  
Provides the status of current node removal, forces completion of pending removal, or removes the identified node.
-   **[nodetool repair](../../cassandra/tools/toolsRepair.md)**  
Repairs one or more tables.
-   **[nodetool replaybatchlog](../../cassandra/tools/toolsReplaybatchlog.md)**  
Replay batchlog and wait for finish.
-   **[nodetool resetlocalschema](../../cassandra/tools/toolsResetLocalSchema.md)**  
Reset the node's local schema and resynchronizes.
-   **[nodetool resumehandoff](../../cassandra/tools/toolsResumeHandoff.md)**  
Resume hints delivery process.
-   **[nodetool ring](../../cassandra/tools/toolsRing.md)**  
Provides node status and information about the ring.
-   **[nodetool scrub](../../cassandra/tools/toolsScrub.md)**  
Rebuild SSTables for one or more Cassandra tables.
-   **[nodetool setcachecapacity](../../cassandra/tools/toolsSetCacheCapacity.md)**  
Set global key and row cache capacities in megabytes.
-   **[nodetool setcachekeystosave](../../cassandra/tools/toolsSetCacheKeysToSave.md)**  
Sets the number of keys saved by each cache for faster post-restart warmup.
-   **[nodetool setcompactionthreshold](../../cassandra/tools/toolsSetCompactionThreshold.md)**  
Sets minimum and maximum compaction thresholds for a table.
-   **[nodetool setcompactionthroughput](../../cassandra/tools/toolsSetCompactionThroughput.md)**  
Sets the throughput capacity for compaction in the system, or disables throttling.
-   **[nodetool sethintedhandoffthrottlekb](../../cassandra/tools/toolsSetHHthrottle.md)**  
Sets hinted handoff throttle in kb/sec per delivery thread.
-   **[nodetool setlogginglevel](../../cassandra/tools/toolsSetLogLev.md)**  
Set the log level for a service.
-   **[nodetool setstreamthroughput](../../cassandra/tools/toolsSetStreamThroughput.md)**  
Sets the throughput capacity in Mb for outbound streaming in the system, or disables throttling.
-   **[nodetool settimeout](../../cassandra/tools/toolsSettimeout.md)**  
Set the specified timeout in milliseconds, or 0 to disable timeout.
-   **[nodetool settraceprobability](../../cassandra/tools/toolsSetTraceProbability.md)**  
Sets the probability for tracing a request.
-   **[nodetool snapshot](../../cassandra/tools/toolsSnapShot.md)**  
Take a snapshot of one or more keyspaces, or of a table, to backup data.
-   **[nodetool status](../../cassandra/tools/toolsStatus.md)**  
Provide information about the cluster, such as the state, load, and IDs.
-   **[nodetool statusbackup](../../cassandra/tools/toolsStatusBackup.md)**  
Provide the status of backup.
-   **[nodetool statusbinary](../../cassandra/tools/toolsStatusBinary.md)**  
Provide the status of native transport.
-   **[nodetool statusgossip](../../cassandra/tools/toolsStatusGossip.md)**  
Provide the status of gossip.
-   **[nodetool statushandoff](../../cassandra/tools/toolsStatusHandoff.md)**  
Provides the status of hinted handoff.
-   **[nodetool statusthrift](../../cassandra/tools/toolsStatusThrift.md)**  
Provide the status of the Thrift server.
-   **[nodetool stop](../../cassandra/tools/toolsStop.md)**  
Stops the compaction process.
-   **[nodetool stopdaemon](../../cassandra/tools/toolsStopDaemon.md)**  
Stops the cassandra daemon.
-   **[nodetool tablehistograms](../../cassandra/tools/toolsTablehisto.md)**  
Provides statistics about a table that could be used to plot a frequency function.
-   **[nodetool tablestats](../../cassandra/tools/toolsTablestats.md)**  
Provides statistics about one or more tables.
-   **[nodetool toppartitions](../../cassandra/tools/toolsToppartitions.md)**  
Samples database reads and writes and reports the most active partitions in a specified table.
-   **[nodetool tpstats](../../cassandra/tools/toolsTPstats.md)**  
Provides usage statistics of thread pools.
-   **[nodetool truncatehints](../../cassandra/tools/toolsTruncateHints.md)**  
Truncates all hints on the local node, or truncates hints for the one or more endpoints.
-   **[nodetool upgradesstables](../../cassandra/tools/toolsUpgradeSstables.md)**  
Rewrites SSTables for tables that are not running the current version of Cassandra.
-   **[nodetool viewbuildstatus](../../cassandra/tools/toolsViewBuildStatus.md)**  
Shows the progress of a materialized view build.
-   **[nodetool verify](../../cassandra/tools/toolsVerify.md)**  
Verify \(check data checksum for\) one or more tables.
-   **[nodetool version](../../cassandra/tools/toolsVersion.md)**  
Provides the version number of Cassandra running on the specified node.

**Parent topic:** [Cassandra tools](../../cassandra/tools/toolsTOC.md)

