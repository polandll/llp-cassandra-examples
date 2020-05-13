# sstableutil {#toolsSStabUtil .task}

The sstableutil utility will list the SSTable files for a provided table.

The sstableutil will list the SSTable files for a provided table.

Usage:

-   Package installations: `$ sstableutil [--cleanup | --debug | --help | --opslog | --type <arg> | --verbose] keyspace | table`
-   Tarball installations:

    ```screen
    $ cd install\_location$ bin/sstableutil [--cleanup | --debug | --help | --opslog | --type <arg> | --verbose] keyspace | table
    ```


**Note:** Arguments for -`-type` option are: all, tmp, or final.

1.  Choose a table fof which to list SSTables files.

    ```language-bash
    sstableutil --all cycling cyclist_name
    ```


**Parent topic:** [SSTable utilities](../../cassandra/tools/toolsSSTableUtilitiesTOC.md)

