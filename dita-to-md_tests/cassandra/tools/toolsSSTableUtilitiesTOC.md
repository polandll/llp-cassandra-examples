# SSTable utilities {#toolsSSTableUtilitiesTOC}

Tools for using, upgrading, and changing Cassandra SSTables.

-   **[sstabledump](../../cassandra/tools/ToolsSSTabledump.md)**  
Dump the contents of the specified SSTable in JSON format
-   **[sstableexpiredblockers](../../cassandra/tools/toolsSStabExpiredBlockers.md)**  
The sstableexpiredblockers utility will reveal blocking SSTables that prevent an SSTable from dropping.
-   **[sstablekeys](../../cassandra/tools/toolsSStabkeys.md)**  
The sstablekeys utility dumps table keys.
-   **[sstablelevelreset](../../cassandra/tools/toolsSStabLevelReset.md)**  
The sstablelevelreset utility will reset the level to 0 on a given set of SSTables.
-   **[sstableloader \(Cassandra bulk loader\)](../../cassandra/tools/toolsBulkloader.md)**  
Provides the ability to bulk load external data into a cluster, load existing SSTables into another cluster with a different number of nodes or replication strategy, and restore snapshots.
-   **[sstablemetadata](../../cassandra/tools/toolsSSTableMetadata.md)**  
 The sstablemetadata utility prints metadata about a specified SSTable.
-   **[sstableofflinerelevel](../../cassandra/tools/toolsSStabOfflineRelevel.md)**  
The sstableofflinerelevel utility will relevel SSTables.
-   **[sstablerepairedset](../../cassandra/tools/toolsSStabRepairedSet.md)**  
The sstablerepairedset utility will reset the level to 0 on a given set of SSTables.
-   **[sstablescrub](../../cassandra/tools/toolsSSTableScrub.md)**  
An offline version of nodetool scrub. It attempts to remove the corrupted parts while preserving non-corrupted data.
-   **[sstablesplit](../../cassandra/tools/toolsSSTableSplit.md)**  
Use this tool to split SSTables files into multiple SSTables of a maximum designated size.
-   **[sstableupgrade](../../cassandra/tools/ToolsSSTableupgrade.md)**  
Upgrade the SSTables in the specified table or snapshot to match the currently installed version of Cassandra.
-   **[sstableutil](../../cassandra/tools/toolsSStabUtil.md)**  
The sstableutil utility will list the SSTable files for a provided table.
-   **[sstableverify](../../cassandra/tools/toolsSStabVerify.md)**  
The sstableverify utility will verify the SSTable for a provided table.

**Parent topic:** [Cassandra tools](../../cassandra/tools/toolsTOC.md)

