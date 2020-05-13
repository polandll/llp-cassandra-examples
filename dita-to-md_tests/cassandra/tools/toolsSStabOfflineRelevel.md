# sstableofflinerelevel {#toolsSStabOfflineRelevel .task}

The sstableofflinerelevel utility will relevel SSTables.

This tool is intended to run in an offline fashion. When using the `LevelledCompactionStrategy`, it is possible for the number of SSTables in level L0 to become excessively large, resulting in read latency degrading. This is often the case when atypical write load is experienced \(eg. bulk import of data, node bootstrapping\). This tool will relevel the SSTables in an optimal fashion. The `--dry run` flag can be used to run in test mode and examine the tools results.

Usage:

-   Package installations: `$ sstableofflinerelevel [--dry-run] keyspace table`
-   Tarball installations:

    ```screen
    $ cd install\_location/tools
    $ bin/sstableofflinerelevel [--dry-run] keyspace table
    ```


1.  Choose a keyspace and table to relevel.

    ```language-bash
    sstableofflinerelevel cycling cyclist_name
    ```


**Parent topic:** [SSTable utilities](../../cassandra/tools/toolsSSTableUtilitiesTOC.md)

