# sstablerepairedset {#toolsSStabRepairedSet .task}

The sstablerepairedset utility will reset the level to 0 on a given set of SSTables.

This tool is intended to mark specific SSTables as repaired or unrepaired. It is used to set the `repairedAt` status on a given set of SSTables. This metadata facilitates incremental repairs. It can take in the path to an individual SSTable or the path to a file containing a list of SSTables paths.

**Warning:** Do not run this command until you have stopped Cassandra on the node.

Use this tool in the process of [migrating a Cassandra installation to incremental repair](../operations/opsRepairNodesMigration.md).

Usage:

-   Package installations: 

    ```screen
    $ sstablerepairedset [--really-set] [--is-repaired | --is-unrepaired] [-f sstable-list | sstables]
    ```

-   Tarball installations:

    ```screen
    $ cd install\_location/tools
    $ bin/sstablerepairedset [--really-set] [--is-repaired | --is-unrepaired] [-f sstable-list | sstables]
    ```


-    

-   Choose SSTables to mark as repaired.

    ```screen
    $ sstablerepairedset --really-set --is-repaired data/data/cycling/cyclist\_name-a882dca02aaf11e58c7b8b496c707234/la-1-big-Data.db
    ```

-   Use a file to list the SSTable to mark as unrepaired.

    ```screen
    $ /sstablerepairedset --is-unrepaired -f repairSetSSTables.txt
    ```

    A file like repairSetSSTables.txt would contain a list of SSTable \(`.db`\) files, as in the following example:

    ```screen
    /data/data/cycling/cyclist\_by\_country-82246fc065ff11e5a4c58b496c707234/ma-1-big-Data.db
    /data/data/cycling/cyclist\_by\_birthday-8248246065ff11e5a4c58b496c707234/ma-1-big-Data.db
    /data/data/cycling/cyclist\_by\_birthday-8248246065ff11e5a4c58b496c707234/ma-2-big-Data.db
    /data/data/cycling/cyclist\_by\_age-8201305065ff11e5a4c58b496c707234/ma-1-big-Data.db
    /data/data/cycling/cyclist\_by\_age-8201305065ff11e5a4c58b496c707234/ma-2-big-Data.db
    
    ```

    Use the following command to list all the `Data.db` files in a keyspace:

    ```screen
    find '/home/user/datastax-ddc-3.2.0/data/data/keyspace1/' -iname "*Data.db*"
    ```


**Parent topic:** [SSTable utilities](../../cassandra/tools/toolsSSTableUtilitiesTOC.md)

