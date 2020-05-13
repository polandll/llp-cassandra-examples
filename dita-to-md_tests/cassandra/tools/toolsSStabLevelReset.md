# sstablelevelreset {#toolsSStabLevelReset .task}

The sstablelevelreset utility will reset the level to 0 on a given set of SSTables.

Reset level to 0 on a given set of SSTables that use LeveledCompactionStrategy.

Usage:

-   Package installations: `$ sstablelevelreset [--really-reset] keyspace table`
-   Tarball installations:

    ```screen
    $ cd install\_location/tools
    $ bin/sstablelevelreset [--really-reset] keyspace table
    ```


The option `--really-reset` is a warning that Cassandra is stopped before the tool is run.

-   Stop Cassandra on the node. Choose a keyspace and table to reset to level 0.

    ```language-bash
    sstablelevelreset --really-reset cycling cyclist_name
    ```

    If the designated table is already at level 0, then no change occurs. If the SSTable is releveled, the metadata is rewritten to designate the level to 0.


**Parent topic:** [SSTable utilities](../../cassandra/tools/toolsSSTableUtilitiesTOC.md)

