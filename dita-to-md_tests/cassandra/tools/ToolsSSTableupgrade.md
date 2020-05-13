# sstableupgrade {#ToolsSSTableupgrade .task}

Upgrade the SSTables in the specified table or snapshot to match the currently installed version of Cassandra.

This tool rewrites the SSTables in the specified table to match the currently installed version of Cassandra.

If restoring with [sstableloader](toolsBulkloader.md), you must upgrade your snapshots before restoring for any snapshot taken in a major version older than the major version that Cassandra is currently running.

Usage:

-   Package installations: 

    ```screen
    $ sstableupgrade [options] keyspace table [snapshot]
    ```

-   Tarball installations: 

    ```screen
    $ cd install\_location
    $ bin/sstableupgrade [options] keyspace table [snapshot]
    ```


The snapshot option only upgrades the specified snapshot.

|Flag|Option|Description|
|----|------|-----------|
||--debug|Display stack traces.|
|-h|--help|Display help.|

**Parent topic:** [SSTable utilities](../../cassandra/tools/toolsSSTableUtilitiesTOC.md)

