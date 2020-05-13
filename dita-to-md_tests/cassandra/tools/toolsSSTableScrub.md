# sstablescrub {#toolsSSTableScrub .task}

An offline version of nodetool scrub. It attempts to remove the corrupted parts while preserving non-corrupted data.

The sstablescrub utility is an offline version of [nodetool scrub](toolsScrub.md). It attempts to remove the corrupted parts while preserving non-corrupted data. Because sstablescrub runs offline, it can correct errors that `nodetool scrub` cannot. If an SSTable cannot be read due to corruption, it will be left on disk.

If scrubbing results in dropping rows, new SSTables become unrepaired. However, if no bad rows are detected, the SSTable keeps its original `repairedAt` field, which denotes the time of the repair.

1.  Before using `sstablescrub`, try rebuilding the tables using `nodetool scrub`.

    If `nodetool scrub` does not fix the problem, use this utility.

2.  [Shut down the node](../initialize/referenceStartStopTOC.md).

3.  Run the utility:

    -   Package installations: 

        ```screen
        $ sstablescrub [options] keyspace table
        ```

    -   Tarball installations: 

        ```screen
        $ cd install\_location
        $ bin/sstablescrub [options] keyspace table
        ```

    |Flag|Option|Description|
    |----|------|-----------|
    ||--debug|Display stack traces.|
    |-h|--help|Display help.|
    |-m|--manifest-check|Only check and repair the leveled manifest, without actually scrubbing the SSTables.|
    |-s|--skip-corrupted|Skip corrupt rows in counter tables.|
    |-v|--verbose|Verbose output.|


**Parent topic:** [SSTable utilities](../../cassandra/tools/toolsSSTableUtilitiesTOC.md)

