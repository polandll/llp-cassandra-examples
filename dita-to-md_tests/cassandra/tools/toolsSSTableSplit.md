# sstablesplit {#toolsSSTableSplit .task}

Use this tool to split SSTables files into multiple SSTables of a maximum designated size.

Use this tool to split SSTables files into multiple SSTables of a maximum designated size. For example, if SizeTieredCompactionStrategy was used for a major compaction and results in a excessively large SSTable, it's a good idea to split the table because won't get compacted again until the next huge compaction.

Cassandra must be stopped to use this tool:

-   Package installations: 

    ```language-bash
    sudo service cassandra stop
    ```

-   Tarball installations: 

    ```language-bash
    ps auwx | grep cassandra
    ```


Usage:

-   Package installations: $ sstablesplit \[options\] <filename\> \[<filename\>\]\*
-   Tarball installations:

    ```screen
    $ cd install\_location/tools/bin
    sstablesplit [options] <filename> [<filename>]*
    ```


Example:

```screen
$ sstablesplit -s 40 /var/lib/cassandra/data/data/Keyspace1/Standard1/*
```

|Flag|Option|Description|
|----|------|-----------|
||--debug|Display stack traces.|
|-h|--help|Display help.|
| |--no-snapshot|Do not snapshot the SSTables before splitting.|
|-s|--size <size\>|Maximum size in MB for the output SSTables \(default: 50\).|
|-v|--verbose|Verbose output.|

**Parent topic:** [SSTable utilities](../../cassandra/tools/toolsSSTableUtilitiesTOC.md)

