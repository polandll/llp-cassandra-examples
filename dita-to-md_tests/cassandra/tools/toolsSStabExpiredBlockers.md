# sstableexpiredblockers {#toolsSStabExpiredBlockers .task}

The sstableexpiredblockers utility will reveal blocking SSTables that prevent an SSTable from dropping.

During compaction, Cassandra can drop entire SSTables if they contain only expired tombstones and if it is guaranteed to not cover any data in other SSTables. This diagnostic tool outputs all SSTables that are blocking other SSTables from being dropped.

Usage:

-   Package installations: `$ sstableexpiredblockers [--dry-run] keyspace table`
-   Tarball installations:

    ```screen
    $ cd install\_location/tools
    $ bin/sstableexpiredblockers [--dry-run] keyspace table
    ```


1.  Choose a keyspace and table to check for any SSTables that are blocking the specified table from dropping.

    ```language-bash
    sstableexpiredblockers cycling cyclist_name
    ```


**Parent topic:** [SSTable utilities](../../cassandra/tools/toolsSSTableUtilitiesTOC.md)

